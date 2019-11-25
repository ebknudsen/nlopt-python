.PHONY: all clean build repub
CWD := $(CURDIR)
VERSION := 2.6.1

all: clean build
	@echo Done!

build: build-windows build-linux
	@echo Done

clean:
	rm -rf build dist *.egg-info
	rm -f nlopt/_nlopt.* nlopt/*.dll
	rm -rf wheelhouse nlopt_src

repub:
	git tag --delete $(VERSION)
	git push --delete origin $(VERSION)
	git tag -a $(VERSION) -m "NLOpt $(VERSION)"
	git push -f
	git push -f --tags


build-windows:
	build.bat

build-linux:
	docker container run -v $(CURDIR):/app -v wheelhouse:/wheelhouse --rm danielbok/manylinux1_x86_64 /app/build.sh