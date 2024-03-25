#!/bin/bash

check_email() {
    local email="$1"
    if grep -q "^$email:" ~/soal2/users/users.txt; then
        return 0
    else
        return 1
    fi
}

# Fungsi untuk melakukan registrasi
register() {
    echo "Welcome to Registration System"
    echo "Enter your email:"
    read email

    if check_email "$email"; then
        echo "Email sudah terdaftar. Silakan gunakan email lain."
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
        if [[ ${#password} -ge 8 && "$password" =~ [A-Z] && "$password" =~ [a-z] && "$password" =~ [0-9] ]]; then
            echo "User registered successfully!"
            break
        else
            echo "Password does not meet criteria,Please try again."
        fi
    done

    # Encrypt password using base64
    encrypted_password=$(echo -n "$password" | base64)

    # Simpan data ke file users.txt
    echo "Email: $email, Username: $username, Security question: $security_question, Security answer: $security_answer, Encrypted password: $encrypted_password, Type user: $type_user" >> ~/soal2/users/users.txt
    log "REGISTER SUCCESS" "User [$username] registered successfully"
}

# Fungsi untuk mencatat log
log() {
    echo "[$(date +'%d/%m/%Y %H:%M:%S')] [$1] $2" >> ~/soal2/users/auth.log
}

# Panggil fungsi registrasi
register

