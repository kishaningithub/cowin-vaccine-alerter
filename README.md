# Co-WIN vaccine alerter
This project is a telegram bot which alerts subscribers when vaccination slot is available.

Homepage: https://kishaningithub.github.io/cowin-vaccine-alerter/

## Supported areas
See [homepage](https://kishaningithub.github.io/cowin-vaccine-alerter/) to view supported regions more can 
always be added based on interest

## Background
When I tried to book normally or with the help of other telegram bots that are out there, there was a considerable lag between the time
when the slot is available and when the notification is received. This is primarily due to the limitations imposed by the Cowin public API
Reference - https://apisetu.gov.in/public/marketplace/api/cowin/cowin-public-v2

# Development
* Install [direnv](https://direnv.net/)
* Create an `.envrc` file in your local and create envs as listed in `.github/workflows/publish-alert.yml`
* Run the script using `./cowin-vaccine-alerter.sh`
