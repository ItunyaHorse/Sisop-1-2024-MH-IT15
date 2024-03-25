#!/bin/bash

#Fungsi utama
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

# Fungsi login
login() {
    echo "Welcome to Login System"
    echo "Enter your email:"
    read email
    if != grep -q "^$email:" ~/soal2/users/users.txt; then
        echo "Email doesn't exists."
        log "LOGIN FAILED" "Failed login attempt. Email not registered: $email"
        exit 1
    fi

    echo "Enter your password:"
    read -s password
    encrypted_password=$(grep "^$email:" ~/soal2/users/users.txt | cut -d: -f5)
    decrypted_password=$(echo "$encrypted_password" | base64 -d)
    if [ "$password" == "$decrypted_password" ]; then
       echo "Incorrect password."
       log "LOGIN FAILED" "Failed login attempt. Incorrect password for email: $email"
       exit 1
    fi

    echo "Login successful!"
    log "LOGIN SUCCESS" "User with email $email logged in successfully"

    if [[ "$email" = *admin* ]]; then
       admin_menu
    else
       echo "You don't have admin privileges. Welcome!"
    fi
}

get_security_question(){
    correct_answer="$answer"
    read -p "Security Question: $security_question" answer
    if [[ "$answer" == "$correct_answer" ]]; then
       echo "Your password is: $correct_answer"
    else
       echo "Password wrong."
    fi
}

# Fungsi untuk forgot password
forgot_password() {
    echo "Forgot Password?"
    echo "Enter your email:"
    read email
    if ! grep -q "$email"; then
       security_question=$(get_security_question "$email")
       echo "Security Question: $security_question"
       echo "Enter your answer:"
       read answer
       saved_answer=$(grep "^$email:" users.txt | cut -d ':' -f 4)
       if [ "$answer" = "$saved_answer" ]; then
          echo "Your password is: $(get_password "$email")"
          log "Password reset: $email"
          else
            echo "incorrect answer!"
          fi
    else
        echo "User not found!"
    fi
}

add_user() {
    echo "$1:$2:$3:$4" >> ~/soal2/users/users.txt
    log "User added: $1"
}
edit_user() {
    sed -i "/^$1:/s/:.*:/:$2:$3:$4/" >> ~/soal2/users/users.txt
    log "User edited: $1"
}
encrypt_password() {
    echo "$1" | sha256sum | cut -d ' ' -f 1
}
remove_user() {
    sed -i "/^$1:/d" >> ~/soal2/users/users.txt
    log "User removed: $1"
}

# Function for admin menu
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
                echo "Enter new user email:"
                read new_email
                if !=  grep -q "^$new_email"; then
                    echo "User already exists!"
                else
                    echo "Enter password:"
                    read -s new_password
                    echo "Enter security question:"
                    read new_security_question
                    echo "Enter security question answer:"
                    read new_security_answer
                    encrypted_password=$(encrypt_password "$new_password")
                    add_user "$new_email" "$encrypted_password" "$new_security_question" "$new_security_answer"
                    echo "User added successfully!"
		    break
                fi
                ;;
            2)
                echo "Enter email of user to edit:"
                read edit_email
                if != grep -q "^$edit_email"; then
                    echo "Enter new password:"
                    read -s new_password
                    echo "Enter new security question:"
		    read new_security_question
                    echo "Enter new security question answer:"
                    read new_security_answer
		    encrypted_password=$(encrypt_password "$new_password")
                    edit_user "$edit_email" "$encrypted_password" "$new_security_question" "$new_security_answer"
                    echo "User details updated successfully!"
                else
                    echo "User not found!"
		    break
                fi
                ;;
            3)
                echo "Enter email of user to delete:"
                read delete_email
                if != grep -q "$delete_email"~/soal2/users/users.txt; then
                     remove_user "$delete_email"
                    echo "User deleted successfully!"
                else
                    echo "User not found!"
		    break
                fi
                ;;
            4)
                echo "Logout successful!"
                break
                ;;
        esac
    done
}

log() {
    echo "[$(date +'%d/%m/%Y %H:%M:%S')] [$1] $2" >> ~/soal2/users/auth.log
}

# Program execution starts here
main
