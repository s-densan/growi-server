# set variables
scripts_dir=~/scripts
backup_root_dir=~/backup
backup_dir_name=growi_backup_$(uname -n)_$(date '+%Y%m%d_%H%M%S')
backup_dir_path=${backup_root_dir}/${backup_dir_name}
archive_file_name=${backup_dir_name}.tar.xz
archive_file_path=${backup_root_dir}/${archive_file_name}
upload_dir1=/growi
upload_dir2=${upload_dir1}/backup
upload_dir3=${upload_dir2}/$(date '+%Y')
upload_dir4=${upload_dir3}/$(date '+%Y%m')
port=28765

# delete old backup
rm ${backup_root_dir}/*.tar.xz
rm ${backup_root_dir}/*/ -R

# create new backup(growi mongodb and uploads)
mkdir ${backup_dir_path}
mongodump --port ${port} -d growi -u growiuser -p grogro --out "${backup_dir_path}/mongodump_growi"
sudo cp -r /var/lib/docker/volumes/growi_growi_data/_data/uploads "${backup_dir_path}"

# create new backup(scripts)
cp -r "${scripts_dir}" "${backup_dir_path}"

# create new backup(growi's docker compose config)
mkdir "${backup_dir_path}/growi_config"
cp ~/growi/docker-compose.yml "${backup_dir_path}/growi_config"

# compress backups
tar -Jcvf "${archive_file_path}" -C "${backup_root_dir}" "${backup_dir_name}"

# upload backup to google drive
~/go/bin/skicka mkdir ${upload_dir1}
~/go/bin/skicka mkdir ${upload_dir2}
~/go/bin/skicka mkdir ${upload_dir3}
~/go/bin/skicka mkdir ${upload_dir4}
~/go/bin/skicka upload "${archive_file_path}" ${upload_dir4}

# Slack通知
completion_message="バックアップを取得しました。${archive_file_name}"
echo ${completion_message} | python3 ${scripts_dir}/postwebhook.py
logger -- ${completion_message}
