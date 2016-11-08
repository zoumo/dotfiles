# GRC colorizes nifty unix tools all over the place
if command_exists grc && command_exists brew
then
  source `brew --prefix`/etc/grc.bashrc
fi

if command_exists brew; then
    source `brew --prefix`/etc/profile.d/z.sh
fi
