#!/bin/bash

#variables
VERSION="1.0.0"
SOURCE=$(dirname ${BASH_SOURCE[0]})
INITSCRIPT="$SOURCE/prerender.init";
bold=`tput bold`
normal=`tput sgr0`

#parse options
SHOW_HELP=false
UNINSTALL=false
VERBOSE=false
for i in "$@"
do
	case $i in
		-h|--help)
			SHOW_HELP=true
		;;

		-u|--uninstall)
			UNINSTALL=true
		;;

		-v|--verbose)
			VERBOSE=true
		;;
	esac
done

banner() {	
	echo "" 1>&3 2>&4;
	echo "» ${bold}Prerender-daemon installer v${VERSION}${normal} by Luciano Mammino"
	echo "»  http://loige.com"
	echo "»  https://github.com/lmammino/prerender-daemon"
	echo ""
}

# display help
if [ "$SHOW_HELP" = true ]; then
	banner;

	cat << EOF
 Usage:

	sudo ./install.sh [-h|--help] [-u|--uninstall]

 options:

	-h|--help		Display this help
	-u|--uninstall		Uninstall prerender
	-v|--verbose		Enable verbose output

EOF

	exit 0;
fi

#should be run as sudo
if [ "$UID" -ne 0 ]; then
	echo "WARNING: it seems that the installer has not be run as root. It may not work as intended."
fi

#manage verbosity
exec 3>&1
exec 4>&2
if [ "$VERBOSE" = false ]; then
	exec 1>/dev/null
	exec 2>/dev/null
fi

#uninstall
if [ "$UNINSTALL" = true ]; then
	banner 1>&3 2>&4
	echo " ${bold}Uninstalling prerender-daemon${normal}" 1>&3 2>&4

	/etc/init.d/prerender stop
	echo "  ${bold}✓${normal} Daemon stopped" 1>&3 2>&4

	rm /etc/init.d/prerender
	echo "  ${bold}✓${normal} Init script deleted" 1>&3 2>&4

	rm -rf /var/run/prerender
	echo "  ${bold}✓${normal} PID folder deleted" 1>&3 2>&4

	userdel prerender
	echo "  ${bold}✓${normal} prerender user deleted" 1>&3 2>&4

	groupdel prerender
	echo "  ${bold}✓${normal} prerender user group deleted" 1>&3 2>&4

	npm uninstall -g prerender
	echo "  ${bold}✓${normal} npm prerender uninstalled" 1>&3 2>&4

	echo " Done." 1>&3 2>&4

	exit 0;
fi


#install
banner 1>&3 2>&4
echo " ${bold}Installing prerender-daemon${normal}" 1>&3 2>&4

npm install --global prerender 1>&3 2>&4
echo "  ${bold}✓${normal} npm prerender installed" 1>&3 2>&4

useradd -r -s /bin/false prerender
echo "  ${bold}✓${normal} prerender user and user group added" 1>&3 2>&4

mkdir -p /var/run/prerender
echo "  ${bold}✓${normal} PID folder created" 1>&3 2>&4

cp $INITSCRIPT /etc/init.d/prerender
chmod +x /etc/init.d/prerender
update-rc.d prerender defaults
echo "  ${bold}✓${normal} Init script installed" 1>&3 2>&4

/etc/init.d/prerender start
echo "  ${bold}✓${normal} Daemon started" 1>&3 2>&4

echo " Done." 1>&3 2>&4

exit 0;