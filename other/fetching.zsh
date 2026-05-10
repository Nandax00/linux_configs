#!/bin/zsh

/usr/bin/bandsnatch run -j 10 -c /srv/bandsnatch/cookies.json -f flac -o /srv/staging nandax

if [[ $(ls -1 /srv/staging | wc -l) -gt 1 ]]; then
  if [[ ! $(pgrep -u $USER -x beet) ]]; then
    /usr/bin/beet import -q /srv/staging
  else
    echo "beet is running already"
  fi
else
  echo "staging directory does not contain new music"
fi
