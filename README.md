# Co-WIN vaccine alerter
This project is a telegram bot which instantaneously alerts subscribers when vaccination slots are available.

Homepage: https://kishaningithub.github.io/cowin-vaccine-alerter/

## Supported areas
See [homepage](https://kishaningithub.github.io/cowin-vaccine-alerter/) to view supported regions more can 
always be added based on interest

## Background
This is basically a result of my frustration when i tried booking normally via the Co-Win app. The slots go out like hot cakes(in a matter of 10 seconds 🤯) and i cannot sit refreshing the same schedule screen all day long to know when slots are avaiable so i started looking out for options and did find a lot of telegram groups which solve this but what is see is there a considerable lag between the time when the slot gets available vs when the notification is received. Given the insane ~10 second window these were not worthwile. Upon digging i figured that is primarily due to the limitations imposed by the Cowin public API
Reference - https://apisetu.gov.in/public/marketplace/api/cowin/cowin-public-v2

# Development
* Install [direnv](https://direnv.net/)
* Create an `.envrc` file in your local and create envs as listed in `.github/workflows/publish-alert.yml`
* Run the script using `./cowin-vaccine-alerter.sh`
