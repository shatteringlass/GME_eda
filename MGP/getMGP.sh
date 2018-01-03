#!/usr/bin/env bash

function getSID (){
  SID="$(grep -i sid cookie.txt | cut -f7)"
  echo "$SID"
}

function getGMEI (){
  GMEI="$(grep -i gmei cookie.txt | cut -f7)"
  echo "$GMEI"
}

function getXML (){
 date="$1"
 sID="$2"
 GMEi="$3"
 curl -O -L "http://www.mercatoelettrico.org/It/WebServerDataStore/MGP_Prezzi/"$date"MGPPrezzi.xml" -H "DNT: 1" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: it-IT,it;q=0.9,en-US;q=0.8,en;q=0.7" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3298.3 Safari/537.36" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" -H "Referer: http://www.mercatoelettrico.org/It/Tools/Accessodati.aspx?ReturnUrl=%2fIt%2fWebServerDataStore%2fMGP_Prezzi%2f"$date"MGPPrezzi.xml" -H "Cookie: ASP.NET_SessionId="$sID"; GmeItaliano="$GMEi"" -H "Connection: keep-alive" -H "Cache-Control: max-age=0" --compressed
}

function postMGP (){
 curl --max-time 2 -sSL -D - -c cookie.txt -X POST "http://www.mercatoelettrico.org/It/Tools/Accessodati.aspx?ReturnUrl=%2fIt%2fWebServerDataStore%2fMGP_Prezzi%2f20180102MGPPrezzi.xml" -H "Origin: http://www.mercatoelettrico.org" -H "Accept-Encoding: gzip, deflate" -H "Accept-Language: it-IT,it;q=0.9,en-US;q=0.8,en;q=0.7" -H "Upgrade-Insecure-Requests: 1" -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3298.3 Safari/537.36" -H "Content-Type: application/x-www-form-urlencoded" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8" -H "Content-Length: 1517" -H "Cache-Control: max-age=0" -H "Referer: http://www.mercatoelettrico.org/It/Tools/Accessodati.aspx?ReturnUrl=%2fIt%2fWebServerDataStore%2fMGP_Prezzi%2f20180102MGPPrezzi.xml" -H "Connection: keep-alive" -H "DNT: 1" --data "__EVENTTARGET=&__EVENTARGUMENT=&__LASTFOCUS=&__VIEWSTATE=%2FwEPDwULLTIwNTEyNDQzNzQPZBYCZg9kFgICAw9kFgICAQ9kFgQCDA9kFgJmD2QWAmYPZBYCAgkPD2QWAh4Kb25rZXlwcmVzcwUccmV0dXJuIGludmlhUFdEKHRoaXMsZXZlbnQpO2QCFQ9kFgICAQ8PFgIeDU9uQ2xpZW50Q2xpY2sFJmphdmFzY3JpcHQ6d2luZG93Lm9wZW4oJz9zdGFtcGE9dHJ1ZScpZGQYAQUeX19Db250cm9sc1JlcXVpcmVQb3N0QmFja0tleV9fFgUFDGN0bDAwJEltYWdlMQUSY3RsMDAkSW1hZ2VCdXR0b24xBSBjdGwwMCRDb250ZW50UGxhY2VIb2xkZXIxJHN0YW1wYQUkY3RsMDAkQ29udGVudFBsYWNlSG9sZGVyMSRDQkFjY2V0dG8xBSRjdGwwMCRDb250ZW50UGxhY2VIb2xkZXIxJENCQWNjZXR0bzJ5m5XTXA6aYQFj7gMUHXm7z2vjJAzb5gYRr7Um2EX0yQ%3D%3D&__VIEWSTATEGENERATOR=BD5243C0&__SCROLLPOSITIONX=0&__SCROLLPOSITIONY=222&__PREVIOUSPAGE=jLIlqEZuwIVKBMwgmt0k6KQe_BImzWbYYNsTMmg9DUwdqflvaV7O4eESI7EXxzwl5tV_28U-ick4AGKK0ZRi0SbY4SjlvcimJRTneMHfMnNnR0bVY6JzNtEDv1hKzmi40&__EVENTVALIDATION=%2FwEdABPa2y%2FuHalhroyRT%2FEpruczcS%2Fs8I39AyxLz4tn%2BAkBiEW%2BokpiqwYG%2BB4aTa9o%2Bs43drX32rKpFiwqoHxZnWEOD4zZrxX92uOlyIx1SyGTQmV8haT0EfVomfKCKov4HgnZl%2FXwcz7QqxVnz%2BOmFVuWzNBM98trssXld5dD73vgQX4H%2F0z%2F058uP3NmytG8PXozrkfQ7SmiPGgdsZPdEEV8g%2Fgu4%2BzhSeI0ttI2ADLh%2FwU7Nz%2F6FKjnm2sSszw4FMr8VEDvc%2BzuMc1oKpjHdCosjDu35o5CUn6umW4JNpE1p4raaQaFnXKaLuO1sKRm4e9ZUwtJIYRkZxZmb4HmgHR6ltkgVwReXnm%2BEHOYvXjKP0Sd1PBpsO2hEyKj10xH8juA%2BrwVNruExpEBEKBupGso1kjvB%2FVJLP%2BeoirBvB4bETsBON0lPNEtpdVrM86yI8A%3D&ctl00%24tbTitolo=cerca+nel+sito&ctl00%24UserName=&ctl00%24Password=&ctl00%24ContentPlaceHolder1%24CBAccetto1=on&ctl00%24ContentPlaceHolder1%24CBAccetto2=on&ctl00%24ContentPlaceHolder1%24Button1=Accetto" --compressed -o /dev/null | grep Cookie > /dev/null
}

# Takes startDate and endDate in YYYYMMDD format as input, downloads corresponding XML MGP files

startDate=$(date -j -f "%Y%m%d" "$1" "+%s")
endDate=$(date -j -f "%Y%m%d" "$2" "+%s")
offset=86400

postMGP # this will write a cookie.txt file to cwd

if [ ! -f cookie.txt ]; then echo "Cookie retrieval failed!"; exit; fi

while [ "$startDate" -le "$endDate" ] ;
do
  date=$(date -j -f "%s" $startDate "+%Y%m%d")
  echo -e "\n######\nNow downloading XML for date "$date
  getXML $date "$(getSID)" "$(getGMEI)"
  startDate=$(($startDate+$offset))
done 

mkdir -p ./XML/
mv *.xml ./XML/
