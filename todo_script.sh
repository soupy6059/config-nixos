today_name=~/Documents/todo/todo_$(date +"%Y%m%d").md
yesterday_name=~/Documents/todo/todo_$(date -d "yesterday" +"%Y%m%d").md

adQ=false
coQ=false
pxQ=false
viQ=false
vidiffQ=false
if (( $# > 0 )); then
    for arg in $@; do
        if [[ $arg == print ]]; then
            cat ~/Documents/todo/todo_$(date +"%Y%m%d").md
        fi
        if [[ $arg == pull ]]; then
            (cd ~/Documents/todo; git pull)
        fi
        if [[ $arg == add ]]; then
            adQ=true
        fi
        if [[ $arg == commit ]]; then
            coQ=true
        fi
        if [[ $arg == push ]]; then
            pxQ=true
        fi
        if [[ $arg == vim ]]; then
            viQ=true
        fi
        if [[ $arg == vimdiff ]]; then
            vidiffQ=true
        fi
    done
    if [[ $viQ == true ]]; then
        vim -p $today_name $yesterday_name
        cp $today_name ~/Documents/todo/README.md
    fi
    if [[ $vidiffQ == true ]]; then
        vimdiff $today_name $yesterday_name
    fi
    if [[ $adQ == true ]]; then
        (cd ~/Documents/todo; git add ~/Documents/todo/.)
    fi
    if [[ $coQ == true ]]; then
        (cd ~/Documents/todo; git commit -m "$(date +"%Y%m%d")")
    fi
    if [[ $pxQ == true ]]; then
        (cd ~/Documents/todo; git push)
    fi
    exit 0
fi

# DEFAULT
(cd ~/Documents/todo; git pull)
vim -p $today_name $yesterday_name
cp $today_name ~/Documents/todo/README.md
(cd ~/Documents/todo; git add ~/Documents/todo/.)
(cd ~/Documents/todo; git commit -m "$(date +"%Y%m%d")")
(cd ~/Documents/todo; git push)
