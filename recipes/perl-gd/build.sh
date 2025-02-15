#!/bin/bash

set -xe

export LC_ALL="C.UTF-8"

# If it has Build.PL use that, otherwise use Makefile.PL
if [ -f Build.PL ]; then
    perl Build.PL
    perl ./Build
    perl ./Build test
    # Make sure this goes in site
    perl ./Build install --installdirs site
elif [ -f Makefile.PL ]; then
    # Make sure this goes in site
    perl Makefile.PL INSTALLDIRS=site
    make
    if [ "$(uname)" == "Linux" ]; then
        make test
    fi
    make install
else
    echo 'Unable to find Build.PL or Makefile.PL. You need to modify build.sh.'
    exit 1
fi

chmod u+w $PREFIX/bin/bdf2gdfont.pl
chmod u+w $PREFIX/bin/bdftogd
