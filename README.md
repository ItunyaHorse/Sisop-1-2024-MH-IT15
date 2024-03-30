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

## Soal no 2
Dikerjakan oleh **Veri Rahman (5027231088)**

Pada soal nomor 2 ini, kita diminta membuat 2 program yaitu login dan register.
```bash
check_email() {
    local email="$1"
    if grep -q "^$email:" ~/soal2/users/users.txt; then
        return 0
    else
        return 1
    fi
}
```
Kode check email diatas berfungsi untuk mengecek apakah email sudah terdaftar atau belum. Variabel local digunakan agar email tidak menjadi variabel global, kemudian fungsi conditional if berfungsi mengecek email jika terdaftar maka return 0 dan apabila belum terdaftar maka return 1.

```bash
register() {
    echo "Welcome to Registration System"
    echo "Enter your email:"
    read email

    if check_email "$email"; then
        echo "Email is already registered."
        log "REGISTER FAILED" "Registration failed. Email already exists: $email"
        exit 1
    fi

    # Cek apakah email mengandung kata "admin"
    if [[ "$email" == *admin* ]]; then
        type_user="admin"
    else
        type_user="user"
    fi

    echo "Enter your username:"
    read username

    echo "Enter a security question:"
    read security_question
echo "Enter the answer to your security question:"
    read security_answer

    while true; do
        echo "Enter a password (minimum 8 characters,at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol, and not same as username, birthdate, or name"
        read -s password
        if [[ ${#password} -ge 8 && "$password" =~ [A-Z] && "$password" =~ [a-z] && "$password" =~ [0-9] && "$password" =~ [[:punct:]] && "$password" != "$username" && "$password" != "$security_answer" ]]; then
            echo "User registered successfully!"
            break
        else
            echo "Password does not meet criteria,Please try again."
        fi
    done
```
Kode diatas adalah kode register yang diminta. Kode ini terlebih dahulu memasukkan email, username, pertanyaan keamanan dan jawabannya, serta password. Kode "if check_email "$email" merujuk pada kode diatas dan apabila sudah terdaftar maka register gagal. Kode"if [[ "$email" == *admin* ]]" berfungsi mengecek apabila email mengandung kata admin maka akan menjadi tipe user admin, lalu kode " if [[ ${#password} -ge 8 && "$password" =~ [A-Z] && "$password" =~ [a-z] && "$password" =~ [0-9] && "$password" =~ [[:punct:]] && "$password" != "$username" && "$password" != "$security_answer" ]]" berfungsi memberikan syarat minimal password yang akan dibuat kemudian apabila tidak memenuhi kriteria maka harus diulang kembali.

```bash
    encrypted_password=$(echo -n "$password" | base64)

    echo "Email: $email, Username: $username, Security question: $security_question, Security answer: $security_answer, Encrypted password: $encrypted_password, Type user: $type_user" >> ~/soal2/users/users.txt
    log "REGISTER SUCCESS" "User [$username] registered successfully"
}

log() {
    echo "[$(date +'%d/%m/%Y %H:%M:%S')] [$1] $2" >> ~/soal2/users/auth.log
}

# Panggil fungsi registrasi
register
```
"encrypted_password" berfungsi menyembunyikan password asli menjadi huruf dan angka acak, kemudian kode dibawahnya berfungsi menyimpan data register ke dalam users.txt dan log berfungsi mencatat semua register yang dilakukan.

Output:

![image](https://drive.google.com/uc?export=view&id=1JcTfnXq8srN3l3rlCKLvyogorq8EtHza)

```bash
main() {
    echo "Welcome to Login System"
    echo "1. Login"
    echo "2. Forgot Password"
    read choice

    case $choice in
        1)
            login
            ;;
        2)
            forgot_password
            ;;
    esac
}
```
Kode diatas merupakan fungsi utama untuk bisa login atau forgot password.

Output:

![image](https://drive.google.com/uc?export=view&id=1QIajBNdsIDwVravKKbF-DD03hguWX-SG)

```bash
login() {
    echo "Enter your email:"
    read email

    if check_email "$email"; then
        echo "Email doesn't exist."
        log "LOGIN FAILED" "Failed login attempt. Email not registered: $email"
    	exit 1
    fi

    echo "Enter your password:"
    read -s password

    encrypted_password=$(grep "^$email:" ~/soal2/users/users.txt | cut -d: -f2)
    hashed_password=$(encrypt_password "$password")

    if [ "$encrypted_password" == "$hashed_password" ]; then
        echo "Incorrect password."
        log "LOGIN FAILED" "Failed login attempt. Incorrect password for email: $email"
        exit 1
    fi

    echo "Login successful!"
    log "LOGIN SUCCESS" "User with email $email logged in successfully"

    if [[ "$email" == *admin* ]]; then
        admin_menu
    else
        echo "You don't have admin privileges. Welcome!"
    fi
}
```
Kode login berfungsi untuk masuk ke email yang telah diregister tadi. fungsi conditional if digunakan pada " if check_email "$email"" berfungsi untukk mengecek apakah email tersedia atau tidak apabila tidak maka login gagal. lalu "if [ "$encrypted_password" == "$hashed_password" ]" berfungsi untuk mengecek apakah password sama apabila sama maka login berhasil.

Output:

![image](https://drive.google.com/uc?export=view&id=1IIIr7A8H1RBO5jLxAN5vTLaB2GG8cMOz)

```bash
 admin_menu() {
    while true; do
        echo "Admin Menu:"
        echo "1. Add User"
        echo "2. Edit User"
        echo "3. Delete User"
        echo "4. Logout"
        read admin_choice

        case $admin_choice in
            1)
                add_user
                ;;
            2)
                edit_user
                ;;
            3)
                delete_user
                ;;
            4)
                echo "Logout successful!"
                break
                ;;
        esac
    done
}

add_user() {
    echo "Enter new user email:"
    read new_email

    if check_email "$new_email"; then
        echo "User already exists!"
        return 1
    fi

    echo "Enter password:"
    read -s new_password

    echo "Enter security question:"
    read new_security_question

    echo "Enter security question answer:"
    read new_security_answer

    encrypted_password=$(encrypt_password "$new_password")

    echo "$new_email:$encrypted_password:$new_security_question:$new_security_answer" >> ~/soal2/users/users.txt
    log "USER ADDED" "New user added with email: $new_email"
    echo "User added successfully!"
    exit
}

edit_user() {
    echo "Enter email of user to edit:"
    read edit_email

    if ! check_email "$edit_email"; then
        echo "User not found!"
        return 1
    fi

    echo "Enter new password:"
    read -s new_password

    echo "Enter new security question:"
    read new_security_question

    echo "Enter new security question answer:"
    read new_security_answer

    encrypted_password=$(encrypt_password "$new_password")

    sed -i "s/^$edit_email:.*/$edit_email:$encrypted_password:$new_security_question:$new_security_answer/" ~/soal2/users/users.txt
    log "USER EDITED" "User details edited for email: $edit_email"
    echo "User details updated successfully!"
    exit
}

delete_user() {
    echo "Enter email of user to delete:"
    read delete_email

    if ! check_email "$delete_email"; then
        echo "User not found!"
        return 1
    fi

    sed -i "/^$delete_email:/d" ~/soal2/users/users.txt
    log "USER DELETED" "User deleted with email: $delete_email"
    echo "User deleted successfully!"
    exit
}
```
Kode ini akan memunculkan menu admin yang terdiri dari add user, delete user. remove user, dan logout. add_user memungkinkan admin untuk menambahkan pengguna baru ke dalam database. Admin diminta untuk memasukkan informasi pengguna baru seperti email, kata sandi, pertanyaan keamanan, dan jawaban keamanan. Informasi ini kemudian disimpan dalam file database pengguna setelah dilakukan enkripsi pada kata sandi. Selain itu, fungsi ini juga mencatat tindakan penambahan pengguna baru ke dalam log.
edit_user memungkinkan admin untuk mengedit informasi pengguna yang sudah ada di dalam database. Admin diminta untuk memasukkan email pengguna yang ingin diubah, lalu mengisi informasi baru seperti kata sandi, pertanyaan keamanan, dan jawaban keamanan. Informasi yang diubah kemudian akan diperbarui dalam file database pengguna, dan tindakan ini juga dicatat dalam log.
delete_user memungkinkan admin untuk menghapus pengguna dari database. Admin diminta untuk memasukkan email pengguna yang ingin dihapus, dan setelah itu, pengguna tersebut akan dihapus dari file database pengguna. Seperti halnya fungsi lainnya, tindakan penghapusan pengguna juga dicatat dalam log.

Output:

![image](https://drive.google.com/uc?export=view&id=1PhgaAK_Abvp_OYWS5wXRb5FlbecZdPgP)


```bash
get_security_question() {
    local email=$1
    local security_question=$(grep "^$email:" ~/soal2/users/users.txt | cut -d: -f3)
    echo "$security_question"
}

forgot_password() {
    echo "Forgot Password?"
    echo "Enter your email:"
    read email

    if ! check_email "$email"; then
        echo "User not found!"
        exit 1
    fi

    security_question=$(get_security_question "$email")
    echo "Security Question: $security_question"

    echo "Enter your answer:"
    read answer

    saved_answer=$(grep "^$email:" ~/soal2/users/users.txt | cut -d: -f4)

    if [ "$answer" != "$saved_answer" ]; then
        echo "Incorrect answer!"
        exit 1
    fi

    echo "Your password is: $(decrypt_password "$email")"
    log "PASSWORD RESET" "Password reset for email: $email"
}

decrypt_password() {
    local email=$1
    local encrypted_password=$(grep "^$email:" ~/soal2/users/users.txt | cut -d: -f2)
    echo "$encrypted_password" | base64 -d
}
```
Kode ini untuk menjalankan program forgot password yang berisi email, pertanyaan keamanan dan jawaban, lalu apabila benar maka akan memunculkan password email tersebut. Fungsi "get_security_question()" ini mengambil pertanyaan keamanan yang terkait dengan email pengguna yang diberikan. Pertanyaan keamanan ini diperoleh dari file database pengguna dengan mencocokkan email yang diberikan dengan entri yang sesuai dalam file tersebut. Pertanyaan keamanan kemudian diambil dari entri yang ditemukan. Fungsi "forgot_password()"  memungkinkan pengguna untuk mereset kata sandi jika mereka lupa. Pengguna diminta untuk memasukkan email mereka, kemudian pertanyaan keamanan terkait ditampilkan dan pengguna diminta untuk menjawabnya. Jawaban yang diberikan oleh pengguna dibandingkan dengan jawaban yang disimpan dalam database. Jika jawaban sesuai, kata sandi yang lupa akan ditampilkan. Fungsi "decrypt_password()" bertanggung jawab untuk mendekripsi kata sandi yang terenkripsi dari file database pengguna. Pertama, fungsi ini mengambil kata sandi terenkripsi dari file database berdasarkan email pengguna yang diberikan. Kemudian, kata sandi tersebut didekripsi menggunakan base64 dan hasilnya dikembalikan.

Pada soal no 2 ini, saya mengalami masalah pada edit user, delete user, dan forgot password

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

```bash
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
```
Pada command selanjutnya, pertama-tama, kita membuat folder untuk region-region agar file file tersebut bisa dimasukkan ke dalam folder sesuai dengan nama filenya. Di kode ini, loop for digunakan memproses setiap file yang terdapat di folder genshin_character. Perintah awk mengekstrak informasi region dari list_character.csv. Perintah if memindahkan file-file jpg tersebut ke folder sesuai dengan regionnya masing-masing.  

Terakhir, pada script ini, kita disuruh untuk menghitung jumlah senjata dan menghapus beberapa file. Maka dari itu, digunakan awk untuk menghitung jumlah senjata yang ada di list_character.scv tersebut. Sedangkan untuk menghapus file file tidak pentingnya, kita bisa menggunakan fungsi rm untuk membuang file file bertipe zip dan csv.

```bash
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
```
Pada script search.sh ini, script diawali dengan cd genshin_character untuk berpindah ke folder genshin_character tempat file gambar yang dicurigai mengandung pesan tersembunyi berada. Loop for folder in * digunakan untuk iterasi melalui semua folder di dalam genshin_character. Variabel folder akan berisi nama masing-masing folder yang akan diproses. 


Loop for file in $folder/* digunakan untuk iterasi melalui semua file di dalam folder yang sedang diproses (folder yang didapat dari loop sebelumnya). Variabel file akan berisi path lengkap dari setiap file yang akan diperiksa. Perintah steghide extract -sf "$file" -xf "$file.txt" -p "" -q digunakan untuk mengekstraksi pesan tersembunyi dari file gambar $file. Dengan penjelasan sebagai berikut:
        -sf : opsi untuk menentukan file sumber (source file) yang akan diekstraksi pesannya.
        -xf : opsi untuk menentukan file keluaran (extraction file) tempat menyimpan pesan yang diekstraksi.
        -p "" : opsi untuk password (kosong dalam kasus ini).
        -q : opsi untuk menjalankan perintah secara diam (quiet mode).

Baris rahasia=$(cat "$file.txt") digunakan untuk membaca isi file hasil ekstraksi ($file.txt) dan menyimpannya ke variabel rahasia.Perintah waktu=$(date +"%d/%m/%y %H:%M:%S") digunakan untuk mendapatkan tanggal dan waktu saat ini, disimpan ke variabel waktu dengan format "HH/MM/YYYY HH:MM:SS".
Perintah alamat=$(realpath "$file.txt") digunakan untuk mendapatkan path lengkap dari file hasil ekstraksi ($file.txt) secara absolut (resolved path), disimpan ke variabel alamat.
Perintah if [[ $rahasia == 68747470 ]] digunakan untuk mengecek isi variabel rahasia. [[ ... ]] adalah operator conditional expression untuk melakukan pengecekan.
$rahasia == 68747470 membandingkan isi rahasia dengan nilai heksadesimal dari string "http" (68 74 74 70). Jika kondisi if terpenuhi (pesan tersembunyi ditemukan):

    Script akan menampilkan pesan "[$waktu] [FOUND] [$alamat]" yang menunjukkan waktu, status "FOUND" (ditemukan), dan path lengkap file hasil ekstraksi.
    Perintah exit digunakan untuk menghentikan keseluruhan script setelah pesan tersembunyi pertama ditemukan.
    
Jika kondisi if tidak terpenuhi (pesan tersembunyi tidak ditemukan):

    Script akan menampilkan pesan "[$waktu] [NOT FOUND] [$alamat]" yang menunjukkan waktu, status "NOT FOUND" (tidak ditemukan), dan path lengkap file hasil ekstraksi. Perintah rm "$file.txt" digunakan untuk menghapus file hasil ekstraksi sementara.

Seluruh output (baik pesan "FOUND" atau "NOT FOUND") akan diarahkan ke file "image.log" menggunakan operator pengalihan output >>. Perintah sleep 1 digunakan untuk memberikan jeda selama 1 detik di antara proses pemeriksaan file. Setelah selesai memeriksa semua file di dalam semua folder, script akan memindahkan file log "image.log" ke folder di atas folder genshin_character menggunakan perintah mv "image.log" "..". 

Soal ini tidak dapat saya selesaikan. Hal ini disebabkan karena saya mengalami suatu kendala berupa tidak bisa menemukan file yang tersebunyi di dalam jpg tersebut. 

## Soal no 4
Dikerjakan oleh **semua**

```bash
mem=$(free -m | awk 'NR==2 {print $2","$3","$4","$5","$6","$7}')
swap=$(free -m | awk 'NR==3 {print $2","$3","$4}')
waktu=$(date +"%Y%m%d%H%M%S")
```

kode "free -m" itu untuk display metricsnya

kode "awk 'NR==2 {print $2","$3","$4","$5","$6","$7}'" dan kode "awk 'NR==3 {print $2","$3","$4}'" itu untuk mengambil data dari metrics tadi

kode "date +"%Y%m%d%H%M%S"" itu untuk mengambil tanggal dan waktu

```bash
echo 'mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size' >> metrics_$waktu.log
echo "$mem,$swap,/home/mken,$(du -sh /home/mken | awk '{print $1}')" >> metrics_$waktu.log

mv metrics_$waktu.log /home/mken/log
```

kode "echo 'mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size' >> metrics_$waktu.log" ini untuk menambahkan baris header ke file log metrics_$waktu.log dan menentukan nama-nama metrik yang akan dicatat

kode "echo "$mem,$swap,/home/mken,$(du -sh /home/mken | awk '{print $1}')" >> metrics_$waktu.log" itu untuk menambahkan metrik penggunaan memori dan disk bersama dengan jalur "/home/mken" dan ukurannya ke dalam file log

kode "mv metrics_$waktu.log /home/mken/log" itu untuk memindahkan file log "metrics_$waktu.log" ke dalam direktori "/home/mken/log"

```bash
jam=$(date -d '1 hour ago' +"%Y%m%d%H")
```

kode "jam=$(date -d '1 hour ago' +"%Y%m%d%H")" menyimpan tanggal dan waktu saat ini dikurangi satu jam dalam format YYYYMMDDHH ke dalam variabel jam

```bash
echo 'mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size' >> metrics_agg_$jam.log
```

kode "echo 'mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size' >> metrics_agg_$jam.log" menambahkan baris header dengan nama kolom ke file bernama metrics_agg_$jam.log.

```bash
for file in /home/mken/log/*;
do
 if [[ $file = *$jam* ]]
 then
 cat $file | awk 'NR==2 {print}' >> hourly_log.txt
 fi
done
```

Perulangan for mengulang setiap file di direktori /home/mken/log/

kondisi "if [[ $file = *$jam* ]]" memeriksa apakah nama file mengandung nilai yang disimpan dalam variabel jam

kode "cat $file | awk 'NR==2 {print}' >> hourly_log.txt" mengekstrak baris kedua dari setiap file log dan menambahkannya ke file bernama hourly_log.txt.

```bash
mina=$(awk -F ',' '{print $1}' hourly_log.txt | sort -n | head -1)
minb=$(awk -F ',' '{print $2}' hourly_log.txt | sort -n | head -1)
minc=$(awk -F ',' '{print $3}' hourly_log.txt | sort -n | head -1)
mind=$(awk -F ',' '{print $4}' hourly_log.txt | sort -n | head -1)
mine=$(awk -F ',' '{print $5}' hourly_log.txt | sort -n | head -1)
minf=$(awk -F ',' '{print $6}' hourly_log.txt | sort -n | head -1)
ming=$(awk -F ',' '{print $7}' hourly_log.txt | sort -n | head -1)
minh=$(awk -F ',' '{print $8}' hourly_log.txt | sort -n | head -1)
mini=$(awk -F ',' '{print $9}' hourly_log.txt | sort -n | head -1)
minj=$(awk -F ',' '{print $11}' hourly_log.txt | sort -n | head -1)

echo "minimum,$mina,$minb,$minc,$mind,$mine,$minf,$ming,$minh,$mini,/home/mken,$minj" >> metrics_agg_$jam.log

maxa=$(awk -F ',' '{print $1}' hourly_log.txt | sort -n | tail -1)
maxb=$(awk -F ',' '{print $2}' hourly_log.txt | sort -n | tail -1)
maxc=$(awk -F ',' '{print $3}' hourly_log.txt | sort -n | tail -1)
maxd=$(awk -F ',' '{print $4}' hourly_log.txt | sort -n | tail -1)
maxe=$(awk -F ',' '{print $5}' hourly_log.txt | sort -n | tail -1)
maxf=$(awk -F ',' '{print $6}' hourly_log.txt | sort -n | tail -1)
maxg=$(awk -F ',' '{print $7}' hourly_log.txt | sort -n | tail -1)
maxh=$(awk -F ',' '{print $8}' hourly_log.txt | sort -n | tail -1)
maxi=$(awk -F ',' '{print $9}' hourly_log.txt | sort -n | tail -1)
maxj=$(awk -F ',' '{print $11}' hourly_log.txt | sort -n | tail -1)

echo "maximum,$maxa,$maxb,$maxc,$maxd,$maxe,$maxf,$maxg,$maxh,$maxi,/home/mken,$maxj" >> metrics_agg_$jam.log


jumlaha=0
totala=0
for i in $(awk -F ',' '{print $1}' hourly_log.txt)
   do
     totala=$(($totala+$i))
     ((jumlaha++))
   done
rataa=$(($totala/$jumlaha)) 

jumlahb=0
totalb=0
for i in $(awk -F ',' '{print $2}' hourly_log.txt)
   do
     totalb=$(($totalb+$i))
     ((jumlahb++))
   done
ratab=$(($totalb/$jumlahb))

jumlahc=0
totalc=0
for i in $(awk -F ',' '{print $3}' hourly_log.txt)
   do
     totalc=$(($totalc+$i))
     ((jumlahc++))
   done
ratac=$(($totalc/$jumlahc))

jumlahd=0
totald=0
for i in $(awk -F ',' '{print $4}' hourly_log.txt)
   do
     totald=$(($totald+$i))
     ((jumlahd++))
   done
ratad=$(($totald/$jumlahd))

jumlahe=0
totale=0
for i in $(awk -F ',' '{print $5}' hourly_log.txt)
   do
     totale=$(($totale+$i))
     ((jumlahe++))
   done
ratae=$(($totale/$jumlahe))

jumlahf=0
totalf=0
for i in $(awk -F ',' '{print $6}' hourly_log.txt)
   do
     totalf=$(($totalf+$i))
     ((jumlahf++))
   done
rataf=$(($totalf/$jumlahf))

jumlahg=0
totalg=0
for i in $(awk -F ',' '{print $7}' hourly_log.txt)
   do
     totalg=$(($totalg+$i))
     ((jumlahg++))
   done
ratag=$(($totalg/$jumlahg))

jumlahh=0
totalh=0
for i in $(awk -F ',' '{print $8}' hourly_log.txt)
   do
     totalh=$(($totalh+$i))
     ((jumlahh++))
   done
ratah=$(($totalh/$jumlahh))

jumlahi=0
totali=0
for i in $(awk -F ',' '{print $9}' hourly_log.txt)
   do
     totali=$(($totali+$i))
     ((jumlahi++))
   done
ratai=$(($totali/$jumlahi))

jumlahj=0
totalj=0
for i in $(awk -F ',' '{print $11}' hourly_log.txt)
   do
     totalj=$(($totalj+$i))
     ((jumlahj++))
   done
rataj=$(($totalj/60))

echo "average,$rataa,$ratab,$ratac,$ratad,$ratae,$rataf,$ratag,$ratai,/home/mken,$rataj" >> metrics_agg_$jam.log

rm hourly_log.txt
```

Kemudian skrip melanjutkan untuk mengekstrak nilai minimum, maksimum, dan rata-rata untuk setiap kolom (kemungkinan mewakili berbagai metrik seperti penggunaan memori, penggunaan swap, dll.) dari hourly_log.txt menggunakan perintah awk dan sort. Untuk setiap kolom, nilai minimum dan maksimum ditambahkannya ke file metrics_agg_$jam.log. Akhirnya, skrip menghapus file sementara hourly_log.txt.

untuk mengotomatiskan skrip yang pertama tinggal menggunakan config cron:
```bash
# * * * * * /home/mken/SISOPraktikum/soal_4/minute_log.sh
```

untuk mengotomatiskan skrip yang kedua tinggal menggunakan config cron:
```bash
# 0 * * * * /home/mken/SISOPraktikum/soal_4/aggregate_minutes_to_hourly_log.sh
```

## Revisi

no 2 di fix dan no 4 baru dikerjakan
