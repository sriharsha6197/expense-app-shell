echo downloading nodejs repo
curl -sL https://rpm.nodesource.com/setup_lts.x | bash       >> log_file

echo installing nodejs
dnf install nodejs -y                                        >> log_file
cp backend.service /etc/systemd/system/backend.service       


echo adding user
useradd expense
rm-rf /app
mkdir /app

echo downloading the backend code from s3
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/backend.zip      >> log_file

echo unzipping backend downloaded file
cd /app
unzip /tmp/backend.zip                                        >> log_file

echo installing dependencies
npm install                                                   >> log_file


echo loading user and enabling and starting backend service
systemctl daemon-reload                                       >> log_file
systemctl enable backend                                      >> log_file
systemctl start backend                                       >> log_file

echo loading to the database
dnf install mysql -y                                         >> log_file
mysql -h mysql.sriharsha.shop -uroot -pSriharsha@1 < /app/schema/backend.sql   >> log_file





