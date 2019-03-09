#!/bin/sh

DIALOG_TITLE="SPECCHIO Backup Tool"

ACTION=$(echo -e "Backup\nRestore" | zenity --list \
					    --text "Do you want to create a backup or restore an existing one?" \
					    --column "Action" \
					    --title "${DIALOG_TITLE}")

function backup {
    zenity --question \
	   --text "Are you sure you want to backup the database?" \
	   --title "${DIALOG_TITLE}" \
	   --width 380

    if [[ $? -eq 0 ]]; then
	sudo mysqldump --all-databases \
	     --events \
	     --ignore-table=mysql.event \
	     --extended-insert \
	     --add-drop-database \
	     --disable-keys \
	     --flush-privileges \
	     --quick \
	     --routines \
	     --triggers \
	    | gzip -9 -c > SPECCHIO_$(date +%Y%m%d_%H%M%S).sql.gz \
	    | zenity \
		  --progress \
		  --pulsate \
		  --auto-close \
		  --auto-kill \
		  --text "This could take a while."

	if [[ $? -eq 0 ]]; then
	    zenity --info --width 380 --text "Backup was successful"
	else
	    zenity --info --width 380 --text "Backup failed with return code $?"
	fi
    else
	exit 0
    fi
}

function restore {
    local FILENAME="$(zenity --file-selection)"

    if [[ ! -f ${FILENAME} ]]; then
	zenity --error \
	       --text "File does not exist!" \
	       --title "${DIALOG_TITLE}" \
	       --width 380
	exit 1
    fi

    zenity --warning \
	   --text "This will delete all the data of the current database (including users and passwords). Are you sure you want to restore the database from the specified dump?" \
	   --title "${DIALOG_TITLE}" \
	   --width 380

    if [[ $? -eq 0 ]]; then
	gunzip -c "${FILENAME}" \
	    | sudo mysql \
	    | zenity \
		  --progress \
		  --pulsate \
		  --auto-close \
		  --auto-kill \
		  --text "This could take a while."

	if [[ $? -eq 0 ]]; then
	    zenity --info --width 380 --text "Restore was successful"
	else
	    zenity --info --width 380 --text "Restore failed with return code $?"
	fi
    else
	exit 0
    fi
}

if [[ ${ACTION} == "Backup" ]]; then
    backup
elif [[ ${ACTION} == "Restore" ]]; then
    restore
fi
