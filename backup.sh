# set variables
backup_root_dir=~/backup
backup_dir_name=growi_backup_$(date '+%Y%m%d_%H%M%S')
backup_dir_path=${backup_root_dir}/${backup_dir_name}
archive_file_name=${backup_dir_name}.tar.xz
archive_file_path=${backup_root_dir}/${archive_file_name}
upload_dir1=/growi
upload_dir2=${upload_dir1}/backup
upload_dir3=${upload_dir2}/$(date '+%Y')
upload_dir4=${upload_dir3}/$(date '+%Y%m')

mkdir ${backup_dir_path}
sudo cp -r /var/lib/docker/volumes/growi_growi_data/_data/uploads "${backup_dir_path}"
mongodump --port 27017 -d growi -u growiuser -p grogro --out "${backup_dir_path}/mongodump_growi"
tar -Jcvf "${archive_file_path}" -C "${backup_root_dir}" "${backup_dir_name}"

~/go/bin/skicka mkdir ${upload_dir1}
~/go/bin/skicka mkdir ${upload_dir2}
~/go/bin/skicka mkdir ${upload_dir3}
~/go/bin/skicka mkdir ${upload_dir4}
~/go/bin/skicka upload "${archive_file_path}" ${upload_dir4}

# Slack通知
completion_message="バックアップを取得しました。${archive_file_name}"
python3 ~/source/growi-server/postwebhook.py ${completion_message}
logger -- ${completion_message}
