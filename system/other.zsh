# GRC colorizes nifty unix tools all over the place
if (( $+commands[grc] )) && (( $+commands[brew] ))
then
  source `brew --prefix`/etc/grc.bashrc
fi

if (( $+commands[brew] )); then
    . `brew --prefix`/etc/profile.d/z.sh
fi
