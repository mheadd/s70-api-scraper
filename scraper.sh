##! bin/bash

# MySQL credentials.
USER=$1
PASSWORD=$2
HOST=$3
DATABASE=$4

# Array of categories to scrape (URL encode them).
declare -a categories=("132+50" "132+51" "132+52" "132+53" "132+56")

# Header row in CSV file.

echo '"Category","Contractor_Name","Contractor_Details_URL","State_Local_Auth","Contract_Number","Phone","Location","Socio_Economic_Indicators","Contractor_TC_Price_List","View_Catalog"' > data/data.csv

## Invoke node script to scrape Schedule 70 data by category.
for i in "${categories[@]}"
do
  node scraper.js "$i" | sed 's/"|/"/g' | sed 's/|/","/g' | csvcut -c 1-8,10,12 >> data/data.csv
  echo "Scraped data for category: $i"
done

# Insert data into MySQL database.
csvsql --db mysql://$USER:$PASSWORD@$HOST/$DATABASE --insert data/data.csv
echo "Successfuly inserted data in MySQL database: $DATABASE"

# Run the column formatting SQL.
mysql -u $USER -p $PASSWORD < sql/format-columns.sql
echo "Finished formatting columns."

# Finished.
echo "DONE!"
