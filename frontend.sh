source common.sh
component=frontend

echo Installing nginx
dnf install nginx -y                  >> $log_file
if[$? -eq 0]; then
echo Success
else
echo Failure
fi

echo enabling and restarting nginx
systemctl enable nginx                >> $log_file
systemctl start nginx                 >> $log_file
echo $?

echo Setting up configuration file
cp expense.conf /etc/nginx/default.d/expense.conf
echo $?

rm -rf /usr/share/nginx/html/* 
cd /usr/share/nginx/html

download_and_extract
echo $?

echo restarting nginx
systemctl restart nginx                    >> $log_file
echo $?