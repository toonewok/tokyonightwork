keepfile=`ls -t ~/Downloads/frmservlet* | head -n1`
echo $keepfile

mv "$keepfile" ~/Downloads/jesta

rm -rf ~/Downloads/frmservlet*

javaws ~/Downloads/jesta

