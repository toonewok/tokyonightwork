database=$1
file=$2
curpath=$(pwd)
fpath=$curpath/$file

fox_path()
{
	echo is the for ftp path or xfer?...please enter f or x accordingly
	read fox

	if [ "$fox" == "f" ];
	then 
		serpath=/ftp/pub/$database/

	elif [ "$fox" == "x" ];
	then 
		serpath=/xfer/$server/$database/

	else
		echo error...please enter x or f
		fox_path
	fi


}



if [ "$database" == "ramsdev" ] || [ "$database" == "ramstst" ] || [ "$database" == "ramsqa" ];
then

	server=dv7

elif [ "$database" == "ramsprd" ]; 
then	

	server=s80

else

	echo $database

fi

ext="${file##*.}"

[ "$file" = "$ext" ] && ext=""

if [ "$ext" == "sql" ];
then
	serpath=/usr2/develop/$database/src/gco/

elif [ "$ext" == "" ] || [ "$ext" == "sh" ];
then 
	serpath=/usr2/develop/src/scripts/

elif [ "$ext" == "csv" ];
then
	fox_path
fi



sftp <user>@$server<<EOF
put $fpath $serpath
EOF

