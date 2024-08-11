#!/usr/bin/env bash

# <xbar.title>aqi</xbar.title>
# <xbar.version>v0.0.0</xbar.version>
# <xbar.author>youngjo</xbar.author>
# <xbar.author.github>booklice</xbar.author.github>
# <xbar.desc>aqi</xbar.desc>
# <xbar.dependencies>curl,jq</xbar.dependencies>
# <xbar.abouturl>https://github.com/typerlc/bitbar-weather/</xbar.abouturl>
# <xbar.image>https://github.com/typerlc/bitbar-weather/raw/master/weather_preview.png</xbar.image>

ipinfo=$(curl ipinfo.io)
city=$(echo $ipinfo | /opt/homebrew/bin/jq '.city' | tr -d '"')
country=$(echo $ipinfo | /opt/homebrew/bin/jq '.country' | tr -d '"')

api_token="e09b7ea2580463085ef732f3d2d0146efc98375f"
json_data=$(curl "https://api.waqi.info/feed/$city/?token=$api_token")

aqi=$(echo $json_data | /opt/homebrew/bin/jq '.data.aqi')
pm25=$(echo $json_data | /opt/homebrew/bin/jq '.data.iaqi.pm25.v')
pm10=$(echo $json_data | /opt/homebrew/bin/jq '.data.iaqi.pm10.v')
time=$(echo $json_data | /opt/homebrew/bin/jq '.data.time.s' | tr -d '"')

color="white"
status="🤔"

if (( $aqi > 0 && $aqi <= 50 )); then
    status="😊"
    color="#4fafd4"
elif (( $aqi > 50 && $aqi <= 100 )); then 
    status="🙂"
    color="#51e276"
elif (( $aqi > 100 && $aqi <= 150 )); then 
    status="😐"
    color="#f7e036"
elif (( $aqi > 150 && $aqi <= 200 )); then 
    status="☹️"
    color="#f79036"
elif (( $aqi > 200 && $aqi <= 300 )); then 
    status="😵"
    color="#d91f1f"
elif (( $aqi > 300 )); then 
    status="💀"
    color="#65257b"
fi

echo "$aqi $status  | color=$color"

echo '---'
echo "$city ($time) | color=#FFFFF0"
echo "AQI: $aqi | color=#FFFFF0"
echo "PM2.5: $pm25 | color=#FFFFF0"
echo "PM10: $pm10 | color=#FFFFF0"
# echo "---"

# url="https://aqicn.org/city/$city/$country"
# html_response=$(curl -s $url)
# echo $html_response
# imgs=$(echo "${html_responsee}" | grep -o -E "<img class='aqi-graph-img[^:]+:image/png;base64,[^']*" | sed -n -E "s/^.*base64,([^']*).*$/\1/p")
# echo $imgs
# # for img in ${imgs};
# # do
# #     echo ". | href=${url} image=${img} trim=false"
# # done

echo "---"

echo "Refresh | color=#FFFFF0 refresh=true"
echo "---"
