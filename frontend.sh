source common.sh
component=frontend

echo Installing nginx
dnf install nginx -y                  >> $log_file

echo enabling and restarting nginx
systemctl enable nginx                >> $log_file
systemctl start nginx                 >> $log_file

echo Setting up configuration file
cp expense.conf /etc/nginx/default.d/expense.conf

rm -rf /usr/share/nginx/html/* 
cd /usr/share/nginx/html

download_and_extract

echo restarting nginx
systemctl restart nginx                    >> $log_file