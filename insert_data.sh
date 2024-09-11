#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
   echo selamlar true
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
  echo selamlar else
fi
ILKGEC="FALSE"
TEMIZLE_ID=$($PSQL "TRUNCATE TABLE teams,games RESTART IDENTITY;")
# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read YIL TUR KAZANAN KAYBEDEN KAZANANGOL KAYBEDENGOL
do
if [[ $ILKGEC == "FALSE" ]]
then
echo $ILKGEC
ILKGEC="TRUE"
else

echo $YIL $TUR $KAZANAN $KAYBEDEN $KAZANANGOL $KAYBEDENGOL



MAJOR_ID=$($PSQL "INSERT INTO teams(name) VALUES('$KAZANAN');")
MAJOR_ID=$($PSQL "INSERT INTO teams(name) VALUES('$KAYBEDEN');")


KAZANAN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$KAZANAN';")

KAYBEDEN_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$KAYBEDEN';")

GAMESEYUKLE=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES('$YIL', '$TUR', '$KAZANAN_ID', '$KAYBEDEN_ID', '$KAZANANGOL', '$KAYBEDENGOL');")

echo $KAZANAN_ID $KAYBEDEN_ID
fi
done



