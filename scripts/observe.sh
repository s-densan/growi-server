# set variables
scripts_dir=~/scripts

echo "**df**" | python3 ${scripts_dir}/postwebhook.py
df | python3 ${scripts_dir}/postwebhook.py

echo "**free**" | python3 ${scripts_dir}/postwebhook.py
free | python3 ${scripts_dir}/postwebhook.py

echo "**docker-compose ps**" | python3 ${scripts_dir}/postwebhook.py
env $(cat growi/.env | grep -v "^#" | xargs) docker-compose -f growi/docker-compose.yml ps | python3 ${scripts_dir}/postwebhook.py

