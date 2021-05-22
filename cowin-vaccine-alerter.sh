#!/usr/bin/env sh

set -e

rm -f ./*.json
rm -f ./*.txt
current_date=$(date -u +"%Y-%m-%d")
curl "${COWIN_API_BASE_URL}/v2/appointment/sessions/calendarByDistrict?district_id=571&date=${current_date}" -H "${USER_AGENT_HEADER}" -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en,en-US;q=0.5' --compressed -H "${COWIN_AUTHORIZATION_TOKEN}" -H "Origin: ${ORGIN_URL}" -H 'Connection: keep-alive' -H "Referer: ${ORGIN_URL}" -H 'Sec-GPC: 1' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'TE: Trailers' | jq > ./cowin-chennai.json
jq -r '[.centers[] | select(.sessions[] | .min_age_limit == 18 and .available_capacity_dose1 > 0)]' ./cowin-chennai.json | jq -r '.[] | "Dose 1 of \([.sessions[].vaccine] | unique | join(",")) available at \(.name), \(.block_name), \(.pincode)"' | uniq > dose-1-result.txt
#  jq -r '[.centers[] | select(.sessions[] | .min_age_limit == 18 and .available_capacity_dose2 > 0)]' ./cowin-chennai.json | jq -r '.[] | "Dose 2 of \([.sessions[].vaccine] | unique | join(",")) available at \(.name), \(.block_name), \(.pincode)"' | uniq > dose-2-result.txt
cat dose-1-result.txt | xargs -I {} curl -G "https://api.telegram.org/${TELEGRAM_BOT_TOKEN}/sendMessage" --data-urlencode "chat_id=${TELEGRAM_BOT_CHAT_ID}" --data-urlencode "text={}"