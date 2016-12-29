# Schedule 70 Data Scraper

A data scraper for getting information from the GSA eLibrary site.

## Background on Schedule 70 Data

GSA eLibrary [schedules and contracts data](https://catalog.data.gov/dataset/gsa-elibrary-schedules-and-contracts) includes a lot more than just schedule 70 and does not identify which contractors are authorized to [work with state and local governments](http://www.gsa.gov/portal/content/141511). It's also not clear how current this data is, or how often it is updated.

The GSA eLibrary site does allow for [data to be downloaded](http://www.gsaelibrary.gsa.gov/ElibMain/sinDetails.do?executeQuery=YES&scheduleNumber=70&flag=&filter=&specialItemNumber=132+51), ostensibly in Excel format. However, the downloaded file appears to be HTML, not .xls. Also, system errors are encountered periodically when attempting to download data in this way.

For now, scraping the data from the eLibrary site gets around these limitations, and also provides useful data elements that are not available in the downloadable version (even if it we're working properly), like the URL to link to a specific contractor's profile information.

## Usage

This is admittedly ugly and inefficient, but it works. Suggestions for improvements welcomed.

* Clone this repo and install dependencies: ```npm install```
* Create a new MySQL database and user:

```sql
mysql> CREATE DATABASE schedule70;
mysql> CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
mysql> GRANT INSERT ON schedule70 . * TO 'user'@'localhost';
```
* Make the scraper script executable: ```chmod +x scraper.sh```
* Run the scraper script and pass in your MySQL credentials:

```bash
~$ ./scraper.sh "user" "password" "localhost" "schedule70"
```

Note - you can modify the the categories that get scraped by [modifying the array](https://github.com/mheadd/s70-api-scraper/blob/master/scraper.sh#L10) in the scraper script.
