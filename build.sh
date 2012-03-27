build_script/generate_database_config.rb config/database.rb
RACK_ENV=test bundle exec padrino rake spec
OUT=$?
if [ $OUT -eq 0 ];then
	cd /www/eid/services
	git pull
	bundle
	build_script/generate_database_config.rb config/database.rb
	service httpd restart 
else
	exit 1
fi
