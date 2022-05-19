#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
# truncate all data in customers and rentals, for NOW

echo -e "\n~~~~~ MY SALON ~~~~~\n"

SERVICE_MENU () {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  else
    echo -e "Welcome to my salon, how can I help you?\n"
  fi

  SERVICES_RESULT=$($PSQL "SELECT service_id, name FROM services ")
  if [[ -z $SERVICES_RESULT ]]
  then
    echo -e "\nWe offer no services at this time."
  else
    echo "$SERVICES_RESULT" | while read SERV_ID BAR NAME
    do
      echo "$SERV_ID) $NAME"
    done
  fi

  # Get input from user
  read SERVICE_ID_SELECTED
  # Check if service_id is valid
  if [[ ! $SERVICE_ID_SELECTED =~ ^[0-9]+$ ]]
  then
    SERVICE_MENU "I could not find that service. What would you like today?"
  else
    SERVICE_QUERY_RESULT=$($PSQL "SELECT * FROM services WHERE service_id=$SERVICE_ID_SELECTED ")
    if [[ -z $SERVICE_QUERY_RESULT ]]
    then
      SERVICE_MENU "I could not find that service. What would you like today?"
    else
      # For whatever reason piping an echo command doesn't work with simple read
      # command and a while loop seems against the purpose of this assignment
      # Instead I used a here string, i.e. an expansion of a simple string
      # Hence the <<< 
      read S_ID BAR SERVICE_NAME <<< $SERVICE_QUERY_RESULT
      echo -e "\nWhat's your phone number?"
      read CUSTOMER_PHONE
      # check if customer exists
      CHECK_CUSTOMER_RESULT=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE' ")
      if [[ -z $CHECK_CUSTOMER_RESULT ]]
      then
        # Customer doesn't exist, create new customer
        echo -e "\nI don't have a record for that phone number, what's your name?"
        read CUSTOMER_NAME
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(phone, name) VALUES ('$CUSTOMER_PHONE', '$CUSTOMER_NAME') ")
        CHECK_CUSTOMER_RESULT=$($PSQL "SELECT * FROM customers WHERE phone='$CUSTOMER_PHONE' ")
      fi
      # again using a here string
      read CUSTOMER_ID BAR CUSTOMER_PHONE BAR CUSTOMER_NAME <<< $CHECK_CUSTOMER_RESULT
      echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
      # get the customer time
      read SERVICE_TIME
      INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME') ")
      echo -e "\nI have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."
    fi
  fi
}

SERVICE_MENU
