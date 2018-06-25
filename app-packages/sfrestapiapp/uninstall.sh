#!/bin/bash

sfctl application delete --application-id sfrestapiapp
sfctl application unprovision --application-type-name sfrestapiappType --application-type-version 1.0.0
sfctl store delete --content-path sfrestapiapp
