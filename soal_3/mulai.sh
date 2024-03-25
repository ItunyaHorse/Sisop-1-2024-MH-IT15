#!/bin/bash
wget -O Genshin.zip 'https://drive.google.com/uc?export=download&id=1oGHdTf4_76_RacfmQIV4i7os4sGwa9vN'
unzip -o "*.zip"
unzip -o "*.zip"
cd genshin_character
for file in *.jpg;
 do
    new_name=$(echo $file | xxd -r -p)
    mv -- "$file" "$new_name.jpg"

    baru=$(awk -F, "/$new_name/"'{OFS=0;print $2 "-" $1 "-" $3 "-" $4}' ../list_character.csv)
    mv -- "$new_name.jpg" "$baru.jpg"
done

mkdir Mondstat Liyue Inazuma Sumeru Fontaine

for file in *.jpg;
 do
 negara=$(echo $file | awk -F "-" '{print $1}')
 if [ "$negara" == "Mondstat" ]; then
 mv "$file" "Mondstat"
 elif [ "$negara" == "Liyue" ]; then
 mv "$file" "Liyue"
 elif [ "$negara" == "Sumeru" ]; then
 mv "$file" "Sumeru"
 elif [ "$negara" == "Inazuma" ]; then
 mv "$file" "Inazuma"
 else
 mv "$file" "Fontaine"
fi
 done

cd ..
awk '
BEGIN {}
/Bow/ { ++b }
/Catalyst/ { ++c }
/Claymore/  { ++c2 }
/Polearm/ { ++p }
/Sword/ { ++s }
END { print "Bow:" b "\nCatalyst:" c "\nCatalyst:" c2 "\nPolearm:" p "\nSword:" s }' list_character.csv

rm *.zip *.csv
