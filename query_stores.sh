#!/usr/bin/env bash

echo "Creating directories"
mkdir -p tencent
mkdir -p gplay
mkdir -p itunes

echo
echo "Installing google-play-scrapper node.js module"
if [ `npm list -g | grep -c google-play-scraper` -eq 0 ]; then
    npm install google-play-scraper
fi

CIS=(am az by kg kz md ru tj tm ua us uz)
MENA=(dz bh eg ir iq il jo kw lb ly ma om  ps qa sa sy tn ae ye)
ASEAN=(cn kh la id th vn sg my ph bn mm)
SUBSAHARAN=(ao dy bw bf bi cm cv cf td km cd cg ci dj gq er et ga gm gh gn gw ke ls lr mg mw ml mr mu mz na ne ng re rw st sn sc sl so za sd ss sz tz tg ug zm zw)
LATAM=(ar bo br cl ec gf gy py pe sr uy ve)
WORLD=(${CIS[@]} ${MENA[@]} ${ASEAN[@]} ${SUBSAHARAN[@]} ${LATAM[@]})

terms=(vpn)
countries=${WORLD[@]}

echo
echo "Querying app stores for ${terms[@]}"
echo
for term in  ${terms[@]}; do
  echo "Querying tencent for ${term}"
  wget --quiet -O tencent/tencent_${term}.json https://android.myapp.com/myapp/searchAjax.htm?kw=${term}
  for country in ${countries[@]}; do
    echo "Querying play store and itunes for ${term} in ${country}"
    node gplayscrapper.js ${term} ${country} > gplay/gplay_${term}_${country}.json
    wget --quiet -O apple/itunes_${term}_${country}.json https://itunes.apple.com/search?term=${term}\&country=${country}\&media=software\&limit=99999
  done
  echo
done


#################################################################################
# Useful links:

# Countries where iOS app store apps are available
# https://www.apple.com/in/ios/feature-availability/#app-store-apps
# https://support.apple.com/en-us/HT204411

# Google PlayStore scrapper repository
# https://github.com/rimmer/google-play-scraper

# Tencent search webpage
# https://android.myapp.com/myapp/search.htm?kw=vpn

# 42matters country codes
# https://42matters.com/docs/app-market-data/supported-countries
