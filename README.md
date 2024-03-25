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
![image](https://drive.google.com/uc?export=view&id=1Tx4lzv4OE2sRsir1fNOWDm6xnqTE6Dbh/view?usp=sharing)
