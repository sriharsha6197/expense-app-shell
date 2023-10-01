echo disabling module of mysql which is already there
dnf module disable mysql -y                  >> /tmp/expense.log

echo setting up mysql repo
cp mysql.repo /etc/yum.repos.d/mysql.repo    


echo installing mysql
dnf install mysql-community-server -y         >> /tmp/expense.log


echo enabling and starting mysql
systemctl enable mysqld                     >> /tmp/expense.log
systemctl start mysqld                      >> /tmp/expense.log

echo setting up password
mysql_secure_installation --set-root-pass Sriharsha@1  >> /tmp/expense.log

