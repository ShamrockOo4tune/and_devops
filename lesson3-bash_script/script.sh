#!/bin/bash

man_msg="at least 2 arguments required to run script:\n\t1: desired PID or process name \t\texample: 'chrome'\n\t2: how many lines to output \t\texample: '5'\n\t3: (optional) connection status \texample: '--show-status'"

if (( $# < 2)); then
    echo -e $man_msg
    exit 1
else
    internet_conn=$(netstat -tunap);
    echo -e "\n\n--->internet connections obtained from netstat:\n$internet_conn"
    internet_conn_filtered=$(echo "$internet_conn" | grep $1 | sed 's/[0-9]*\/.*//;s/:\S*//g')
    lines=$(echo "$internet_conn_filtered" | wc -l)
    if [ $lines -le 1 ]; then
        echo "No such process \$1=($1) has been found"
        exit 1
    fi
    echo -e "\n\n--->internet connections filtered by argument \$1=$1:\n$internet_conn_filtered"
    connections_unique_sorted=$(echo "$internet_conn_filtered" | awk '{print $5" "$6}' | uniq -c | sort -n | awk '{$1=""; print $0}' | sed '/^$/d')
    echo -e "\n\n--->connections_unique_sorted:\n$connections_unique_sorted"
    re='^[0-9]+$'
    if ! [[ $2 =~ $re ]]; then
        echo "\$2 should be integer > 0. However \"$2\" has been recieved"
        exit 1
    fi
    last_n_IP=$(echo "$connections_unique_sorted" | tail -n$2 | sed 's/[0-9]$/& NOT_AVAILABLE/')
    echo -e "\n\n--->Last 'n' IPs. n has been determined by argument \$2: '$2'\n$last_n_IP"
    echo -e "\n\n--->Organizations are:"
    if [ "$3" = "--show-status" ]; then
        printf '%17s' "IP_adress" "Conn_status"; printf '%60s' "Organization name (net_name)"; printf '%6s\n' "QTY"
        echo -e "----------------------------------------------------------------------------------------------------"
        while read IP_state
        do
            IP=$(echo $IP_state | awk '{print $1}')
            org_name=$(whois $IP | awk -F':' '/^Organization/ {print $2}' | sed 's/^ *//g' | tr -d ' ')
            if [ "$org_name" == '' ]; then
                org_name=$(whois $IP | awk -F':' '/^netname/ {print $2}' | sed 's/^ *//g' | tr -d ' ')
            fi
            if [ "$org_name" == '' ]; then
                org_name='noname'
            fi
            cons_to_this_org=$(echo "$internet_conn_filtered" | grep $IP | wc -l)
            printf '%17s' $IP_state; printf '%60s' $org_name; printf '%6s\n' $cons_to_this_org
        done <<< $last_n_IP
    else
        printf '%17s' "IP_adress"; printf '%60s' "Organization name (net_name)"; printf '%6s\n' "QTY"
        echo -e "-----------------------------------------------------------------------------------"
        while read IP_state
        do
            IP=$(echo $IP_state | awk '{print $1}')
            org_name=$(whois $IP | awk -F':' '/^Organization/ {print $2}' | sed 's/^ *//g' | tr -d ' ')
            if [ "$org_name" == '' ]; then
                org_name=$(whois $IP | awk -F':' '/^netname/ {print $2}' | sed 's/^ *//g' | tr -d ' ')
            fi
            if [ "$org_name" == '' ]; then
                org_name='noname'
            fi
            cons_to_this_org=$(echo "$internet_conn_filtered" | grep $IP | wc -l)
            printf '%17s' $IP; printf '%60s' $org_name; printf '%6s\n' $cons_to_this_org
        done <<< $last_n_IP
    fi
fi
