#!/bin/sh

DIALOG_TITLE="SPECCHIO Update Tool"
# TODO: Switch to official domain, once the DNS records are in place.
DOWNLOAD_URL="https://jenkins.winpat.ch/job/SPECCHIO/lastSuccessfulBuild/artifact/src/"

function cleanup {
	rm -fr /tmp/specchio-client
	rm -fr /tmp/specchio-webapp
	rm -f /tmp/specchio-client.zip
	rm -f /tmp/specchio-webapp.zip
}
trap cleanup EXIT


zenity --question \
	       --text "This script will download the newest version of the SPECCHIO client and webapp from specchio.ch. Are you sure that you want to do this?

Please checkout the Release notes first and consider doing a database backup." \
	       --title "${DIALOG_TITLE}" \
	       --width 380

wget --progress=bar:force "${DOWNLOAD_URL}/client/build/distributions/specchio-client.zip" -O /tmp/specchio-client.zip 2>&1 \
	| zenity \
		--progress \
		--text "Downloading SPECCHIO client" \
		--auto-close \
		--auto-kill

unzip -o -d /tmp/specchio-client /tmp/specchio-client.zip \
	| zenity \
		--progress \
		--pulsate \
		--text "Extracting SPECCHIO client" \
		--auto-close \
		--auto-kill
wget --progress=bar:force "${DOWNLOAD_URL}/webapp/build/distributions/specchio-webapp.zip" -O /tmp/specchio-webapp.zip 2>&1 \
	| zenity \
		--progress \
		--text "Downloading SPECCHIO webapp" \
		--auto-close \
		--auto-kill

unzip -o -d /tmp/specchio-webapp /tmp/specchio-webapp.zip \
	| zenity \
		--progress \
		--pulsate \
		--text "Extracting SPECCHIO webapp" \
		--auto-close \
		--auto-kill
