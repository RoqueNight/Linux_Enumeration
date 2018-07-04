#!/bin/bash

# ******************************************************************
# ******************************************************************
# **                                                              **
# **                 Linux Enumeration                            **
# **                 Armand Kruger                                **
# **                                                              **
# **                                                              **
# ******************************************************************
# ******************************************************************



#Loading colors into BASH
red='\e[1;31m' #red text
yellow='\e[0;33m' #yellow text
RESET="\033[00m" #normal text
orange='\e[38;5;166m' #orange text

PWD="$(pwd)" 
Version="$(uname -a)" 
Hostname="$(hostname)" 
Who="$(whoami)" 
ID="$(id)" 
IP="$(ifconfig eth0 | grep 'inet' | cut -d' ' -f 10 | grep -v 'fe')" 
Arch="$(getconf LONG_BIT)" 
Route="$(route)" 
Users="$(cat /etc/passwd | cut -d':' -f 1| grep -v 'irc'| grep -v 'gnats' | grep -v postgres | grep -v daemon | grep -v bin | grep -v games | grep -v sys | grep -v sync | grep -v lp| grep -v mail| grep -v news | grep -v uucp | grep -v proxy | grep -v 'www-data' | grep -v backup | grep -v list| grep -v nobody | grep -v 'systemd-timesync' | grep -v 'systemd-network' | grep -v 'systemd-resolve' | grep -v man | grep -v '_apt' | grep -v messagebus | grep -v mysql | grep -v avahi | grep -v miredo | grep -v ntp | grep -v stunnel4 | grep -v uuidd | grep -v 'Debian-exim' | grep -v statd | grep -v arpwatch | grep -v colord | grep -v epmd | grep -v couchdb | grep -v dnsmasq | grep -v geoclue | grep -v pulse | grep -v 'speech-dispatcher' | grep -v sshd | grep -v iodine | grep -v 'king-phisher' | grep -v redsocks | grep -v rwhod | grep -v sslh | grep -v rtkit | grep -v saned | grep -v usbmux | grep -v 'Debian-gdm' | grep -v 'beef-xss' | grep -v dradis| grep -v clamav | grep -v redis| grep -v 'Debian-snmp')" 
DNS="$(cat /etc/resolv.conf | grep nameserver | cut -d ' ' -f 2)" 
GCC="$(gcc --version | grep gcc)" 
SQL="$(mysql --version)" 
Perl="$(perl --version | grep perl | grep subversion)" 
Ruby="$(ruby --version)" 
Python="$(python -c 'import sys; print(".".join(map(str, sys.version_info[:3])))')" 
PrintPath="$(echo $PATH)" 


echo " _______________________________________________________________________________________________________________________________________________________________________________________________________"
echo "|                                                                       "
echo "|   Name         | Description          |         Target Info           "
echo "|_______________________________________________________________________________________________________________________________________________________________________________________________________"
echo "|                                                                       "
echo "|   Version      | Kernel Running       | $Version"
echo "|   Hostname     | Hostname for system  | $Hostname"
echo "|   User         | Current User         | $Who"
echo "|   Permissions  | Current Permissions  | $ID"
echo "|   IP           | Current IP           | $IP"
echo "|   Architecture | CPU Architecture     | $Arch-bit"
echo "|   DNS          | Default Nameserver   | $DNS"
echo "|   GCC          | GCC Version          | $GCC"
echo "|   SQL          | SQL Version          | $SQL"
echo "|   Perl         | Perl Version         | $Perl"
echo "|   Ruby         | Ruby Version         | $Ruby"
echo "|   Python       | Python Version       | $Python"
echo "|   Path         | Path Variables       | $PrintPath"
echo "|_______________________________________________________________________________________________________________________________________________________________________________________________________"
echo " "

echo -e $yellow"========================================================================================================================================================================================================"$RESET
CheckIfRoot="id -u"
Shadow="cat /etc/shadow | cut -d ':' -f1-2 | grep -v '*' | grep -v '!'"
if [[ "$CheckIfRoot" -eq 0 ]]; 
then echo -e $orange"Possible Hashes\n" $RESET; eval $Shadow
else 
echo -e $red"su root for Hashes\n" $RESET
fi

echo -e $yellow"========================================================================================================================================================================================================"$RESET

IPTables="iptables -L -n -v"
echo -e $orange"Active Firewall Rules\n" $RESET; $IPTables

echo -e $yellow"========================================================================================================================================================================================================"$RESET

echo -e $orange"All Home Directories"$RESET
Home="ls -alh"
cd /home; $Home
cd $PWD

echo -e $yellow"========================================================================================================================================================================================================"$RESET

SUID="find / -perm -4000 2>/dev/null"
echo  -e $orange"Dumping SUID)\n" $RESET; eval $SUID

echo -e $yellow"========================================================================================================================================================================================================"$RESET

Sudo="sudo -l"
echo -e $orange"Programs that can run as an Sudo user\n" $RESET; $Sudo

echo -e $yellow"========================================================================================================================================================================================================"$RESET

Cron="cat /etc/crontab"
echo -e $orange"Current Cron Jobs\n" $RESET; $Cron

echo -e $yellow"========================================================================================================================================================================================================"$RESET

LoggedIn="w"
echo -e $orange"Logged on Users\n" $RESET; $LoggedIn

echo -e $yellow"========================================================================================================================================================================================================"$RESET

Arp="arp -e"
echo -e $orange"ARP Table\n" $RESET; eval $Arp

echo -e $yellow"========================================================================================================================================================================================================"$RESET

PossibleMount="cat /etc/fstab"
echo -e $orange"File System Information\n" $RESET; $PossibleMount

echo -e $yellow"========================================================================================================================================================================================================"$RESET

Connections="netstat -anop | grep -v STREAM | grep -v DGRAM | grep -v unix | grep -v RefCnt | grep -v UNIX"
echo -e $orange"Current Open Connections\n" $RESET; eval $Connections

echo -e $yellow"========================================================================================================================================================================================================"$RESET

Service="service --status-all | column"
echo -e $orange"List of All Service\n" $RESET; eval $Service
echo " "
