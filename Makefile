OUTPUT = tamar

# run: build
# 	./release/bin/$(OUTPUT)

build/default.nix: $(OUTPUT).cabal
	cabal2nix . > build/default.nix

build:
	nix-build build/release.nix

.PHONY: install
install: build/default.nix
	nix-env -i build/release.nix

.PHONY : clean
clean:
	rm -f release
	rm build/default.nix
# rm -r .cabal-sandbox

.PHONY : shell
shell: build/default.nix
	nix-shell -A $(OUTPUT).env build/release.nix
