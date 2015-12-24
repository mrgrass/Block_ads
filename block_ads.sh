GENFILE="block_ads.txt"

MVPSOURCEFILE="http://www.mvps.org/winhelp2002/hosts.txt"
PGLSOURCEFILE="http://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts;showintro=0"
HSFSOURCEFILE="http://support.it-mate.co.uk/downloads/hosts.txt"
HFPSOURCEFILE="http://hostsfile.mine.nu/Hosts"

wget $MVPSOURCEFILE -O - >> $GENFILE
wget $PGLSOURCEFILE -O - >> $GENFILE
wget $HSFSOURCEFILE -O - >> $GENFILE
wget $HFPSOURCEFILE -O - >> $GENFILE

sed -i -e '/^[0-9A-Za-z]/!d' $GENFILE
sed -i -e '/%/d' $GENFILE
sed -i -e 's/[[:cntrl:][:blank:]]//g' $GENFILE
sed -i -e 's/^[ \t]*//;s/[ \t]*$//' $GENFILE

## dnsmasq, sanitize, optimised
sed -i -e 's/[[:space:]]*\[.*$//'  $GENFILE
sed -i -e 's/[[:space:]]*\].*$//'  $GENFILE
sed -i -e '/[[:space:]]*#.*$/ s/[[:space:]]*#.*$//'  $GENFILE           
sed -i -e '/^$/d' $GENFILE
sed -i -e '/127.0.0.1/ s/127.0.0.1//'  $GENFILE         
sed -i -e '/^www[0-9]./ s/^www[0-9].//'  $GENFILE               
sed -i -e '/^www./ s/^www.//' $GENFILE


## remove duplicates (resource friendly)        
cat $GENFILE | sort -u > $GENFILE.new
mv $GENFILE.new $GENFILE


