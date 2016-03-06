#!/bin/bash
# Change to echo for testing, eval for running
cmd='eval'

# Generate a random IP to pad logs upstream
ip_address=$(dd if=/dev/urandom bs=4 count=1 2>/dev/null | od -An -tu1 | sed -e 's/^ *//' -e 's/  */./g')
forwarded_header="X-Forwarded-For: $ip_address"
spidered_urls=0

echo "Using header '$forwarded_header'"
while read url
do
    # Sleep between requests for up to 2 seconds.
    sleep_secs=$[ RANDOM % 3 ]
    # fetch_url='no'
    # # Fetch a url on a third of requests
    # if [ $[ RANDOM % 3  ] -eq 1  ]; then
    #    fetch_url=yes
    # fi

    fetch_url='yes'

    if [[ $fetch_url = "yes" ]]; then
        $cmd "echo 'Sleeping for $sleep_secs seconds.'"
        # Sleep, make the request, but don't save the output.
        $cmd "sleep $sleep_secs; wget -O- -nv  --header='$forwarded_header' $url > /dev/null"
        let "spidered_urls++"
    fi
done <  spider_list.txt

echo "Spidered $spidered_urls URLs."
