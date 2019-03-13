#!/usr/bin/env bash

echo "Creating directories"
mkdir -p itunes

CIS=(am az by kg kz md ru tj tm ua us uz)
MENA=(dz bh eg ir iq il jo kw lb ly ma om  ps qa sa sy tn ae ye)
ASEAN=(cn kh la id th vn sg my ph bn mm)
SUBSAHARAN=(ao dy bw bf bi cm cv cf td km cd cg ci dj gq er et ga gm gh gn gw ke ls lr mg mw ml mr mu mz na ne ng re rw st sn sc sl so za sd ss sz tz tg ug zm zw)
LATAM=(ar bo br cl ec gf gy py pe sr uy ve)
#WORLD=(${CIS[@]} ${MENA[@]} ${ASEAN[@]} ${SUBSAHARAN[@]} ${LATAM[@]})
# ISO 3166 2 letter TLD country codes
ISO3166CC=(af ax al dz as ad ao ai aq ag ar am aw au at az bs bh bd bb by be bz bj bm bt bo bq ba bw bv br io bn bg bf bi cv kh cm ca ky cf td cl cn cx cc co km cg cd ck cr ci hr cu cw cy cz dk dj dm do ec eg sv gq er ee sz et fk fo fj fi fr gf pf tf ga gm ge de gh gi gr gl gd gp gu gt gg gn gw gy ht hm va hn hk hu is in id ir iq ie im il it jm jp je jo kz ke ki kp kr kw kg la lv lb ls lr ly li lt lu mo mk mg mw my mv ml mt mh mq mr mu yt mx fm md mc mn me ms ma mz mm na nr np nl nc nz ni ne ng nu nf mp no om pk pw ps pa pg py pe ph pn pl pt pr qa re ro ru rw bl sh kn lc mf pm vc ws sm st sa sn rs sc sl sg sx sk si sb so za gs ss es lk sd sr sj se ch sy tw tj tj th tl tg tk to tt tn tr tm tc tv ug ua ae gb us um uy uz vu ve vn vg vi wf eh ye zm zw)
WORLD=(${ISO3166CC[@]})

terms=${1}
countries=${WORLD[@]}

echo
echo "Querying app stores for ${terms[@]}"
echo
for term in  ${terms[@]}; do
  for country in ${countries[@]}; do
    echo "Querying play store and itunes for ${term} in ${country}"
    wget --quiet -O itunes/itunes_${term}_${country}.json https://itunes.apple.com/lookup?id=${term}\&country=${country}\&media=software
  done
  echo
done
