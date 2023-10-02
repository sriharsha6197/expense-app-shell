source common.sh
component=backend

echo downloading nodejs repo
curl -sL https://rpm.nodesource.com/setup_lts.x | bash       >> $log_file
echo $?

echo installing nodejs
dnf install nodejs -y                                        >> $log_file
echo $?
cp backend.service /etc/systemd/system/backend.service       


echo adding user
useradd expense                                              >> $log_file
echo $?
rm -rf /app

mkdir /app
cd /app

download_and_extract
echo $?

echo installing dependencies
npm install                                                   >> $log_file
echo $?


echo loading user and enabling and starting $component service
systemctl daemon-reload                                       >> $log_file
systemctl enable backend                                      >> $log_file
systemctl start backend                                       >> $log_file
echo $?

echo loading to the database
dnf install mysql -y                                         >> $log_file
echo $?
mysql -h mysql.sriharsha.shop -uroot -pSriharsha@1 < /app/schema/backend.sql   >> $log_file
echo $?





