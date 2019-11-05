#!/bin/bash

domainexpiredate() {
        openssl x509 -text -in <(echo -n | openssl s_client -connect $1:$2 2>/dev/null | sed -n '/-*BEGIN/,/-*END/p') 2>/dev/null | sed -n 's/ *Not After : *//p'
}

daysleft() {
        echo "((($(date -d "$(domainexpiredate $1 $2)" +%s)-$(date +%s))/24)/60)/60" | bc
}

if [ -z "$1" ]; then
	echo "usage: certexpirecheck.sh <domain> [<port>]"
else
	if [ -z "$2" ]; then
		daysleft $1 443
	else
		daysleft $1 $2
	fi
fi
