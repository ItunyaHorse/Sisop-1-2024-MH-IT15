# Soal-shift-sisop-modul-1-IT5-2024

Anggota:

1. Michael Kenneth Salim (5027231008)
2. Nicholas Emanuel Fade (5027231070)
3. Veri Rahman (5027231088)

## Soal no 1
Dikerjakan oleh **Nicholas Emanuel Fade (5027231070)**

Soal no 1 meminta kita untuk untuk membuat beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe dalam bentuk file "Sandbox.sh". Didalam kesimpulan memiliki data sebagai beirkut:

a. Tampilkan nama pembeli dengan total sales paling tinggi

b. Tampilkan customer segment yang memiliki profit paling kecil

c. Tampilkan 3 category yang memiliki total profit paling tinggi

d. Cari purchase date dan amount (quantity) dari nama adriaens

### Sandbox.sh

```bash
#1.a
highest_sales_customer=$(tail -n +2 Sandbox.csv | awk -F ',' '{print $6 "," $17}' | sort -t ',' -k2 -nr | head -n 1)

echo "a. Nama pembeli dengan total sales paling tinggi:"
echo $highest_sales_customer | cut -d ',' -f1
```
kode "tail -n +2 Sandbox.csv " itu untuk mereferensikan file Sandbox.csv

kode "awk -F ',' '{print $6 "," $17}'" itu untuk mengekstrak data dari column 6(Customer Name) dan column 17(Sales).

kode "sort -t ',' -k2 -nr" itu untuk sort kedua data yang di ekstrak bedasarkan column 17(Sales) di urutan menurun.

kode "head -n 1" itu untuk mengambil barisan paling pertama dari output sort sebelumnya.

kode "cut -d ',' -f1" itu untuk mengekstrak dan hanya mengeprint cloumn 6(Customer Name) dari barisan yang diambil sebelumnya

```bash
#1.b
lowest_profit_segment=$(tail -n +2 Sandbox.csv | awk -F ',' '{print $7 "," $20}' | sort -t ',' -k2 -n | head -n 1)

echo "b. Segment dengan profit paling kecil:"
echo $lowest_profit_segment | cut -d ',' -f1
```
kode "tail -n +2 Sandbox.csv " itu untuk mereferensikan file Sandbox.csv

kode "awk -F ',' '{print $7 "," $20}'" itu untuk mengekstrak data dari column 7(Segment) dan column 20(Profit).

kode "sort -t ',' -k2 -n" itu untuk sort kedua data yang di ekstrak bedasarkan column 20(Profit) di urutan menaik.

kode "head -n 1" itu untuk mengambil barisan paling pertama dari output sort sebelumnya.

kode "cut -d ',' -f1" itu untuk mengekstrak dan hanya mengeprint cloumn 7(Segment) dari barisan yang diambil sebelumnya

```bash
#1.c
top_profit_categories=$(tail -n +2 Sandbox.csv | awk -F ',' '{print $14 "," $20}' | sort -t ',' -k1 | awk -F ',' '{sum[$1] += $2} END {for (category in sum) print sum[category] "," category}' | sort -t ',' -k1 -nr | head -n 3 | awk -F ',' '{print $2}')

echo "c. 3 Category dengan total profit paling tinggi:"
echo "$top_profit_categories"
```
kode "tail -n +2 Sandbox.csv " itu untuk mereferensikan file Sandbox.csv

kode "awk -F ',' '{print $714"," $20}'" itu untuk mengekstrak data dari column 14(Category) dan column 20(Profit).

kode "sort -t ',' -k1" itu untuk sort kedua data yang di ekstrak bedasarkan column 14(Category).

kode "awk -F ',' '{sum[$1] += $2} END {for (category in sum) print sum[category] "," category}'" itu untuk mengkalkulasi total profit

kode "sort -t ',' -k1 -nr" itu untuk sort kedua data yang di kalkulasi sebelumnya bedasarkan column 20(Profit) di urutan menurun.

kode "head -n 3" itu untuk mengambil 3 barisan paling atas dari output sort sebelumnya.

kode "awk -F ',' '{print $2}" itu untuk mengekstrak dan hanya mengeprint column 14(Category) dari barisan yang diambil sebelumnya.

```bash
#1.d
echo "d. purchase date/order date dan amount/quantity dari nama Adriaens:"
grep "Adriaens" Sandbox.csv | awk -F ',' '{print $2 "," $18}'
```
kode "grep "Adriaens" Sandbox.csv" itu untuk mencari nama "Adriaens" di "Sandbox.csv".

kode "awk -F ',' '{print $2 "," $18}'" itu untuk mengekstrak data dari column 2(Order Date) dan column 18(Quantity).

Output:

![image](https://drive.google.com/uc?export=view&id=1Tx4lzv4OE2sRsir1fNOWDm6xnqTE6Dbh)

## Soal no 3
Dikerjakan oleh **Michael Kenneth Salim (5027231008)**

Pada soal nomer 3 ini, kita pada dasarnya membuat 2 script untuk download, rename dan decode file yang terdapat di dalamnya.

```bash
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
```
Dalam soal nomer 3 ini, kita diminta untuk download, decode, dan rename file yang memiliki format .jpg. Seperti yang bisa kita lihat di atas ini, kita menggunakan fungsi wget dan unzip untuk download file dari link yang telah diberikan dan unzip file tersebut. Mengapa terdapat 2 kali unzip? Hal ini disebabkan karena didalam file zip tersebut terdapat file zip lainnya sehingga diperlukan untuk dilakukan zip sebanyak 2x. Ditambah lagi, -o pada unzip tersebut berperan dalam overwrite data agar data yang di unzip tidak bertumpukan satu sama lain.  

Script kemudian berpindah ke folder genshin_character yang diasumsikan hasil ekstrak dari file Genshin.zip. Loop for file in *.jpg digunakan untuk memproses setiap file berekstensi .jpg di folder tersebut. Perintah xxd -r -p digunakan untuk mengubah nama file yang terisi dengan hex menjadi format teks, yang mana hasilnya disimpan di variabel new_name. Script kemudian menjalankan perintah mv untuk mengubah nama file asli menjadi $new_name.jpg. 

Baris selanjutnya menggunakan awk untuk mencari baris spesifik di file list_character.csv yang mengandung nama file $new_name. Kolom dalam file list_character.csv diasumsikan dipisahkan dengan tanda koma (","). Hasil dari awk berupa format Region-Name-Elemen-Senjata.jpg disimpan di variabel baru. Terakhir, script menggunakan mv lagi untuk mengubah nama file menjadi format yang didapat dari baru.jpg.


