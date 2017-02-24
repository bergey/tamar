{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE DeriveGeneric #-}

module Tamar where

import Data.Profunctor
import Reflex
import Linear
import Data.Monoid hiding (<>)
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
  min :: Length
  elastic :: Elastic
  }
  deriving (Eq, Ord, Read, Show, Data, Typeable, Generic)

instance Semigroup Elastic where
  a <> b = Elastic {
    min = min a <> min b
    elastic = elastic a <> elastic b
    }

instance Monoid Elastic where
  mappend = (<>)
  mempty = Elastic {
    min = mempty
    elastic = mempty
    }

-- * Typically instantiated either with Length or Elastic.  A
-- * 'Widget' has an origin and a size, used in layout, so we track
-- * size in four directions from the origin.
data Size a = Size {
  right : a
  left : a
  top : a
  bottom : a
  }

data Widget t b e = {
  render :: Render m => Size -> b -> m ();
  event :: Event t e
  size : Size Elastic
}
