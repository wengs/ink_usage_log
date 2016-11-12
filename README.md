# Ink Usage Log

## Purpose

A small web application to record ink usage on different printing machines.

Key features include:
- Record expiration date for a part number.
- Generate ink usage on a percentage chart for a specific machine within a specifiied time range.
- Download the above pie chart data in csv.

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



