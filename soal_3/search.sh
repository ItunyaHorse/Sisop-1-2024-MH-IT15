#!/bin/bash

cd genshin_character
for folder in *;
do
 for file in $folder/*;
  do
  steghide extract -sf "$file" -xf "$file.txt" -p "" -q
  rahasia=$(cat "$file.txt" | base64 -d)
  waktu=$(date +"%d/%m/%y %H:%M:%S")
  alamat=$(realpath "$file.txt")

  if [[ $rahasia == *http* ]];
  then
  echo "[$waktu] [FOUND] [$alamat]"
  echo "$rahasia" > LinkKita.txt
  wget -O RahasiaKita.jpg "$rahasia"
  rm "$file.txt"
  mv "image.log" ".."
  mv "RahasiaKita.jpg" ".."
  mv "LinkKita.txt" ".."
  exit 0

  else
  echo "[$waktu] [NOT FOUND] [$alamat]"
  rm "$file.txt"
  fi >> image.log

  sleep 1
  done
done
