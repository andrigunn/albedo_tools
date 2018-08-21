#!/bin/bash
# cd ~
# touch .netrc
# echo "machine urs.earthdata.nasa.gov login andrigunnarsson password Hestur1401" > .netrc
# chmod 0600 .netrc

# cd ~
# touch .urs_cookies

# https://wiki.earthdata.nasa.gov/display/EL/How+To+Access+Data+With+cURL+And+Wget

product="MCD43A3"
version="6"
lat="65.0"
lon="-21.0"
date="2018-08-01,2018-08-05"

# Use inventory service to select files
for URL in `curl https://lpdaacsvc.cr.usgs.gov/services/inventory?product=$product\&version=$version\&lat=$lat\&lon=$lon\&date=$date\&output=text 2> /dev/null`
do
        # Cut granules file name from URL, it's the last item in the URL
        FILE=`echo $URL | rev | cut -d\/ -f 1 | rev`
        echo "Getting file $FILE "
        # retrieve the file from data pool
        # curl $URL --output $FILE 2>/dev/null # old style call
        curl -O -V -b ~/.urs_cookies -c ~/.urs_cookies -L -n $URL --output MCD43A3/$FILE 2>/dev/null  #new style call
done

#-O -b ~/.urs_cookies -c ~/.urs_cookies -L -n
