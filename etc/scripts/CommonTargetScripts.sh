## SwiftLint
#$PODS_ROOT/SwiftLint/swiftlint --config $PROJECT_DIR/../swiftlint.yml

echo "Running CommonTargetScript"

"${SRCROOT}/etc/swiftgen/src/bin/swiftgen" config run --config $SRCROOT/swiftgen.yml
