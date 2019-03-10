#!/bin/sh

DIALOG_TITLE="SPECCHIO Update Tool"
# TODO: Switch to official domain, once the DNS records are in place.
DOWNLOAD_URL="https://jenkins.winpat.ch/job/SPECCHIO/lastSuccessfulBuild/artifact/src/"
INSTALL_DIRECTORY="/opt/SPECCHIO"
SPECCHIO_WEBAPP_WAR="${INSTALL_DIRECTORY}/specchio-webapp/webapp-3.3.0.war"
SPECCHIO_CLIENT_JAR="${INSTALL_DIRECTORY}/specchio-client/specchio-client.jar"

if [[ ! -f "${SPECCHIO_CLIENT_JAR}" ]]; then
	zenity \
		--error \
		--text "The old client is not at the expected location (${SPECCHIO_CLIENT_JAR}). Please ensure that you have NOT modified the default installation location." \
	       	--title "${DIALOG_TITLE}" \
	       	--width 380
	exit 1
fi

if [[ ! -f "${SPECCHIO_WEBAPP_WAR}" ]]; then
	zenity \
		--error \
		--text "The old webapp is not at the expected location (${SPECCHIO_WEBAPP_WAR}). Please ensure that you have NOT modified the default installation location." \
	       	--title "${DIALOG_TITLE}" \
	       	--width 380
	exit 1
fi

function cleanup {
	sudo rm -fr /tmp/specchio-client
	sudo rm -fr /tmp/specchio-webapp
	sudo rm -f /tmp/specchio-client.zip
	sudo rm -f /tmp/specchio-webapp.zip
}
trap cleanup EXIT


zenity --question \
	       --text "This script will download the newest version of the SPECCHIO client and webapp from specchio.ch. Please checkout the release notes and consider doing a database backup first.

Are you sure that you want to do this?" \
	       --title "${DIALOG_TITLE}" \
	       --width 380


if [[ $? -ne 0 ]]; then
        exit 1
fi

sudo wget --progress=bar:force "${DOWNLOAD_URL}/client/build/distributions/specchio-client.zip" -O /tmp/specchio-client.zip 2>&1 \
	| zenity \
		--progress \
	       	--title "${DIALOG_TITLE}" \
		--text "Downloading SPECCHIO client" \
		--auto-close \
		--auto-kill \
	       	--width 380

sudo unzip -o -d /tmp/ /tmp/specchio-client.zip \
	| zenity \
		--progress \
		--pulsate \
	       	--title "${DIALOG_TITLE}" \
		--text "Extracting SPECCHIO client" \
		--auto-close \
		--auto-kill \
	       	--width 380

sudo rm -f "${SPECCHIO_CLIENT_JAR}"
sudo mv /tmp/specchio-client/specchio-client.jar "${SPECCHIO_CLIENT_JAR}"

sudo wget --progress=bar:force "${DOWNLOAD_URL}/webapp/build/distributions/specchio-webapp.zip" -O /tmp/specchio-webapp.zip 2>&1 \
	| zenity \
		--progress \
	       	--title "${DIALOG_TITLE}" \
		--text "Downloading SPECCHIO webapp" \
		--auto-close \
		--auto-kill \
	       	--width 380

sudo unzip -o -d /tmp/ /tmp/specchio-webapp.zip \
	| zenity \
		--progress \
		--pulsate \
	       	--title "${DIALOG_TITLE}" \
		--text "Extracting SPECCHIO webapp" \
		--auto-close \
		--auto-kill \
	       	--width 380

sudo rm -f "${SPECCHIO_WEBAPP_WAR}"
sudo mv /tmp/specchio-webapp/webapp-3.3.0.war "${SPECCHIO_WEBAPP_WAR}"

sudo /opt/glassfish4/glassfish/bin/asadmin deploy --force "${SPECCHIO_WEBAPP_WAR}" \
	| zenity \
		--progress \
		--pulsate \
	       	--title "${DIALOG_TITLE}" \
		--text "Deploying SPECCHIO webapp to glassfish" \
		--auto-close \
		--auto-kill \
	       	--width 380

if [[ ${PIPESTATUS[0]} -ne 0 ]]; then
	zenity \
		--error \
		--text "Deployment of the new webapp war file failed." \
	       	--title "${DIALOG_TITLE}" \
	       	--width 380
	exit 1
fi


zenity \
	--info \
	--text "Update was successful." \
       	--title "${DIALOG_TITLE}" \
       	--width 380
