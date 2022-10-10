#!/bin/bash

find ./ubiquity -type f -not -path '*/\.*' -exec sed  -i -- 's/Ubuntu/Bullgharos/g' {} +

sudo cp -rf ./ubiquity/* $HOME/live-ubuntu-from-scratch/chroot/usr/share/
exit 0


#End step 1 Ubiquity
echo "End step 1 Ubiquity"
