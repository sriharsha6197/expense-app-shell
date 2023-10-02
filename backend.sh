source common.sh
component=backend

echo downloading nodejs repo
curl -sL https://rpm.nodesource.com/setup_lts.x | bash       >> $log_file

echo installing nodejs
dnf install nodejs -y                                        >> $log_file
cp backend.service /etc/systemd/system/backend.service       


echo adding user
useradd expense                                              >> $log_file
rm-rf /app
mkdir /app

cd /app

download and extract

echo installing dependencies
npm install                                                   >> $log_file


echo loading user and enabling and starting $component service
systemctl daemon-reload                                       >> $log_file
systemctl enable backend                                      >> $log_file
systemctl start backend                                       >> $log_file

echo loading to the database
dnf install mysql -y                                         >> $log_file
mysql -h mysql.sriharsha.shop -uroot -pSriharsha@1 < /app/schema/backend.sql   >> $log_file





