#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
CEKEXPIRED () {
    today=$(date -d +1day +%Y-%m-%d)
    Exp1=$(curl -sS https://raw.githubusercontent.com/chalyyzhu/madang/main/ip | grep $MYIP | awk '{print $3}')
    if [[ $today < $Exp1 ]]; then
    echo -e "\e[32mSTATUS SCRIPT AKTIF...\e[0m"
    else
    echo -e "\e[31mSCRIPT ANDA EXPIRED!\e[0m";
    
    exit 0
fi
}
IZIN=$(curl -sS https://raw.githubusercontent.com/chalyyzhu/madang/main/ip | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "\e[32mPermission Accepted...\e[0m"
CEKEXPIRED
else
echo -e "\e[31mPermission Denied!\e[0m";
exit 0
fi
clear
uuid=$(cat /etc/trojan/uuid.txt)
source /var/lib/premium-script/ipvps.conf
domain=$(cat /etc/rare/xray/domain)
tr="$(cat ~/log-install.txt | grep -i "Trojan-GFW" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${user_EXISTS} == '0' ]]; do
                echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
                echo -e "\e[0;100;33m      • ADD TROJAN GFW •          \e[0m"
                echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
		read -rp "Password: " -e user
		user_EXISTS=$(grep -w $user /etc/trojan/akun.conf | wc -l)
		if [[ ${user_EXISTS} == '1' ]]; then
		    echo -e ""
		    echo -e "User \e[31m$user\e[0m already exist"
		    echo -e ""
		    echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
            echo ""
            read -n 1 -s -r -p "Press any key to back on menu"
            add-tr
		fi
	done
read -p "Jumlah Hari : " masaaktif
read -p "BUG TELCO : " BUG
sed -i '/"'""$uuid""'"$/a\,"'""$user""'"' /etc/trojan/config.json
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
echo -e "### $user $exp" >> /etc/trojan/akun.conf
systemctl restart trojan
echo -e "\033[32m[Info]\033[0m Trojan-GFW Start Successfully !"
sleep 2
trojanlink1="trojan://${user}@${MYIP}:${tr}?sni=${BUG}#${user}@ZhoeVPN"
trojanlink2="trojan://${user}@${BUG}.${domain}:${tr}?sni=${BUG}#${user}@ZhoeVPN"
clear
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\e[0;100;33m  • Trojan-GFW USER INFORMATION •  \e[0m"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
echo -e "Remarks        : ${user}"
echo -e "port           : ${tr}"
echo -e "Key            : ${user}"
echo -e "Expired On     : $exp"
echo -e "Jumlah Hari    : $masaaktif Hari"
echo -e "Host/IP        : ${domain}"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Config :"
echo -e "IP + BUG     : ${trojanlink1}"
echo -e "DOMAIN + BUG : ${trojanlink2}"
echo -e "\e[33m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
m-trojan

