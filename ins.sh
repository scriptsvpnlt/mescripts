#!/bin/bash
clear

# ip
Ip_Vps=$(curl -sS ipv4.icanhazip.com)

# make dir
mkdir -p /etc/xray
mkdir -p /var/lib/LT
touch /etc/xray/domain
touch /etc/xray/domainhost
touch /etc/xray/v2ray
touch /var/lib/LT/ipvps.conf
# xray dir log
mkdir -p /var/log/xray
chown www-data.www-data /var/log/xray
chmod +x /var/log/xray
touch /var/log/xray/access.log
touch /var/log/xray/error.log
clear
function pasang_domain() {
clear
echo -e "   \033[38;5;197m ===========================================\e[0m"
echo -e "   \033[38;5;227m    Please Select a Domain bellow type.     \e[0m"
echo -e "   \033[38;5;197m ===========================================\e[0m"
echo -e "   \033[38;5;197m  1). \e[97;1m Domain Pribadi   \e[0m"
echo -e "   \033[38;5;197m  2). \e[97;1m Domain Random  \e[0m"
echo -e "   \033[38;5;197m ===========================================\e[0m"
echo -e ""
read -p "   Just Input a number [1-2]:   " host
echo ""
if [[ $host == "1" ]]; then
clear
IP=$(wget -qO- icanhazip.com);
echo -e "   \033[38;5;197m ===========================================\e[0m"
echo -e "   \033[38;5;227m             INPUT YOUR DOMAIN              \e[0m"
echo -e "   \033[38;5;197m ===========================================\e[0m"
echo -e ""
read -p "   input your domain   :   " host1
echo "IP=" > /var/lib/LT/ipvps.conf
echo $host1 > /etc/xray/domain
echo $host1 > /etc/xray/v2ray
echo $host1 > /etc/xray/domainhost
#echo "IP=$host1" > /var/lib/LT/ipvps.conf
elif [[ $host == "2" ]]; then
clear
echo -e ""
echo -e "   \033[38;5;197m ===========================================\e[0m"
echo -e "   \033[38;5;227m            INPUT YOUR SUBDOMAIN            \e[0m"
echo -e "   \033[38;5;197m ===========================================\e[0m"
echo -e ""
echo -e "   \033[96;1m EXAMPLE :\033[0m"
echo -e "   \033[97;1m  vpnqu , kontolvpn ,bebas = ini subdomain BENAR ✓\033[0m"
echo -e "   \033[97;1m  vpnqu.my.id , komtolvpn.com ,bebas.net = ini SALAH x\033[0m"
echo -e "   \033[38;5;197m ===========================================\e[0m"
echo -e ""
read -p "   input your subdomain :   " domen
DOMAIN=execbash.baby
sub=${domen}
dns=${sub}.execbash.baby
#(</dev/urandom tr -dc a-z0-9 | head -c5)
CF_KEY=lHX2aquuB_YKSwsmKNeYHyIEiPAOkn6eMq5MQ6eW
CF_ID=mezzqueen293@gmail.com
set -euo pipefail
clear
echo "Updating DNS for ${dns}..."
# install pkg
apt install jq curl -y
apt install wget -y
IP=$(wget -qO- icanhazip.com);
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${dns}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${dns}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${dns}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "$dns" > /etc/xray/domain
echo "$dns" > /etc/xray/domainhost
echo "$dns" > /etc/xray/scdomain
echo "$dns" > /etc/xray/v2ray
echo "IP=$dns" > /var/lib/LT/ipvps.conf
cd
clear
else
echo -e ""
clear
fi
}
pasang_domain

clear
echo -e "   \033[38;5;197m ===========================================\e[0m"
echo -e "   \033[38;5;227m            UPGRADE & UPDATE REPO              \e[0m"
echo -e "   \033[38;5;197m ===========================================\e[0m"
apt upgrade -y
apt update -y
clear
echo -e "   \033[38;5;197m ===========================================\e[0m"
echo -e "   \033[38;5;227m              INSTALL WONDERSHAPER             \e[0m"
echo -e "   \033[38;5;197m ===========================================\e[0m"
apt install wondershaper -y
clear



# data Telegram
TIMES="10"
CHATID="5970831071"
KEY="7633327456:AAGE7JigJpWbJyVly-fcQ8B3S1ctqq-qYOM"
URL="https://api.telegram.org/bot$KEY/sendMessage"
TIME=$(date '+%d %b %Y')

