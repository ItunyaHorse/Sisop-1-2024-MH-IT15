#!/bin/bash


check_email() {
    local email=$1
    if grep -q "^$email:" ~/soal2/users/users.txt; then
        return 0
    else
        return 1
    fi
}

encrypt_password() {
    local password=$1
    echo -n "$password" | sha256sum | cut -d ' ' -f 1
}

log() {
    echo "[$(date +'%d/%m/%Y %H:%M:%S')] [$1] $2" >> ~/soal2/users/auth.log
}

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

get_security_question() {
    local email=$1
    local security_question=$(grep "^$email:" ~/soal2/users/users.txt | cut -d: -f3)
    echo "$Security_question"
}

forgot_password() {
    echo "Forgot Password?"
    echo "Enter your email:"
    read email

    if check_email "$email"; then
        echo "User not found!"
        exit 1
    fi

    security_question=$(get_security_question "$email")
    echo "Security Question: $Security_question"

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

main
