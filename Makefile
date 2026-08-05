# Local development helpers only.
#
# Deployment is handled entirely by .github/workflows/pages.yml — nothing in
# this file runs in CI, and nothing here needs to be committed to deploy.
#
# Uses a native Ruby toolchain if one is on PATH, otherwise falls back to
# running everything inside a Docker container.

PORT      ?= 4000
IMAGE     ?= ruby:3.3
LIVERELOAD = 35729

ifeq ($(shell command -v bundle 2>/dev/null),)
# No local Ruby. Run in Docker as the invoking user so build output isn't
# left root-owned, with gems cached in vendor/bundle (gitignored) so they
# survive between runs.
RUN := docker run --rm \
	-v "$(CURDIR)":/site -w /site \
	--user $(shell id -u):$(shell id -g) \
	-e HOME=/tmp -e BUNDLE_PATH=/site/vendor/bundle \
	-p $(PORT):$(PORT) -p $(LIVERELOAD):$(LIVERELOAD) \
	$(IMAGE)
else
RUN :=
endif

.PHONY: help install serve build clean

help:
	@echo "make serve    Run at http://localhost:$(PORT), rebuilding on change"
	@echo "make build    Build once into _site/"
	@echo "make install  Install gem dependencies"
	@echo "make clean    Remove build output and caches"

install:
	$(RUN) bundle install

# --host 0.0.0.0 is required for the port mapping to reach Jekyll when this
# runs in a container; it's harmless natively.
serve: install
	$(RUN) bundle exec jekyll serve --host 0.0.0.0 --port $(PORT) --livereload

build: install
	$(RUN) bundle exec jekyll build

clean:
	rm -rf _site .jekyll-cache .jekyll-metadata
