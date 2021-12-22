# Docker GLIMPSE

A ready to go [GLIMPSE](https://odelaneau.github.io/GLIMPSE/) docker image.

Usage:

```bash
docker run -it ghcr.io/amanas/docker-glimpse:1.1.1
```

## Versions

* [htslib](http://www.htslib.org/) 1.11
* [boost](https://www.boost.org/doc/libs/1_73_0/) 1.73.0
* [bcftools](https://samtools.github.io/bcftools/bcftools.html) 1.9
* [GLIMPSE](https://odelaneau.github.io/GLIMPSE/installation.html) 1.1.1

## Build and publish

Just in case you want to fork this repo and create your own distro:

```bash
docker build . -t ghcr.io/<you>/docker-glimpse:<whatever>
docker push ghcr.io/<you>/docker-glimpse:<whatever>
```
