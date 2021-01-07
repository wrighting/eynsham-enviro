for i in logs/*.gz
do
    HEADER_FILE=header.tmpl
    UNZIPPED=/tmp/$$
    zcat $i | grep 'freq' > /dev/null
    if [ $? -eq 0 ]
    then
        echo "Sound in $i"
        HEADER_FILE=header.tmpl.sound
    fi
    zcat $i | grep -v 'collection_time' > ${UNZIPPED}
    cat ${HEADER_FILE} ${UNZIPPED} | gzip > newfile.gz
    mv newfile.gz data/$(basename $i)
    rm ${UNZIPPED}
done
