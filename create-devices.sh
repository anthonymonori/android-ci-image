# Nexus 6P, API 25, XXXHDPI
echo no | avdmanager --verbose create avd --force \
                                --name "Nexus6P" \
                                --package "system-images;android-25;google_apis;x86" \
                                --sdcard 200M \
                                --device 11
