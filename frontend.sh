source common.sh
component=frontend

echo Installing nginx
dnf install nginx -y                  >> $log_file
status_check

echo enabling and restarting nginx
systemctl enable nginx                >> $log_file
systemctl start nginx                 >> $log_file
status_check

echo Setting up configuration file
cp expense.conf /etc/nginx/default.d/expense.conf
status_check

rm -rf /usr/share/nginx/html/* 
cd /usr/share/nginx/html

download_and_extract
status_check

echo restarting nginx
systemctl restart nginx                    >> $log_file
status_check