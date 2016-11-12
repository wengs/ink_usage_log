# Ink Usage Log

## Purpose

A small web application to record ink usage as well as waste on different printing machines.

Key features include:
- Record expiration date for a part number.
- Generate ink usage/waste on a pie/column chart for a machine within a specified time range.
- Download the above chart data in csv.

## Dependencies
- Ruby  2.2.2
- Rails 4.2.3
- MySQL
- HighCharts

## Development

### Setup
- ```$ cp config/database.sample.yml config/database.yml```
- Edit config/database.yml if needed
- If bundler is not installed, ```gem install bundler```
- ```$ bundle```
- ```$ rake db:setup```
- package all gem changes ```bundle package --all``` (all gem changes will result in gem cache modifications to commit)

### Getting Started

```bash
$ rails s
```
The default admin user is following:
username: admin@mail.com
password: password

##Features
### Generate a Report
- Open home page
- Click the Generate a Report button
- Submit the form after selecting Chart Type, Machine, Start Date, and End Date.
- Switch between table view and chart view using the options located at the top right hand corner.
- Download data in CSV form on the table view.




