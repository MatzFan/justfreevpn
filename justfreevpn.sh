#!/bin/bash

referer="http://justfreevpn.com/"
declare -a codes=("us" "uk" "ca" "nl" "de" "hk")
temp_dir=$(mktemp -d)

for code in "${codes[@]}"
do
  image_url="$referer"/free-vpn-password/"$code"-free-vpn.gif
  filep=${temp_dir}/${code}
  wget -q --header="Referer: $referer" -O "${filep}.gif" "$image_url"
  convert -resample 300 -units PixelsPerInch "${filep}.gif ${filep}.png"
  tesseract "${filep}.png" "${filep}" > /dev/null 2>&1
  cat "${filep}.txt" # includes extra line break
done
