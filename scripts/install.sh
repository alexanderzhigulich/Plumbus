#!/bin/sh

carthage update --use-xcframeworks --platform iOS
swiftgen
xcodegen
