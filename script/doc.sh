#!/bin/bash
cd ..
rake diagram:all
mogrify  -format png doc/*.svg
rm doc/*.svg