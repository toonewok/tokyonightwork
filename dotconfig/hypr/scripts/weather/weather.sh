#!/bin/bash
#script was added to crontab
#	note: crontab is not installed by default, i used cronie, cronie has to be enabled
#			systemctl enable cronie.service
#	crontab entry: */5 * * * * <path-to-script>/weather.sh $city

htime=$(date +%H)
city=$1
site="https://wttr.in/$city"
weather_out=$HOME/.config/hypr/scripts/weather/wthout
temps=$HOME/.config/hypr/scripts/weather/temps
fout=$HOME/.config/hypr/scripts/weather/output

#removes previous weather info
rm $weather_out
rm $temps
rm $fout

# gets weather info
curl --output $weather_out $site

# searches weather info file for all temperatures, dumps them into a file
grep °F $weather_out > $temps

if [ $htime -ge 19 ]; then

	time='n'

else
	time='d'

fi

wstatus=$(sed '3!d' $weather_out | sed -e 's/\x1b\[[0-9;]*m//g' | cut -d\/ -f2 | sed 's/^ *//g')

var=$(head -1 $temps)
varcount="${var//[^\(]}"

echo "varcount is ${#varcount}"

#extracts the temperature from the temps file
s_temps=$(head -1 $temps | sed -e 's/\x1b\[[0-9;]*m//g' | tr -s " " | xargs | rev | cut -d " " -f2 | rev | sed 's/^.\{1\}//')
#	        1	                  2                   3         4       5           6         7            8
# ^EXPLANATION^ the explanation assumes you can view the command in a single line with no wrap k thx
# also '|'(or pipes) are used to carry the output of one command directly into another
# 	like 1 + 2 + 3 = 6
# 1. head -1 $temps, gets the first line of the temps file
# 2. sed -e 'blah', this tells sed to use regexp to search for all ansi escape codes from wttr.in
# 	and completely removes them, im not interested in having a colored output(at least not here)
# 3. tr -s " ", 'trims' all blank spaces
# <begin-not really sure lmao>
# 4. xargs, my understand of this command is that it is splitting the string into multiple sublist for the
# 	rest of the commands
# 5. rev, reverses the string
# 6. cut -d " " -f2, extracts the second field, delimited by space (in reverse?)
# 7. rev, reorients from 5/rev
# <end-not really sure lmao>
# 8. sed 'blah', this time sed is being used to remove the first character(the positive or negative)
# 	^ , start of string - {1\}, position 1

if [ ${#varcount} = 0 ]; then
	act_temp=$(head -1 $temps | sed -e 's/\x1b\[[0-9;]*m//g' | tr -s " " | cut -d. -f3 | sed  's/^ *//g' | cut -d ' ' -f1)
	tempform="$act_temp"

else
	act_temp=$(echo $s_temps | cut -d\( -f1 )
	feel_temp=$(echo $s_temps | cut -d\( -f2| cut -d\) -f1)
	tempform="$act_temp($feel_temp)"
fi

echo "temp output is $tempform"


if [ "$wstatus" = "Partly cloudy" ]; then
	if [ $time = "d" ]; then
		wstatus=' Partly cloudy'
	else
		wstatus=' Partly cloudy'
	fi
elif [ "$wstatus" = "Sunny" ]; then
	if [ $time = "d" ]; then
		wstatus=' Clear'
	else
		wstatus=' Clear'
	fi

elif [ "$wstatus" = "Cloudy" ]; then
	wstatus='󰖐 Cloudy'

	

fi

echo $wstatus > $fout
echo $tempform >> $fout

