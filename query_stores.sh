#!/usr/bin/env bash

echo "Creating directories"
mkdir -p tencent
mkdir -p gplay
mkdir -p itunes

echo
echo "Installing appstore scrapper node.js modules"
if [ `npm list -g | grep -c google-play-scraper` -eq 0 ]; then
    npm install google-play-scraper
    npm install app-store-scraper
fi

# CIS=(am az by kg kz md ru tj tm ua us uz)
# MENA=(dz bh eg ir iq il jo kw lb ly ma om  ps qa sa sy tn ae ye)
# ASEAN=(cn kh la id th vn sg my ph bn mm)
# SUBSAHARAN=(ao bw bf bi cm cv cf td km cd cg ci dj gq er et ga gm gh gn gw ke ls lr mg mw ml mr mu mz na ne ng re rw st sn sc sl so za sd ss sz tz tg ug zm zw)
# LATAM=(ar bo br cl ec gf gy py pe sr uy ve)
ISO3166CC=(af ax al dz as ad ao ai aq ag ar am aw au at az bs bh bd bb by be bz bj bm bt bo bq ba bw bv br io bn bg bf bi cv kh cm ca ky cf td cl cn cx cc co km cg cd ck cr ci hr cu cw cy cz dk dj dm do ec eg sv gq er ee sz et fk fo fj fi fr gf pf tf ga gm ge de gh gi gr gl gd gp gu gt gg gn gw gy ht hm va hn hk hu is in id ir iq ie im il it jm jp je jo kz ke ki kp kr kw kg la lv lb ls lr ly li lt lu mo mk mg mw my mv ml mt mh mq mr mu yt mx fm md mc mn me ms ma mz mm na nr np nl nc nz ni ne ng nu nf mp no om pk pw ps pa pg py pe ph pn pl pt pr qa re ro ru rw bl sh kn lc mf pm vc ws sm st sa sn rs sc sl sg sx sk si sb so za gs ss es lk sd sr sj se ch sy tw tj tj th tl tg tk to tt tn tr tm tc tv ug ua ae gb us um uy uz vu ve vn vg vi wf eh ye zm zw)

terms=(vpn)

echo
echo "Querying app stores for ${terms[@]}"
echo
for term in  ${terms[@]}; do
  echo "Querying tencent for ${term}"
  wget --quiet -O tencent/tencent_${term}.json "https://android.myapp.com/myapp/searchAjax.htm?kw=${term}"
  for country in ${ISO3166CC[@]}; do
    echo "Querying play store and itunes for ${term} in ${country}"
    node gplay_search.js ${term} ${country} > gplay/gplay_${term}_${country}.json
    node itunes_search.js ${term} ${country} > itunes/itunes_${term}_${country}.json
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

# Query itunes for a term in a country
# wget --quiet -O itunes/itunes_${term}_${country}.json https://itunes.apple.com/search?term=${term}\&country=${country}\&media=software\&limit=99999
