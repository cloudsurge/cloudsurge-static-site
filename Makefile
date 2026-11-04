# Local development helpers only.
#
# Deployment is handled entirely by .github/workflows/pages.yml — nothing in
# this file runs in CI, and nothing here needs to be committed to deploy.
#
# Everything runs inside a Docker container by default, so the only local
# requirement is Docker. Pass NATIVE=1 to use a local Ruby toolchain instead.

PORT      ?= 4000
IMAGE     ?= ruby:3.3
LIVERELOAD = 35729

ifeq ($(NATIVE),1)
RUN   :=
SERVE :=
else
# Run as the invoking user so build output isn't left root-owned, with gems
# cached in vendor/bundle (gitignored) so they survive between runs.
RUN := docker run --rm \
	-v "$(CURDIR)":/site -w /site \
	--user $(shell id -u):$(shell id -g) \
	-e HOME=/tmp -e BUNDLE_PATH=/site/vendor/bundle \
	-e JEKYLL_ENV \
	$(IMAGE)
# Only `serve` needs ports published; keeping them off other targets lets
# `make build` run while a server is already up.
SERVE := docker run --rm -it \
	-v "$(CURDIR)":/site -w /site \
	--user $(shell id -u):$(shell id -g) \
	-e HOME=/tmp -e BUNDLE_PATH=/site/vendor/bundle \
	-p $(PORT):$(PORT) -p $(LIVERELOAD):$(LIVERELOAD) \
	$(IMAGE)
endif

.PHONY: help install serve build clean

help:
	@echo "make serve    Run at http://localhost:$(PORT), rebuilding on change"
	@echo "make build    Build once into _site/"
	@echo "make install  Install gem dependencies"
	@echo "make clean    Remove build output and caches"
	@echo ""
	@echo "All targets run in Docker ($(IMAGE)); add NATIVE=1 to use local Ruby."

install:
	$(RUN) bundle install

# --host 0.0.0.0 is required for the port mapping to reach Jekyll when this
# runs in a container; it's harmless natively.
serve: install
	$(SERVE) bundle exec jekyll serve --host 0.0.0.0 --port $(PORT) --livereload

build: install
	$(RUN) bundle exec jekyll build

clean:
	rm -rf _site .jekyll-cache .jekyll-metadata
