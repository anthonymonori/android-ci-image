# android-fastlane-image
Container set up with build tools in order to run Android builds in a Docker setup.

## Contains
- Ruby: 2.1.9
- RubyGems: 2.6.6
- Bundler: 1.12.5
- Java8 JDK: _latest as-of 18.05.2017_
- Fastlane: 2.33.0
- [android-packages.txt](./android-packages.txt)
- [dependencies.txt](./dependencies.txt)

## Usage

#### Including this in your ci.yml
```
image: anthonymonori/android-fastlane-image:latest
```

_Note: Currently supporting Travis CI and GitLab CI._

#### Creating a docker container
```
docker login
docker pull anthonymonori/android-fastlane-image:latest
docker run -it -d -p <port>:<port-internal> --name <container-name> anthonymonori/android-fastlane-image:latest
```

_Note: of course, you need to change \<port>,\<port-internal>,\<container-name> to run the above command lines. You also might want to enable the <port> variable on whatever cloud solutions you are running._

#### Gradle
Because the Fastlane [gradle action](https://github.com/fastlane/fastlane/blob/master/fastlane/lib/fastlane/actions/gradle.rb) is used, bundling Gradle into this Docker image would always take priority over the `gradlew` coming with your project. This de-coupling is helpful so we don't need to update and depend on this image, but rather let the incoming project to have its gradle wrapper execute the tasks. **It is necessary to use gradle 2.2.0 and above in order to auto-download missing SDK packages and tools during build-time**. You can specify this in your top-level build.gradle file, under dependencies:
```
dependencies {
  classpath 'com.android.tools.build:gradle:2.2+'
}
```

[Read more](https://developer.android.com/studio/intro/update.html#download-with-gradle)

#### Running androidConnectedTest
In your `.gitlab-ci.yml` file, add the following lines to ensure the virtual devices are started up:

```
- emulator <@DEVICE_NAME> -wipe-data -verbose -logcat '*:e *:w' -netfast -no-boot-anim -no-audio -no-window &&
- /opt/scripts/android-wait-for-emulator.sh
- adb shell input keyevent 82
```
Possible device names:
- `@Nexus6P`

_For the full list, please see [create-devices.sh](./create-devices.sh)_

## Build image
```
docker build .
```

## Deploy image
```
docker push anthonymonori/android-fastlane-image
```

## Problems
Use the `Issues` tab above.
