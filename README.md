![Docker Pulls](https://img.shields.io/docker/pulls/anthonymonori/android-ci-image?label=docker%20pulls%20%28latest%29&style=flat-square) | ![Docker Image Version (latest by date)](https://img.shields.io/docker/v/anthonymonori/android-ci-image?label=latest%20stable%20versioin&style=flat-square) | ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/anthonymonori/android-ci-image/latest?style=flat-square)

# android-fastlane-image

Container set up with build tools in order to run Android builds in a Docker setup.

## Contains

- Base: [phusion/baseimage:focal-1.0.0](https://hub.docker.com/r/phusion/baseimage/)
- Java11 JDK: _latest as-of 21.08.2021_
- [android-packages.txt](./android-packages.txt)
- [dependencies.txt](./dependencies.txt)

## Usage

### Including this in your ci.yml

```Dockerfile
image: anthonymonori/android-ci-image:<version>
```

_Note: to find the latest version, please navigate to the [Releases](https://github.com/anthonymonori/android-ci-image/releases) tab._

### Creating a docker container

```Shell
docker login
docker pull anthonymonori/android-ci-image:<version>
docker run -it -d -p <port>:<port-internal> --name <container-name> anthonymonori/android-ci-image:latest
```

_Note: of course, you need to change \<port>,\<port-internal>,\<container-name> to run the above command lines. You also might want to enable the <port> variable on whatever cloud solutions you are running._


## Build image

```Shell
docker build .
```

## Deploy image

```Shell
docker push anthonymonori/android-ci-image
```

## Problems

Use the `Issues` tab above.