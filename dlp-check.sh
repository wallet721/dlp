#!/bin/bash

# array of tables to check in the database. If you can't see how to add a new table to this, you probably shouldn't
TABLES=("ehawk_fraud_checks" "person_contact_history" "address")

#name of GCP project that the database is in
PROJECT="datawarehouse-staging-242801"

#name of the dataset
DATASET="account"

#action to take - inspect or analyze
ACTION="inspect"

#INFOTYPES to use in the process. The string has to be formatted as you see it, but you can add or remove types
# list of GCP created type is at https://cloud.google.com/dlp/docs/infotypes-reference#australia
# we can define our own types but that can be in V2
# It might pay to add these, but I'm not sure...
# "AUSTRALIA_DRIVERS_LICENCE_NUMBER,AUSTRALIA_MEDICARE_NUMBER,AUSTRALIA_PASSPORT,AUSTRALIA_TAX_FILE_NUMBER"
INFOTYPES="CREDIT_CARD_NUMBER,DATE_OF_BIRTH,EMAIL_ADDRESS,LAST_NAME,PHONE_NUMBER,PASSWORD"

#The CLI command (the CLI command is alpha right now, this will change in the future)
CMD="gcloud alpha dlp datasources bigquery"

#We now have to parse the TABLES array, because it's one table per job
for T_NAME in ${TABLES[@]};
do
  #Build the whole thing...
  COMMAND="$CMD $ACTION $PROJECT.$DATASET.$T_NAME --info-types $INFOTYPES"
  echo "Going to submit this... $COMMAND"

  #so we run the command...
  $COMMAND
done



