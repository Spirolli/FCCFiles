QL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME_INPUT

if [[ ! -z $USERNAME_INPUT ]]
then
  # Check if user exists
  USER_QUERY=$($PSQL "SELECT * FROM player WHERE name='$USERNAME_INPUT' ")
  FOUND_USER=1
  if [[ -z $USER_QUERY ]]
  then
    # the user does not exist
    echo "Welcome, $USERNAME_INPUT! It looks like this is your first time here."
    USER_ENTER_RESULT=$($PSQL "INSERT INTO player(name, games_played) VALUES ('$USERNAME_INPUT', 0) ")
    USER_QUERY=$($PSQL "SELECT * FROM player WHERE name='$USERNAME_INPUT' ")
  else
    # the user does exist
    FOUND_USER=0
  fi

  IFS="|"
  read PLAYER_ID NAME GAMES_PLAYED BEST_GAME <<< "$USER_QUERY";
  if [[ $FOUND_USER == 0 ]]
  then
    echo "Welcome back, $NAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  fi

  # Do the guessing game
  echo "Guess the secret number between 1 and 1000:"
  IFS=" "
  number_of_guesses=1
  read number_guess
  while [[ ! $number_guess =~ ^[0-9]+$ ]]
  do
    # if the value is not a number
    echo "That is not an integer, guess again:"
    read number_guess
  done
  NUMBER_TO_GUESS=$RANDOM
  let "NUMBER_TO_GUESS %= 1001"
  while [[ $NUMBER_TO_GUESS -ne $number_guess ]]
  do
    if [[ $NUMBER_TO_GUESS -lt $number_guess ]]
    then
      echo "It's lower than that, guess again:"
    fi
    if [[ $NUMBER_TO_GUESS -gt $number_guess ]]
    then
      echo "It's higher than that, guess again:"
    fi
    # Get input from user again
    read number_guess
    let "number_of_guesses += 1"
    while [[ ! $number_guess =~ ^[0-9]+$ ]]
      do
        # if the value is not a number
        echo "That is not an integer, guess again:"
        read number_guess
      done
  done
  echo "You guessed it in $number_of_guesses tries. The secret number was $NUMBER_TO_GUESS. Nice job!"
  
  if [[ $number_of_guesses -lt $BEST_GAME ]]
  then
    BEST_GAME=$number_of_guesses
  fi
  let "GAMES_PLAYED += 1"
  UPDATE_PLAYER_NUM_GAMES_RESULT=$($PSQL "UPDATE player SET (games_played, best_game) = ($GAMES_PLAYED, $BEST_GAME) WHERE player_id=$PLAYER_ID ")
fi
