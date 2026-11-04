Website for cloudsurge

## Local development

Requires Docker (the site is built inside a `ruby:3.3` container).

```sh
make build   # build once into _site/
make serve   # serve at http://localhost:4000 with live reload
make clean   # remove build output
```

Add `NATIVE=1` to any target to use a local Ruby toolchain instead of Docker.
