#!/bin/bash
i=1
source ./utils.sh
while [ $i -gt 0 ];
do
    echo "Enter choice:"
    echo "1)Create a new key"
    echo "2)List all keys"
    echo "3)Delete a key"
    echo "4)Make a signing key"
    echo "5)exit"
    read ch
    case $ch in
        1)
        generate_key
        ;;
        2)
        list_keys
        ;;
        3)
        delete_key
        ;;
        4)
        change_signkey
        ;;
        5)
        ((i--))
        ;;
        *)
        echo "Wrong choice! Please choose again"
        ;;
    esac
done

