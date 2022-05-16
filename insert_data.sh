#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
TRUNCATED=$($PSQL "TRUNCATE TABLE games, teams")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WIN_GOALS OPP_GOALS
do
  if [[ $YEAR != 'year' ]]
  then
    # Add the winner and the opponent to teams
    # --- Add the winner to teams
    win_team_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
    if [[ -z $win_team_id ]]
    then
      # Winning team doesn't exist in database, add it
      win_team_id_entry=$($PSQL "INSERT INTO teams(name) VALUES ('$WINNER')")
      if [[ $win_team_id_entry = 'INSERT 0 1' ]]
      then
        win_team_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")
      fi
    fi
    # --- Add the opponent to teams
    opp_team_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
    if [[ -z $opp_team_id ]]
    then
      # Opponent (losing) team doesn't exist in database, add it
      opp_team_id_entry=$($PSQL "INSERT INTO teams(name) VALUES ('$OPPONENT')")
      if [[ $opp_team_id_entry = 'INSERT 0 1' ]]
      then
        opp_team_id=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")
      fi
    fi
    # Now work on games
    # Add each data row into the table
    echo -e "\n$YEAR $ROUND $win_team_id $opp_team_id $WIN_GOALS $OPP_GOALS\n"
    GAME_ENTRY_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $win_team_id, $opp_team_id, $WIN_GOALS, $OPP_GOALS)")
    if [[ $GAME_ENTRY_RESULT = 'INSERT 0 1' ]]
    then
      echo "Inserted game with values $YEAR $ROUND $WINNER $OPPONENT $WIN_GOALS $OPP_GOALS"
    fi
  fi
done
