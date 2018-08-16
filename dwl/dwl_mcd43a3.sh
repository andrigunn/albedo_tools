#!/bin/bash

product="MCD43A3"
version="6"
lat="65.0"
lon="-21.0"
date="2017-08-01,2018-08-15"

# Use inventory service to select files
for URL in `curl https://lpdaacsvc.cr.usgs.gov/services/inventory?product=$product\&version=$version\&lat=$lat\&lon=$lon\&date=$date\&output=text 2> /dev/null`
do
        # Cut granules file name from URL, it's the last item in the URL
        FILE=`echo $URL | rev | cut -d\/ -f 1 | rev`
        echo "Getting file $FILE "
        # retrieve the file from data pool
        # curl $URL --output $FILE 2>/dev/null # old style call
        curl -O -b ~/.urs_cookies -c ~/.urs_cookies -L -n $URL --output $FILE 2>/dev/null  #new style call
done

#-O -b ~/.urs_cookies -c ~/.urs_cookies -L -n
