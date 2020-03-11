#!/bin/bash

pandoc -s -o ./automation-demo.pdf -V geometry:margin=.60in -V documentclass=report -V linkcolor=blue ./Readme.md 