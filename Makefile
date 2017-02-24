OUTPUT = tamarind

# run: build
# 	./release/bin/$(OUTPUT)

build:
	nix-build release0.nix

.PHONY: install
install:
	nix-env -i release0.nix

.PHONY : clean
clean:
	rm release
# rm -r .cabal-sandbox

.PHONY : shell
shell:
	nix-shell -A env release0.nix
