echo downloading nodejs repo
curl -sL https://rpm.nodesource.com/setup_lts.x | bash       >> /tmp/expense-backend.log

echo installing nodejs
dnf install nodejs -y                                        >> /tmp/expense-backend.log
cp backend.service /etc/systemd/system/backend.service       


echo adding user
useradd expense
rm-rf /app
mkdir /app

echo downloading the backend code from s3
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip      >> /tmp/expense-backend.log

echo unzipping backend downloaded file
cd /app
unzip /tmp/backend.zip                                        >> /tmp/expense-backend.log

echo installing dependencies
npm install                                                   >> /tmp/expense-backend.log


echo loading user and enabling and starting backend service
systemctl daemon-reload
systemctl enable backend 
systemctl start backend                                       >> /tmp/expense-backend.log

echo loading to the database
dnf install mysql -y                                         >> /tmp/expense-backend.log
mysql -h mysql.sriharsha.shop -uroot -pSriharsha@1 < /app/schema/backend.sql   >> /tmp/expense-backend.log





