# Docker GLIMPSE

A ready to go [GLIMPSE](https://odelaneau.github.io/GLIMPSE/) docker image.

Usage:

```bash
docker run -it --name glimpse ghcr.io/amanas/docker-glimpse:1.1.1_v1
```

## Versions

* [samtools](https://github.com/samtools/samtools) 1.14
* [htslib](http://www.htslib.org/) 1.11
* [boost](https://www.boost.org/doc/libs/1_73_0/) 1.73.0
* [bcftools](https://samtools.github.io/bcftools/bcftools.html) 1.9
* [GLIMPSE](https://odelaneau.github.io/GLIMPSE/installation.html) 1.1.1
* [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) 364.0.0

## Build and publish

Just in case you want to fork this repo and create your own distro:

```bash
docker build . -t ghcr.io/<you>/docker-glimpse:<whatever>
docker push ghcr.io/<you>/docker-glimpse:<whatever>
```
