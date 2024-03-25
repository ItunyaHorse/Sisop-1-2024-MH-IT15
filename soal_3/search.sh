#!/bin/bash

cd genshin_character
for folder in *;
do
 for file in $folder/*;
  do
  steghide extract -sf "$file" -xf "$file.txt" -p "" -q
  rahasia=$(cat "$file.txt")
  waktu=$(date +"%d/%m/%y %H:%M:%S")
  alamat=$(realpath "$file.txt")

  if [[ $rahasia == 68747470 ]];
  then
  echo "[$waktu] [FOUND] [$alamat]"
  exit 
  else
  echo "[$waktu] [NOT FOUND] [$alamat]" 
  rm "$file.txt"
  fi >> image.log

  sleep 1
  done
done
  mv "image.log" ".." 
