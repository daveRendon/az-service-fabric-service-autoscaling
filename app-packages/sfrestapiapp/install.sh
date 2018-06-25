#!/bin/bash

sfctl application upload --path sfrestapiapp --show-progress
sfctl application provision --application-type-build-path sfrestapiapp
sfctl application create --app-name fabric:/sfrestapiapp --app-type sfrestapiappType --app-version 1.0.0
