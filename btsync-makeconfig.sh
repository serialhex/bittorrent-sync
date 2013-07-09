#!/bin/bash
#
# Generate a default BitTorrent Sync config file for the current user.
# The config file is written to standard out.

##############################
# READ INPUT
##############################
for arg in $@; do
	case $previous in
		--device-name|--hostname)
			devicename=$arg;;
		--port)
			port=$arg;;
		--storage-path)
			storagepath=$arg;;
		--check-for-updates)
			checkupdates=$arg;;
		--upnp)
			upnp=$arg;;
		--downlimit)
			downlimit=$arg;;
		--uplimit)
			uplimit=$arg;;
		--webport)
			webport=$arg;;
		--login)
			login=$arg;;
		--pass|--password)
			password=$arg;;
	esac
	previous=$arg
done

##############################
# DEFAULTS
##############################
devicename=${devicename:-$(hostname)}
port=${port:-0}
storagepath=${storagepath:-$HOME/.config/btsync}
checkupdates=${checkupdates:-true}
upnp=${upnp:-true}
downlimit=${downlimit:-0}
uplimit=${uplimit:-0}
weblisten=0.0.0.0:${webport:-8888}
login=${login:-$USER}
password=${password:-password}

##############################
# REPLACEMENT
##############################
# String parameter values in the LHS are surrounded with "s and searched for as such
# Non-string parameter values in the LHS are not quoted - use , as delimiter
btsync --dump-sample-config \
	| sed 's#"device_name" *: *"[^"]*"#"device_name" : "'$devicename'"#g' \
	| sed 's#"listening_port" *: *[^,]*#"listening_port" : '$port'#g' \
	| sed 's#"storage_path" *: *"[^"]*"#"storage_path" : "'$storagepath'"#g' \
	| sed 's#"check_for_updates" *: *[^,]*#"check_for_updates" : '$checkupdates'#g' \
	| sed 's#"use_upnp" *: *[^,]*#"use_upnp" : '$upnp'#g' \
	| sed 's#"download_limit" *: *[^,]*#"download_limit" : '$downlimit'#g' \
	| sed 's#"upload_limit" *: *[^,]*#"upload_limit" : '$uplimit'#g' \
	| sed 's#"listen" *: *[^,]*#"listen" : '$weblisten'#g' \
	| sed 's#"login" *: *"[^"]*"#"login" : "'$login'"#g' \
	| sed 's#"password" *: *"[^"]*"#"password" : "'$password'"#g'
