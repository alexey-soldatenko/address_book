#!/bin/bash

#main menu
MENU=(
      "display"
      "search"
      "add"
      "remove"
      "quit"
     )
#database
DB_FILE="adress_book.txt"
if [ -f "$DB_FILE" ]
    then 
        echo "Database is found!"
    else
        touch "$DB_FILE"
fi
echo "---------------Start---------------"

#select menu
select item in ${MENU[*]}
    do
        case $item in
            display)
                #display our db
                result="$(cat $DB_FILE)"
                if [ "$result" != "" ]
                    then
                        echo "---------Adress book----------"
                        echo "$result"
                        echo "--------------End-------------"
                else
                    echo "Adress book is empty!"
                fi
                ;;
            search)
                #search all records by word
                echo "Search by name, surname, email or phone:"
	              read name
                if [ "$name" != "" ]
                    then
                        result="$(grep -i $name $DB_FILE)"
                        if [ "$result" != "" ]
                            then 
                                echo "-------------Start-------------"
                                echo "$result"
                                echo "--------------End-------------"
                        else
                             echo "Not $name found"
                        fi
                    else
                        echo "Not data. Try yet."
                fi
                ;;
            add)
                #add new record
                echo "Enter name, surname, email, phone"
                read answer
                if [ "$answer" != "" ]
                    then
                        echo "$answer" >> adress_book.txt
                        echo "Ok"
                else
                    echo "No data. Try yet." 
                fi
                ;;
            remove)
                #remove record(s) from db
                echo "Remove by name or surname or email or phone"
                echo "Enter search word:"
                read word
                if [ "$word" != "" ]
                    then
                        result=$(grep -i $word adress_book.txt)
                        if [ "$result" != "" ]
                            then
                                echo "--------------Start-------------"
                                echo "$result"
                                echo "---------------End---------------"
                                echo "Delete? (y/n)"
                                read answer
                                case $answer in
                                    Y|y|Yes|yes)
                                        result="$(grep -v -i $word $DB_FILE)"
                                        echo "$result" > adress_book.txt
                                        echo "Ok";;
                                esac
                        fi
                else
                    echo "Not data. Try yet."
                fi
                ;;
            quit)
                #exit
                echo "Exit"
                exit 0
                ;;
        esac
done
exit 0
