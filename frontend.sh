echo Installing nginx
dnf install nginx -y 

echo enabling and restarting nginx
systemctl enable nginx 
systemctl start nginx 

rm -rf /usr/share/nginx/html/* 

echo download the code content from s3
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip

echo Setting up configuration file
cp expense.conf /etc/nginx/default.d/expense.conf

echo unzipping the downloaded code
cd /usr/share/nginx/html 
unzip /tmp/frontend.zip

echo restarting nginx
systemctl restart nginx 