Fastlane Documentation
================

# Firebase Distribution

| **Configuration** | **Command**                                      |
|-------------------|--------------------------------------------------|
| Debug             | bundle exec fastlane firebase_distribute_debug   |
| Testing           | bundle exec fastlane firebase_distribute_testing |
| Staging           | bundle exec fastlane firebase_distribute_staging |
| Release           | bundle exec fastlane firebase_distribute_release |


# TestFlight Distribution

## Automatic Version Increment

| **Configuration** | **Command**                                        |
|-------------------|----------------------------------------------------|
| Debug             | bundle exec fastlane testflight_distribute_debug   |
| Testing           | bundle exec fastlane testflight_distribute_testing |
| Staging           | bundle exec fastlane testflight_distribute_staging |
| Release           | bundle exec fastlane testflight_distribute_release |

# Synchronizing Certificates & Provisioning Profiles

To download the provisioning profiles from Git run:

`bundle exec fastlane run_match --verbose`

To regenerate the provisioning profiles run :

`bundle exec fastlane run_match_force --verbose`

# GymFile

to create `Gymfile`, run in terminal `fastlane gym init`.

# Common Error

If you encounter error `Unable to locate Xcode. Please make sure to have Xcode installed on your machine`
run this in terminal `sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer`.

# Regenerate Match Certificates

`bundle exec fastlane run_match_development_force --verbose`
`bundle exec fastlane run_match_appstore_force --verbose`

# Uploading dSYM files to Crashlytics

https://firebase.blog/posts/2021/09/uploading-dSYM-files-to-crashlytics-with-fastlane