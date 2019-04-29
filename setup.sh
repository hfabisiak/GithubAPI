#!/bin/sh

brew bundle
carthage bootstrap --platform iOS --cache-builds
