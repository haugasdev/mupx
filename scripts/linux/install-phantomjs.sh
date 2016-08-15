#!/bin/bash

APPNAME=<%= appName %>

# Remove the lock
# Install PhantomJS

ARCH=`docker exec -i $APPNAME /bin/bash -c "uname -m"`
PHANTOMJS_VERSION=2.1.1

docker exec -i $APPNAME /bin/bash -c "\
set +e \
&& rm /var/lib/dpkg/lock > /dev/null \
&& rm /var/cache/apt/archives/lock > /dev/null  \
&& dpkg --configure -a \
&& set -e \
&& apt-get -y install libfreetype6 libfreetype6-dev fontconfig > /dev/null \
&& cd /usr/local/share/ && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PHANTOMJS_VERSION}-linux-${ARCH}.tar.bz2 > /dev/null \
&& tar xjf phantomjs-${PHANTOMJS_VERSION}-linux-${ARCH}.tar.bz2  > /dev/null \
&& ln -s -f /usr/local/share/phantomjs-${PHANTOMJS_VERSION}-linux-${ARCH}/bin/phantomjs /usr/local/share/phantomjs \
&& ln -s -f /usr/local/share/phantomjs-${PHANTOMJS_VERSION}-linux-${ARCH}/bin/phantomjs /usr/local/bin/phantomjs \
&& ln -s -f /usr/local/share/phantomjs-${PHANTOMJS_VERSION}-linux-${ARCH}/bin/phantomjs /usr/bin/phantomjs"
