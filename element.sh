#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
  exit
else
  ATOMIC_QUERY=$1
fi

if [[ -z $ATOMIC_QUERY ]]
then
  echo -e "\nI could not find that element in the database."
else
  # Check if value is integer
  ATOMIC_ID=-1
  if [[ $ATOMIC_QUERY =~ ^[0-9]+$ ]]
  then
    ATOMIC_ID=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$ATOMIC_QUERY")
  else
    if [[ $ATOMIC_QUERY =~ ^[A-Za-z]{1,2}$ ]]
    then
      ATOMIC_ID=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ATOMIC_QUERY' ")
    else
      ATOMIC_ID=$($PSQL "SELECT atomic_number FROM elements WHERE name LIKE '$ATOMIC_QUERY' ")
    fi
  fi

  # Check if atomic id is received
  if [[ -z $ATOMIC_ID ]]
  then
    echo -e "I could not find that element in the database."
  else
    # Retrieve information on element queried about
    ATOMIC_INFORMATION=$($PSQL "SELECT * FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$ATOMIC_ID ")
    IFS="|"
    read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING_POINT BOILING_POINT TYPE <<< $ATOMIC_INFORMATION
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi