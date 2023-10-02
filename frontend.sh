echo Installing nginx
dnf install nginx -y                  >> log_file

echo enabling and restarting nginx
systemctl enable nginx                >> log_file
systemctl start nginx                 >> log_file

rm -rf /usr/share/nginx/html/* 

echo download the code content from s3    
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip   >> log_file

echo Setting up configuration file
cp expense.conf /etc/nginx/default.d/expense.conf

echo unzipping the downloaded code     
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip                 >> log_file

echo restarting nginx
systemctl restart nginx                    >> log_file