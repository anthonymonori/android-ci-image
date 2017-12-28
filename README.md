# android-fastlane-image

Container set up with build tools in order to run Android builds in a Docker setup.

## Contains

- Base: [phusion/baseimage](https://hub.docker.com/r/phusion/baseimage/)
- Ruby: 2.2.8
- RubyGems: 2.6.6
- Bundler: 1.12.5
- Java8 JDK: _latest as-of 27.12.2017_
- Fastlane: 2.64.0
- Node.js: 9.3.0
- Yarn: 1.3.2
- [android-packages.txt](./android-packages.txt)
- [dependencies.txt](./dependencies.txt)

## Usage

### Including this in your ci.yml

```Dockerfile
image: anthonymonori/android-ci-image:latest
```

_Note: Currently supporting Travis CI and GitLab CI._

### Creating a docker container

```Shell
docker login
docker pull anthonymonori/android-ci-image:latest
docker run -it -d -p <port>:<port-internal> --name <container-name> anthonymonori/android-ci-image:latest
```

_Note: of course, you need to change \<port>,\<port-internal>,\<container-name> to run the above command lines. You also might want to enable the <port> variable on whatever cloud solutions you are running._

### Gradle

Because the Fastlane [gradle action](https://github.com/fastlane/fastlane/blob/master/fastlane/lib/fastlane/actions/gradle.rb) is used, bundling Gradle into this Docker image would always take priority over the `gradlew` coming with your project. This de-coupling is helpful so we don't need to update and depend on this image, but rather let the incoming project to have its gradle wrapper execute the tasks. **It is necessary to use gradle 2.2.0 and above in order to auto-download missing SDK packages and tools during build-time**. You can specify this in your top-level build.gradle file, under dependencies:

```Shell
dependencies {
  classpath 'com.android.tools.build:gradle:2.2+'
}
```

[Read more](https://developer.android.com/studio/intro/update.html#download-with-gradle)

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