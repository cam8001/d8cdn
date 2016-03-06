#!/bin/sh
# Gets a list of URLs to crawl. Requires linkchecker (install with pip)
linkchecker -v --ignore-url=origin.d8cdn.com http://d8cdn.com | tee output.txt
cat output.txt | awk '{print $3}' | grep 'http' | grep -v ',$'| sort | uniq | grep -v 'png\|jpg\|gif\|js\|css\|svg\|ttf\|eot\|woff\|comment-form\|maps\|cloudflare\|cdn-cgi\|origin' | grep d8cdn > spider_list.txt
