{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE DeriveGeneric #-}

module Tamar where

import Data.Data
import GHC.Generics
import Data.Typeable
import Data.Profunctor
import Reflex
import Linear
import Data.Monoid hiding ((<>))
import Data.Semigroup

-- * These are expected to be positive.
data Length = Mm !Float
  deriving (Eq, Ord, Read, Show, Data, Typeable, Generic)

instance Semigroup Length where
  Mm a <> Mm b = Mm (a + b)

instance Monoid Length where
  mappend = (<>)
  mempty = Mm 0

-- * 'Rubber' represents the ability to expand to fill more of the
-- * available space.  The @Finite@ constructor represents a maximum
-- * expansion.  The @Inf@ constructors represent an affinity for
-- * unlimited expansion.  Several @Inf1@ @Rubber@s will be assigned
-- * actual lengths proportional to their @Float@ arguments, and
-- * similarly for @Inf2@ and higher..  An @Inf1@ will take all
-- * available space, leaving none for a @Finite@.  Similarly, an
-- * @Inf2@ will not leave any space for an @Inf1@.  The arguments to
-- * Inf* should be non-negative.
data Rubber = Finite Length | Inf1 Float | Inf2 Float | Inf3 Float
  deriving (Eq, Ord, Read, Show, Data, Typeable, Generic)
-- TODO test if the Ord instance does the right thing

instance Semigroup Rubber where
  Inf3 a <> Inf3 b = Inf3 (a + b)
  Inf3 a <> _ = Inf3 a
  _ <> Inf3 b = Inf3 b
  Inf2 a <> Inf2 b = Inf2 (a + b)
  Inf2 a <> _ = Inf2 a
  _ <> Inf2 b = Inf2 b
  Inf1 a <> Inf1 b = Inf1 (a + b)
  Inf1 a <> _ = Inf1 a
  _ <> Inf1 b = Inf1 b
  Finite a <> Finite b = Finite (a <> b)

instance Monoid Rubber where
  mappend = (<>)
  mempty = Finite mempty

data Elastic = Elastic {
  minLength :: Length,
  elastic :: Elastic
  }
  deriving (Eq, Ord, Read, Show, Data, Typeable, Generic)

instance Semigroup Elastic where
  a <> b = Elastic {
    minLength = minLength a <> minLength b,
    elastic = elastic a <> elastic b
    }

instance Monoid Elastic where
  mappend = (<>)
  mempty = Elastic {
    minLength = mempty,
    elastic = mempty
    }

-- * Typically instantiated either with Length or Elastic.  A
-- * 'Widget' has an origin and a size, used in layout, so we track
-- * size in four directions from the origin.
data Size a = Size {
  right :: a,
  left :: a,
  top :: a,
  bottom :: a
  }

class Render (m :: * -> *)
-- TODO implement Render

emptySize :: Monoid m => Size m
emptySize = Size mempty mempty mempty mempty

data Widget t b e = Widget {
  render :: forall m. Render m => b -> V2 Float -> m (),
  event :: Event t e,
  size :: Size Elastic
}

instance Reflex t => Profunctor (Widget t) where
  lmap f widget = widget {render = render widget . f }
  rmap f widget = widget { event = fmap f (event widget) }

data Dir = LTR | RTL | TTB | BTT

maxElastic :: [Elastic] -> Elastic
maxElastic es = Elastic {
  minLength = maximum $ fmap minLength es,
  elastic = maximum $ fmap elastic es
  }

sumSizesLTR :: [Size Elastic] -> Size Elastic
sumSizesLTR [] = emptySize
sumSizesLTR szs@(h:t) = Size {
  left = left h,
  right = right h <> mconcat (fmap left t) <> mconcat (fmap right t),
  top = maxElastic $ fmap top szs,
  bottom = maxElastic $ fmap bottom szs
  }

-- assignSize :: Rect ->

-- hbox :: [Widget t b e] -> Widget t b e
-- hbox ws = Widget {
--   render = r,
--   event = e,
--   size = sz
--   } where
--   r b rect = sequence_ [ render w b s | w <- ws | s <- childSizes ] where
--       assignSize s = s
--   sz = sumSizes $ fmap size ws
