port=28765
# 解凍
tar -xvf growi_backup_*_*.tar.xz
# 添付ファイル
sudo cp -r ./growi_backup_*_*/uploads/* /var/lib/docker/volumes/growi_growi_data/_data/uploads
# MongoDB
sudo mongorestore --port ${port} --authenticationDatabase admin -u growiadmin -p GrowBrow -d growi ./growi_backup_*_*/mongodump_growi/growi/

