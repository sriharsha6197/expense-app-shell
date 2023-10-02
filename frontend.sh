source common.sh
component=frontend

echo Installing nginx
dnf install nginx -y                  >> $log_file

echo enabling and restarting nginx
systemctl enable nginx                >> $log_file
systemctl start nginx                 >> $log_file

rm -rf /usr/share/nginx/html/* 

echo Setting up configuration file
cp expense.conf /etc/nginx/default.d/expense.conf

cd /usr/share/nginx/html

download and extract

echo restarting nginx
systemctl restart nginx                    >> $log_file