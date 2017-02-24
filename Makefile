OUTPUT = tamar

# run: build
# 	./release/bin/$(OUTPUT)

default.nix: $(OUTPUT).cabal
	cabal2nix . > build/default.nix

build:
	nix-build build/release.nix

.PHONY: install
install: default.nix
	nix-env -i build/release.nix

.PHONY : clean
clean:
	rm release
# rm -r .cabal-sandbox

.PHONY : shell
shell: default.nix
	nix-shell -A $(OUTPUT).env build/release.nix
