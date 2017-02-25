OUTPUT = tamar

# run: build
# 	./release/bin/$(OUTPUT)

.cabal-sandbox:
	cabal sandbox init

build: .cabal-sandbox
	nix-shell --command 'cabal install'

.PHONY : clean
clean:
	rm -r .cabal-sandbox

.PHONY : shell
shell: .cabal-sandbox
	nix-shell
