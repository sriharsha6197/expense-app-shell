source common.sh

echo disabling module of mysql which is already there
dnf module disable mysql -y                  >> $log_file
status_check

echo setting up mysql repo
cp mysql.repo /etc/yum.repos.d/mysql.repo    
status_check

echo installing mysql
dnf install mysql-community-server -y         >> $log_file
status_check


echo enabling and starting mysql
systemctl enable mysqld                     >> $log_file
systemctl start mysqld                      >> $log_file
status_check

echo setting up password
mysql_password=$1
mysql_secure_installation --set-root-pass $mysql_password  >> $log_file
status_check

