#!/bin/bash

cd genshin_character
for folder in *;
do
 echo "$folder"
 for file in $folder/*.jpg;
  do
  steghide extract -sf "$file" -xf "$file.txt" -p "" -q
  


  sleep 1
  done
done
