today_name=~/Documents/todo/todo_$(date +"%Y%m%d").md
yesterday_name=~/Documents/todo/todo_$(date -d "yesterday" +"%Y%m%d").md

(cd ~/Documents/todo; git pull)
<EDITOR_GOES_HERE> -p $today_name $yesterday_name
cp $today_name ~/Documents/todo/README.md
(cd ~/Documents/todo; git add ~/Documents/todo/.)
(cd ~/Documents/todo; git commit -m "$(date +"%Y%m%d")")
(cd ~/Documents/todo; git push)