# repo
GIT_USER="scriptsvpnlt"
GIT_REPO="mescripts"
GIT_BRANCH="main"
REPO="https://raw.githubusercontent.com/${GIT_USER}/${GIT_REPO}/${GIT_BRANCH}/"
REPO_SLOWDNS="https://raw.githubusercontent.com/${GIT_USER}/${GIT_REPO}/${GIT_BRANCH}/"

# checking root user
clear
export IP=$( curl -sS icanhazip.com )
clear
clear && clear && clear
clear;clear;clear
clear
if [ "${EUID}" -ne 0 ]; then
echo -e "\e[92;1m Checking root user \e[0m"
exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi
clear

# Define the necessary variables
Ip_Vps=$(curl -sS ipv4.icanhazip.com)

# Save Name in github to /usr/bin/user
rm -f /usr/bin/user
username=$(curl https://raw.githubusercontent.com/${GIT_USER}/vps_access/main/ip | grep $Ip_Vps | awk '{print $2}')
echo "$username" >/usr/bin/user

# Save Expired Detail in github to /usr/bin/e
expx=$(curl https://raw.githubusercontent.com/${GIT_USER}/vps_access/main/ip | grep $Ip_Vps | awk '{print $3}')
echo "$expx" >/usr/bin/e

# Calculated expired Y+M+T to dayLEFT
username=$(cat /usr/bin/user)
exp=$(cat /usr/bin/e)
clear

# Current Date
DATE=$(date +'%Y-%m-%d')
today=$(date -d "0 days" +"%Y-%m-%d")

# Function to calculate the date difference
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}

# Call the datediff function to calculate expiry
datediff "$exp" "$DATE"

# Status Check
Exp1=$(curl https://raw.githubusercontent.com/${GIT_USER}/vps_access/main/ip | grep $Ip_Vps | awk '{print $4}')
if [[ $(date -d "$today" +%s) -lt $(date -d "$Exp1" +%s) ]]; then
    sts="${Info}"
else
    sts="${Error}"
fi

echo -e "\e[32mloading...\e[0m"
clear
start=$(date +%s)
secs_to_human() {
echo "Installation time : $((${1} / 3600)) hours $(((${1} / 60) % 60)) minute's $((${1} % 60)) seconds"
}
function print_ok() {
echo -e "${OK} ${BLUE} $1 ${FONT}"
}
function print_error() {
echo -e "${ERROR} ${REDBG} $1 ${FONT}"
}

function is_root() {
if [[ 0 == "$UID" ]]; then
print_ok "Root user Start installation process"
else
print_error "The current user is not the root user, please switch to the root user and run the script again"
fi
}
curl -s ifconfig.me > /etc/xray/ipvps
# var lib LT
mkdir -p /var/lib/LT >/dev/null 2>&1
while IFS=":" read -r a b; do
case $a in
"MemTotal") ((mem_used+=${b/kB})); mem_total="${b/kB}" ;;
"Shmem") ((mem_used+=${b/kB}))  ;;
"MemFree" | "Buffers" | "Cached" | "SReclaimable")
mem_used="$((mem_used-=${b/kB}))"
;;
esac
done < /proc/meminfo
Ram_Usage="$((mem_used / 1024))"
Ram_Total="$((mem_total / 1024))"
export tanggal=`date -d "0 days" +"%d-%m-%Y - %X" `
export OS_Name=$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' )
export Kernel=$( uname -r )
export Arch=$( uname -m )
export IP=$( curl -s https://ipinfo.io/ip/ )



install_script(){
clear
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
clear
fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
        [[ -e $HOME/fim ]] && rm $HOME/fim
        ${CMD[0]} -y >/dev/null 2>&1
        ${CMD[1]} -y >/dev/null 2>&1
        touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne " \033[92;1m INSTALL \033[1;37m- \033[0;35m["
    while true; do
        for ((i = 0; i < 18; i++)); do
            echo -ne "\033[96;1m#"
            sleep 0.1s
        done
        [[ -e $HOME/fim ]] && rm $HOME/fim && break
        echo -e "\033[0;35m]"
        sleep 1s
        tput cuu1
        tput dl1
        echo -ne " \033[92;1m INSTALL \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;35m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
}

function first_setup(){
timedatectl set-timezone Asia/Jakarta
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections

if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
echo "Setup Dependencies $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
sudo apt update -y
apt-get install --no-install-recommends software-properties-common
add-apt-repository ppa:vbernat/haproxy-2.0 -y
apt-get -y install haproxy=2.0.\*
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
echo "Setup Dependencies For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
curl https://haproxy.debian.net/bernat.debian.org.gpg |
gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
http://haproxy.debian.net buster-backports-1.8 main \
>/etc/apt/sources.list.d/haproxy.list
sudo apt-get update
apt-get -y install haproxy=1.8.\*
else
echo -e " Your OS Is Not Supported ($(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g') )"
exit 1
fi
}
clear
function nginx_install() {
if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
print_install "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
sudo apt-get install nginx -y
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
print_success "Setup nginx For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
apt -y install nginx
else
echo -e " Your OS Is Not Supported ( ${YELLOW}$(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')${FONT} )"
fi
}
function base_package() {
clear
apt install zip pwgen openssl netcat socat cron bash-completion -y
apt install figlet -y
apt update -y
apt upgrade -y
apt install bmon -y
apt dist-upgrade -y
systemctl enable chronyd
systemctl restart chronyd
systemctl enable chrony
systemctl restart chrony
chronyc sourcestats -v
chronyc tracking -v
apt install ntpdate -y
ntpdate pool.ntp.org
apt install sudo -y
sudo apt-get clean all
sudo apt-get autoremove -y
sudo apt-get install -y debconf-utils
sudo apt-get remove --purge exim4 -y
sudo apt-get remove --purge ufw firewalld -y
sudo apt-get install -y --no-install-recommends software-properties-common
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
sudo apt-get install -y speedtest-cli vnstat libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-nss-dev flex bison make libnss3-tools libevent-dev bc rsyslog dos2unix zlib1g-dev libssl-dev libsqlite3-dev sed dirmngr libxml-parser-perl build-essential gcc g++ python htop lsof tar wget curl ruby zip unzip p7zip-full python3-pip libc6 util-linux build-essential msmtp-mta ca-certificates bsd-mailx iptables iptables-persistent netfilter-persistent net-tools openssl ca-certificates gnupg gnupg2 ca-certificates lsb-release gcc shc make cmake git screen socat xz-utils apt-transport-https gnupg1 dnsutils cron bash-completion ntpdate chrony jq openvpn easy-rsa
}
clear
restart_system() {
USRSC=$(wget -qO- https://raw.githubusercontent.com/${GIT_USER}/vps_access/main/ip | grep $Ip_Vps | awk '{print $2}')
EXPSC=$(wget -qO- https://raw.githubusercontent.com/${GIT_USER}/vps_access/main/ip | grep $Ip_Vps | awk '{print $3}')
TIMEZONE=$(printf '%(%H:%M:%S)T')
domain=$(cat /etc/xray/domain)
TEXT="
<code>────────────────────</code>
<b> 🟢 NOTIFICATIONS INSTALL 🟢</b>
<code>────────────────────</code>
<code>ID     : </code><code>$USRSC</code>
<code>Domain : </code><code>$domain</code>
<code>Date   : </code><code>$TIME</code>
<code>Time   : </code><code>$TIMEZONE</code>
<code>Ip vps : </code><code>$Ip_Vps</code>
<code>Exp Sc : </code><code>$EXPSC</code>
<code>────────────────────</code>
<i>Automatic Notification from Github</i>
"'&reply_markup={"inline_keyboard":[[{"text":"⭐ᴏʀᴅᴇʀ⭐","url":"https://t.me/ian_khvicha"},{"text":"⭐ɪɴꜱᴛᴀʟʟ⭐","url":"https://wa.me/6283189774145"}]]}'
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL >/dev/null
}
clear
function pasang_ssl() {
clear
rm -rf /etc/xray/xray.key
rm -rf /etc/xray/xray.crt
domain=$(cat /etc/xray/domain)
STOPWEBSERVER=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
rm -rf /root/.acme.sh
mkdir /root/.acme.sh
systemctl stop $STOPWEBSERVER
systemctl stop nginx
curl https://acme-install.netlify.app/acme.sh -o /root/.acme.sh/acme.sh
chmod +x /root/.acme.sh/acme.sh
/root/.acme.sh/acme.sh --upgrade --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
chmod 777 /etc/xray/xray.key
}
function make_folder_xray() {
rm -rf /etc/lunatic/vmess/.vmess.db
rm -rf /etc/lunatic/vless/.vless.db
rm -rf /etc/lunatic/trojan/.trojan.db
rm -rf /etc/lunatic/shadowsocks/.shadowsocks.db
rm -rf /etc/lunatic/ssh/.ssh.db
rm -rf /etc/lunatic/bot/.bot.db

mkdir -p /etc/lunatic
mkdir -p /etc/limit
mkdir -p /etc/lunatic/vmess/ip
mkdir -p /etc/lunatic/vless/ip
mkdir -p /etc/lunatic/trojan/ip
mkdir -p /etc/lunatic/ssh/ip
mkdir -p /etc/lunatic/vmess/detail
mkdir -p /etc/lunatic/vless/detail
mkdir -p /etc/lunatic/trojan/detail
mkdir -p /etc/lunatic/shadowsocks/detail
mkdir -p /etc/lunatic/ssh/detail
mkdir -p /etc/lunatic/noobzvpns/detail

mkdir -p /etc/lunatic/vmess/usage
mkdir -p /etc/lunatic/vless/usage
mkdir -p /etc/lunatic/shadowsocks/usage
mkdir -p /etc/lunatic/trojan/usage
mkdir -p /etc/lunatic/bot
mkdir -p /etc/lunatic/bot/telegram
mkdir -p /etc/lunatic/bot/notif
chmod +x /var/log/xray
mkdir -p /usr/bin/xray
mkdir -p /var/log/xray
mkdir -p /var/www/html
mkdir -p /usr/sbin/local

touch /etc/xray/domain
touch /var/log/xray/access.log
touch /var/log/xray/error.log
touch /etc/lunatic/vmess/.vmess.db
touch /etc/lunatic/vless/.vless.db
touch /etc/lunatic/trojan/.trojan.db
touch /etc/lunatic/shadowsocks/.shadowsocks.db
touch /etc/lunatic/ssh/.ssh.db
touch /etc/lunatic/bot/.bot.db
touch /etc/lunatic/bot/notif/key
touch /etc/lunatic/bot/notif/id
echo "& plughin Account" >>/etc/lunatic/vmess/.vmess.db
echo "& plughin Account" >>/etc/lunatic/vless/.vless.db
echo "& plughin Account" >>/etc/lunatic/trojan/.trojan.db
echo "& plughin Account" >>/etc/lunatic/shadowsocks/.shadowsocks.db
echo "& plughin Account" >>/etc/lunatic/ssh/.ssh.db
echo "& plughin Account" >>/etc/lunatic/noobzvpns/.noobzvpns.db
}
function install_xray() {
clear
domainSock_dir="/run/xray";! [ -d $domainSock_dir ] && mkdir  $domainSock_dir
chown www-data.www-data $domainSock_dir
latest_version="$(curl -s https://api.github.com/repos/XTLS/Xray-core/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
bash -c "$(curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh)" @ install -u www-data --version $latest_version
wget -O /etc/xray/config.json "${REPO}cfg_conf_js/config.json" >/dev/null 2>&1
wget -O /etc/systemd/system/runn.service "${REPO}files/runn.service" >/dev/null 2>&1
domain=$(cat /etc/xray/domain)
IPVS=$(cat /etc/xray/ipvps)
clear
curl -s ipinfo.io/city >>/etc/xray/city
curl -s ipinfo.io/org | cut -d " " -f 2-10 >>/etc/xray/isp

wget -O /etc/haproxy/haproxy.cfg "${REPO}cfg_conf_js/haproxy.cfg" >/dev/null 2>&1
wget -O /etc/nginx/conf.d/xray.conf "${REPO}cfg_conf_js/xray.conf" >/dev/null 2>&1
sed -i "s/xxx/${domain}/g" /etc/haproxy/haproxy.cfg
sed -i "s/xxx/${domain}/g" /etc/nginx/conf.d/xray.conf
curl ${REPO}cfg_conf_js/nginx.conf > /etc/nginx/nginx.conf
cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
chmod +x /etc/systemd/system/runn.service
rm -rf /etc/systemd/system/xray.service.d

# xray service
cat >/etc/systemd/system/xray.service <<EOF
Description=Xray Service
Documentation=https://github.com
After=network.target nss-lookup.target
[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
filesNPROC=10000
filesNOFILE=1000000
[Install]
WantedBy=multi-user.target
EOF
}

function ssh(){
clear
wget -O /etc/pam.d/common-password "${REPO}files/password"
chmod +x /etc/pam.d/common-password
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure keyboard-configuration
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/altgr select The default for the keyboard layout"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/compose select No compose key"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/ctrl_alt_bksp boolean false"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layoutcode string de"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/layout select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/modelcode string pc105"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/optionscode string "
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/store_defaults_in_debconf_db boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/switch select No temporary switch"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/toggle select No toggling"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_layout boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_config_options boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_layout boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/unsupported_options boolean true"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variantcode string "
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/variant select English"
debconf-set-selections <<<"keyboard-configuration keyboard-configuration/xkb-keymap select "
cd
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
cat > /etc/rc.local <<-END
exit 0
END
chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
}
function udp_mini(){
clear
wget raw.githubusercontent.com/${GIT_USER}/${GIT_REPO}/${GIT_BRANCH}/files/limit-quota.sh && chmod +x limit-quota.sh && ./limit-quota.sh
wget raw.githubusercontent.com/${GIT_USER}/${GIT_REPO}/${GIT_BRANCH}/lock-service.sh && chmod +x lock-service.sh && ./lock-service.sh
cd
mkdir -p /usr/bin/limit-ip
wget -q -O /usr/bin/limit-ip "${REPO}files/limit-ip"
chmod +x /usr/bin/*
cd /usr/bin
sed -i 's/\r//' limit-ip
cd
clear
cat >/etc/systemd/system/vmip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vmip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vmip
systemctl enable vmip
cat >/etc/systemd/system/vlip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip vlip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart vlip
systemctl enable vlip
cat >/etc/systemd/system/trip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip trip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart trip
systemctl enable trip
cat >/etc/systemd/system/ssip.service << EOF
[Unit]
Description=My
ProjectAfter=network.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/limit-ip ssip
Restart=always
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart ssip
systemctl enable ssip


mkdir -p /usr/lunatic/
wget -q -O /usr/lunatic/udp-mini "${REPO}files/udp-mini"
chmod +x /usr/lunatic/udp-mini
wget -q -O /etc/systemd/system/udp-mini-1.service "${REPO}files/udp-mini-1.service"
wget -q -O /etc/systemd/system/udp-mini-2.service "${REPO}files/udp-mini-2.service"
wget -q -O /etc/systemd/system/udp-mini-3.service "${REPO}files/udp-mini-3.service"
systemctl disable udp-mini-1
systemctl stop udp-mini-1
systemctl enable udp-mini-1
systemctl start udp-mini-1
systemctl disable udp-mini-2
systemctl stop udp-mini-2
systemctl enable udp-mini-2
systemctl start udp-mini-2
systemctl disable udp-mini-3
systemctl stop udp-mini-3
systemctl enable udp-mini-3
systemctl start udp-mini-3
}
function ssh_slow(){
clear
wget -q -O /tmp/nameserver "${REPO}slowdns/nameserver" >/dev/null 2>&1
wget ${REPO_SLOWDNS}slowdns/slowdns.sh && chmod +x slowdns.sh && ./slowdns.sh
chmod +x /tmp/nameserver
bash /tmp/nameserver | tee /root/install.log
rm -rf slowdns.sh
}
clear
function ins_SSHD(){
clear
wget -q -O /etc/ssh/sshd_config "${REPO}files/sshd" >/dev/null 2>&1
chmod 700 /etc/ssh/sshd_config
/etc/init.d/ssh restart
systemctl restart ssh
/etc/init.d/ssh status
}
clear
function ins_dropbear(){
clear
apt-get install dropbear -y > /dev/null 2>&1
wget -q -O /etc/default/dropbear "${REPO}cfg_conf_js/dropbear.conf"
chmod +x /etc/default/dropbear
/etc/init.d/dropbear restart
/etc/init.d/dropbear status
}
clear
function ins_vnstat(){
clear
apt -y install vnstat > /dev/null 2>&1
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev > /dev/null 2>&1
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
/etc/init.d/vnstat status
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6
}
function ins_openvpn(){
clear
wget ${REPO}files/openvpn &&  chmod +x openvpn && ./openvpn
/etc/init.d/openvpn restart
}
function ins_backup(){
clear
apt install rclone -y
printf "q\n" | rclone config
wget -O /root/.config/rclone/rclone.conf "${REPO}cfg_conf_js/rclone.conf"
cd /bin
git clone  https://github.com/LunaticTunnel/wondershaper.git
cd wondershaper
sudo make install
cd
rm -rf wondershaper
echo > /home/files
apt install msmtp-mta ca-certificates bsd-mailx -y
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host smtp.gmail.com
port 587
auth on
user oceantestdigital@gmail.com
from oceantestdigital@gmail.com
password jokerman77
logfile ~/.msmtp.log
EOF
chown -R www-data:www-data /etc/msmtprc
wget -q -O /etc/ipserver "${REPO}files/ipserver" && bash /etc/ipserver
}
clear
function ins_swab(){
clear
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb >/dev/null 2>&1
dd if=/dev/zero of=/swapfile bs=1024 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile >/dev/null 2>&1
swapon /swapfile >/dev/null 2>&1
sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab
chronyd -q 'server 0.id.pool.ntp.org iburst'
chronyc sourcestats -v
chronyc tracking -v
wget ${REPO}files/bbr.sh &&  chmod +x bbr.sh && ./bbr.sh
}
function ins_Fail2ban(){
clear
if [ -d '/usr/local/ddos' ]; then
echo; echo; echo "Please un-install the previous version first"
exit 0
else
mkdir /usr/local/ddos
fi
clear
echo "Banner /etc/banner.txt" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/banner.txt"@g' /etc/default/dropbear
wget -O /etc/banner.txt "${REPO}banner/issue.net"
}
function ins_epro(){
clear
wget -O /usr/bin/ws "${REPO}files/ws" >/dev/null 2>&1
wget -O /usr/bin/tun.conf "${REPO}cfg_conf_js/tun.conf" >/dev/null 2>&1
wget -O /etc/systemd/system/ws.service "${REPO}files/ws.service" >/dev/null 2>&1
chmod +x /etc/systemd/system/ws.service
chmod +x /usr/bin/ws
chmod 644 /usr/bin/tun.conf
systemctl disable ws
systemctl stop ws
systemctl enable ws
systemctl start ws
systemctl restart ws
wget -q -O /usr/local/share/xray/geosite.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat" >/dev/null 2>&1
wget -q -O /usr/local/share/xray/geoip.dat "https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat" >/dev/null 2>&1
wget -O /usr/sbin/ftvpn "${REPO}files/ftvpn" >/dev/null 2>&1
chmod +x /usr/sbin/ftvpn
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload
cd
apt autoclean -y >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
}
function ins_restart(){
clear
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/vnstat restart
systemctl restart haproxy
/etc/init.d/cron restart
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now nginx
systemctl enable --now xray
systemctl enable --now rc-local
systemctl enable --now dropbear
systemctl enable --now openvpn
systemctl enable --now cron
systemctl enable --now haproxy
systemctl enable --now netfilter-persistent
systemctl enable --now ws
systemctl enable --now fail2ban
history -c
echo "unset HISTFILE" >> /etc/profile
cd
rm -f /root/openvpn
rm -f /root/key.pem
rm -f /root/cert.pem
print_success "All Packet"
}
function menu(){
clear
# install menu shell
wget ${REPO}feature/LunatiX2
unzip LunatiX2
chmod +x menu/*
mv menu/* /usr/local/sbin
rm -rf menu
rm -rf LunatiX2
# install menu py
wget ${REPO}feature/LunatiX_py
unzip LunatiX_py
chmod +x menu/*
mv menu/* /usr/bin
rm -rf menu
rn -rf LunatiX_py
}
function profile(){
cat >/root/.profile <<EOF
if [ "$BASH" ]; then
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
fi
mesg n || true
python3 /usr/bin/menu
EOF

#function profile(){
#clear
#cat >/root/.profile <<EOF
#if [ "$BASH" ]; then
#if [ -f ~/.bashrc ]; then
#. ~/.bashrc
#fi
#fi
#mesg n || true
#menu
#EOF

cat >/etc/cron.d/xp_all <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
2 0 * * * root /usr/local/sbin/xp
END
cat >/etc/cron.d/logclean <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
*/10 * * * * root /usr/local/sbin/clearlog
END
chmod 644 /root/.profile
cat >/etc/cron.d/daily_reboot <<-END
SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
0 5 * * * root /sbin/reboot
END
echo "*/1 * * * * root echo -n > /var/log/nginx/access.log" >/etc/cron.d/log.nginx
echo "*/1 * * * * root echo -n > /var/log/xray/access.log" >>/etc/cron.d/log.xray
service cron restart
cat >/home/daily_reboot <<-END
5
END
cat >/etc/systemd/system/rc-local.service <<EOF
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
EOF
echo "/bin/false" >>/etc/shells
echo "/usr/sbin/nologin" >>/etc/shells
cat >/etc/rc.local <<EOF
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
systemctl restart netfilter-persistent
exit 0
EOF
chmod +x /etc/rc.local
AUTOREB=$(cat /home/daily_reboot)
SETT=11
if [ $AUTOREB -gt $SETT ]; then
TIME_DATE="PM"
else
TIME_DATE="AM"
fi
}
function install_udp() {
cd
rm -rf /root/udp
mkdir -p /etc/udp
# change to time GMT+7
echo "change to time GMT+7"
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# install udp-custom
echo downloading udp-custom
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1ixz82G_ruRBnEEp4vLPNF2KZ1k8UfrkV' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1ixz82G_ruRBnEEp4vLPNF2KZ1k8UfrkV" -O /etc/udp/udp-custom && rm -rf /tmp/cookies.txt
chmod +x /etc/udp/udp-custom

echo downloading default config
wget -q --show-progress --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1klXTiKGUd2Cs5cBnH3eK2Q1w50Yx3jbf' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1klXTiKGUd2Cs5cBnH3eK2Q1w50Yx3jbf" -O /etc/udp/config.json && rm -rf /tmp/cookies.txt
chmod 644 /etc/udp/config.json

if [ -z "$1" ]; then
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/etc/udp/udp-custom server
WorkingDirectory=/etc/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
else
cat <<EOF > /etc/systemd/system/udp-custom.service
[Unit]
Description=UDP Custom by ePro Dev. Team

[Service]
User=root
Type=simple
ExecStart=/etc/udp/udp-custom server -exclude $1
WorkingDirectory=/etc/udp/
Restart=always
RestartSec=2s

[Install]
WantedBy=default.target
EOF
fi
echo start service udp-custom
systemctl start udp-custom &>/dev/null
echo enable service udp-custom
systemctl enable udp-custom &>/dev/null
clear
}
function enable_services(){
clear
systemctl daemon-reload
systemctl start netfilter-persistent
systemctl enable --now rc-local
systemctl enable --now cron
systemctl enable --now netfilter-persistent
systemctl restart nginx
systemctl restart xray
systemctl restart cron
systemctl restart haproxy
systemctl restart lock-vme
systemctl restart lock-vle
systemctl restart lock-ssr
systemctl restart lock-ssh
systemctl restart lock-tro
systemctl restart kill-vme
systemctl restart kill-vle
systemctl restart kill-ssr
systemctl restart kill-ssh
systemctl restart kill-tro=
clear
}
clear_all() {
history -c
rm -rf /root/menu
rm -rf /root/*.zip
rm -rf /root/*.sh
rm -rf /root/LICENSE
rm -rf /root/README.md
rm -rf /etc/xray/domain
rm -rf /root/LunatiX2
rm -rf /root/LunatiX_py
rm -rf /root/UDP
rm -rf /root/udp
rm -rf /root/install.log
rm -rf /root/snap
rm -rf /root/nsdomain
secs_to_human "$(($(date +%s) - ${start}))"
sudo hostnamectl set-hostname $username
}

fun_bar 'first_setup'
fun_bar 'nginx_install'
fun_bar 'base_package'
fun_bar 'make_folder_xray'
fun_bar 'password_default'
fun_bar 'pasang_ssl'
fun_bar 'install_xray'
fun_bar 'ssh'
fun_bar 'udp_mini'
fun_bar 'ssh_slow'
fun_bar 'ins_SSHD'
fun_bar 'ins_dropbear'
fun_bar 'ins_vnstat'
fun_bar 'ins_openvpn'
fun_bar 'ins_backup'
fun_bar 'ins_swab'
fun_bar 'ins_Fail2ban'
fun_bar 'ins_epro'
fun_bar 'ins_restart'
fun_bar 'menu'
fun_bar 'profile'
fun_bar 'install_udp'
fun_bar 'enable_services'
fun_bar 'restart_system'
fun_bar 'clear_all'
}


install_script

clear
echo -e ""
echo -e "   \e[97;1m ===========================================\e[0m"
echo -e "   \e[92;1m     Install Succesfully bro! Good Job!     \e[0m"
echo -e "   \e[97;1m ===========================================\e[0m"
echo ""
read -p "$( echo -e "Press ${YELLOW}[ ${NC}${YELLOW}Enter${NC} ${YELLOW}]${NC} TO REBOOT") "
reboot
