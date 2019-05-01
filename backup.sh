# set variables
backup_root_dir=~/backup
backup_dir_name=growi_backup_$(date '+%Y%m%d_%H%M%S')
backup_dir_path=${backup_root_dir}/${backup_dir_name}
archive_file_name=${backup_dir_name}.tar.xz
archive_file_path=${backup_root_dir}/${archive_file_name}

mkdir ${backup_dir_path}
sudo cp -r /var/lib/docker/volumes/growi_growi_data/_data/uploads "${backup_dir_path}"
mongodump --port 27017 -d growi -u growiuser -p grogro --out "${backup_dir_path}/mongodump_growi"
tar -Jcvf "${archive_file_path}" -C "${backup_root_dir}" "${backup_dir_name}"

~/go/bin/skicka mkdir /growi
~/go/bin/skicka mkdir /growi/backup
~/go/bin/skicka upload "${archive_file_path}" /growi/backup/

# Slack通知
python3 ~/source/growi-server/postwebhook.py "バックアップを取得しました。${archive_file_name}"