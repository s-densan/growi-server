cd ~/source/growi-server
sudo git fetch
cp pull_from_github.sh ~/
cp backup.sh ~/
sudo cp crontab /var/spool/cron/crontabs/decide_in_the_eyes
# cron 再起動
sudo /etc/init.d/cron restart

