#!/usr/bin/env sh

set -e

poll_cowin_and_send_alert() {
  district_id="$1"
  chat_id="$2"
  echo "Searching slot availability for district id ${district_id}"
  rm -f ./*.json
  rm -f ./*.txt
  current_date=$(TZ=Asia/Kolkata date +"%d-%m-%Y")
  curl --retry 3 -fL "${COWIN_API_BASE_URL}/v2/appointment/sessions/calendarByDistrict?district_id=${district_id}&date=${current_date}" -H "${USER_AGENT_HEADER}" -H 'Accept: application/json, text/plain, */*' -H 'Accept-Language: en,en-US;q=0.5' --compressed -H "${COWIN_AUTHORIZATION_TOKEN}" -H "Origin: ${ORGIN_URL}" -H 'Connection: keep-alive' -H "Referer: ${ORGIN_URL}" -H 'Sec-GPC: 1' -H 'Pragma: no-cache' -H 'Cache-Control: no-cache' -H 'TE: Trailers' | jq > ./cowin-chennai.json
  jq -r '[.centers[] | select(.sessions[] | .min_age_limit == 18 and .available_capacity_dose1 > 0)]' ./cowin-chennai.json | jq -r '.[] | "Dose 1 of \([.sessions[].vaccine] | unique | join(",")) available at \(.name), \(.block_name), \(.pincode)"' | uniq > dose-1-result.txt
  #  jq -r '[.centers[] | select(.sessions[] | .min_age_limit == 18 and .available_capacity_dose2 > 0)]' ./cowin-chennai.json | jq -r '.[] | "Dose 2 of \([.sessions[].vaccine] | unique | join(",")) available at \(.name), \(.block_name), \(.pincode)"' | uniq > dose-2-result.txt
  cat dose-1-result.txt | xargs -I {} curl --retry 3 -fLG "https://api.telegram.org/${TELEGRAM_BOT_TOKEN}/sendMessage" --data-urlencode "chat_id=${chat_id}" --data-urlencode "text={}"
}

max_attempts=500
sleep_time=30
attempt_counter=0
while [ ${attempt_counter} -le ${max_attempts} ]
do
  # Tamil Nadu / Chennai
  poll_cowin_and_send_alert 571 -530040865
  # Tamil Nadu / Tiruvallur
  poll_cowin_and_send_alert 572 -516074907
  # Tamil Nadu / Chengalpet
  poll_cowin_and_send_alert 565 -540515683
  # Tamil Nadu / Kanchipuram
  poll_cowin_and_send_alert 557 -519869836
  echo "Beginning sleep for ${sleep_time} seconds"
  sleep ${sleep_time}
  attempt_counter=$((attempt_counter+1))
done