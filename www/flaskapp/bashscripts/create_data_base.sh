#!/bin/bash


if [ "$#" -ne 3 ]; then
    echo "Utilizare: $0 <nume_baza_de_date> <nume_utilizator_mysql> <parola_utilizator>"
    exit 1
fi


dbname=$1
dbuser=$2
dbpass=$3



adminpass="Eva1Japo2@"

mysql -u root -p"$adminpass" -e "CREATE DATABASE \`$dbname\`;"
if [ $? -eq 0 ]; then
    echo "Baza de date '$dbname' a fost creată cu succes!"
else
    echo "A apărut o eroare la crearea bazei de date '$dbname'."
    exit 1
fi


sudo mysql -u root  -p"$adminpass" -e "CREATE USER '$dbuser'@'%' IDENTIFIED BY '$dbpass';"
if [ $? -eq 0 ]; then
    echo "Utilizatorul MySQL '$dbuser' a fost creat cu succes!"
else
    echo "A apărut o eroare la crearea utilizatorului MySQL '$dbuser'."
    exit 1
fi


sudo mysql -u root -p"$adminpass" -e "GRANT ALL PRIVILEGES ON \`$dbname\`.* TO '$dbuser'@'%';"
if [ $? -eq 0 ]; then
    echo "Toate privilegiile au fost acordate utilizatorului '$dbuser' pentru baza de date '$dbname'."
else
    echo "A apărut o eroare la acordarea privilegiilor pentru utilizatorul '$dbuser'."
    exit 1
fi


sudo mysql -u root  -p"$adminpass" -e "FLUSH PRIVILEGES;"

echo "Operațiunea s-a încheiat cu succes."
