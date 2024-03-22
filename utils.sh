#!/bin/bash
generate_key(){
    gpg --full-generate-key
}
list_keys(){
    gpg --list-secret-keys --keyid-format=long
}
delete_key(){
    list_keys
    echo "Which key you want to delete?"
    read n
    a=($(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | awk -F/ '{print $2}') )
    if [[ $n =~ '^[0-9]+$' ]];
    then
        echo "Invalid choice"
    else
        if [[ $n -gt ${#a[@]} || $n -lt 1 ]];
        then
            echo "Invalid choice"
        else
            echo " Are you sure you want to delete? [y/n]"
            read k
            if [[ "$k" = "y" ]];
            then
                gpg --delete-key ${a[$n-1]}
                gpg --delete-secret-key ${a[$n-1]}
            else
                echo "Not deleted"
            fi

        fi
    fi

}
change_signkey(){
    list_keys
    echo "Which key do you want to convert to a signing key?"
    read n
    a=($(gpg --list-secret-keys --keyid-format=long | awk '$1 ~ /sec/ { print $2 }' | awk -F/ '{print $2}') )
    if [[ $n =~ '^[0-9]+$' ]];
    then
        echo "Invalid choice"
    else
        if [[ $n -gt ${#a[@]} || $n -lt 1 ]];
        then
            echo "Invalid choice"
        else
        git config --global user.signingkey ${a[$n-1]}
        fi
    fi
}
