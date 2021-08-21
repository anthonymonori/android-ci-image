FROM phusion/baseimage:focal-1.0.0

LABEL org.opencontainers.image.authors="anthonymonori@gmail.com"
LABEL version="2.0.0-rc01"
LABEL description="Container set up with build tools in order to run Android builds in a Docker setup."

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

## Set up Android related environment vars
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip" \
    ANDROID_HOME="/opt/android"
ENV ANDROID_SDK="${ANDROID_HOME}/sdk"
ENV PATH $PATH:$ANDROID_SDK/cmdline-tools/bin

WORKDIR /opt

# Install Dependencies
COPY dependencies.txt /var/temp/dependencies.txt
RUN dpkg --add-architecture i386 && apt-get update
RUN apt-get install -y --allow-change-held-packages $(cat /var/temp/dependencies.txt)

# Install openjdk-11-jdk 
RUN add-apt-repository -y ppa:openjdk-r/ppa \
    && apt-get update \
    && apt-get install -y openjdk-11-jdk \
    && apt-get autoremove -y \
    && apt-get clean
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

# Android SDKs
RUN mkdir android && cd android && mkdir sdk && cd sdk \
    && wget -O cmdline-tools.zip ${ANDROID_SDK_URL} \
    && unzip cmdline-tools.zip && rm cmdline-tools.zip 

# Pre-approved licenses
RUN mkdir "${ANDROID_SDK}/licenses" || true \
    && echo -e "\n24333f8a63b6825ea9c5514f83c2829b004d1fee" > "${ANDROID_SDK}/licenses/android-sdk-license" \
    && echo -e "\n84831b9409646a918e30573bab4c9c91346d8abd" > "${ANDROID_SDK}/licenses/android-sdk-preview-license" \
    && echo -e "\n33b6a2b64607f11b759f320ef9dff4ae5c47d97a" > "${ANDROID_SDK}/licenses/google-gdk-license" \
    && echo -e "\ne9acab5b5fbb560a72cfaecce8946896ff6aab9d" > "${ANDROID_SDK}/licenses/mips-android-sysimage-license" \
    && echo -e "\n859f317696f67ef3d7f30a50a5560e7834b43903" > "${ANDROID_SDK}/licenses/android-sdk-arm-dbt-license" \
    && echo -e "\n601085b94cd77f0b54ff86406957099ebe79c4d6" > "${ANDROID_SDK}/licenses/android-googletv-license"

# Copy list of Android SDK packages to be installed
COPY android-packages.txt /var/temp/android-packages.txt

# Install SDK packages
RUN mkdir ~/.android \
    && touch ~/.android/repositories.cfg \
    && sdkmanager --package_file="/var/temp/android-packages.txt" --channel=0 --sdk_root="$ANDROID_SDK" --verbose
# Cleaning
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get autoremove -y \
    && apt-get clean

# GO to workspace
RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
