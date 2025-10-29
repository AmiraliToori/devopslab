#!/usr/bin/env bash

mem_stat="$(free -bt | grep "^Total:")"

total_mem_byte="$(echo "$mem_stat" | awk '{print $2}')"
used_mem_byte="$(echo "$mem_stat" | awk '{print $3}')"
free_mem_byte="$(echo "$mem_stat" | awk '{print $4}')"

used_mem_percent="$(echo "($used_mem_byte/$total_mem_byte)*100" | bc -l | xargs printf "%.2f%%")"
free_mem_percent="$(echo "($free_mem_byte/$total_mem_byte)*100" | bc -l | xargs printf "%.2f%%")"

used_mem_readable="$(echo "$used_mem_byte" | numfmt --to=iec)"

free_mem_readable="$(echo "$free_mem_byte" | numfmt --to=iec)"

printf "################################################\n"
printf "################# Memory Usage #################\n"
printf "################################################\n\n"

printf "Used Memory: %s (%s) \nFree Memory: %s (%s)\n\n" "$used_mem_readable" "$used_mem_percent" "$free_mem_readable" "$free_mem_percent"

printf "################################################\n"
printf "################# CPU Usage ####################\n"
printf "################################################\n\n"

mpstat

printf "\n###############################################\n"
printf "################# Disk Usage ##################\n"
printf "###############################################\n"
df -hT | grep -E '(^/dev/)|(^Filesystem)'

printf "\n###############################################################\n"
printf "################# Top 5 Process by CPU Usage ##################\n"
printf "###############################################################\n"

ps -e T -o user,pid,%cpu,cmd --sort=-%cpu | head -n 6

printf "\n##################################################################\n"
printf "################# Top 5 Process by Memory Usage ##################\n"
printf "##################################################################\n"

ps -e T -o user,pid,%mem,cmd --sort=-%mem | head -n 6
