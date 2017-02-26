OUTPUT = tamar

default:
	if test '$(IN_NIX_SHELL)' = '1'; \
		then cabal build;\
		else make release;\
	fi;

build/default.nix: $(OUTPUT).cabal
	cabal2nix . > build/default.nix

release: build/default.nix
	nix-build build/release.nix

.PHONY: install
install: build/default.nix
	nix-env -i build/release.nix

.PHONY : clean
clean:
	rm -f release
	rm build/default.nix

.PHONY : shell
shell: build/default.nix
	nix-shell -A $(OUTPUT).env build/release.nix
