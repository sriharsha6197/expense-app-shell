set -x
source common.sh
component=backend

type npm                                                       &>>$log_file
if [ $? -ne 0 ]; then
echo downloading nodejs repo

  curl -sL https://rpm.nodesource.com/setup_lts.x | bash       &>>$log_file
  status_check

  echo installing nodejs
  dnf install nodejs -y                                        &>>$log_file
  status_check
fi
cp backend.service /etc/systemd/system/backend.service       


echo adding user
id expense                                                    &>>$log_file
if [ $? -ne 0 ]; then
useradd expense
fi                                                            &>>$log_file
status_check

rm -rf /app

mkdir /app
cd /app

download_and_extract


echo installing dependencies
npm install                                                   &>>$log_file



echo loading user and enabling and starting $component service
systemctl daemon-reload                                       &>> $log_file
systemctl enable backend                                      &>> $log_file
systemctl start backend                                       &>> $log_file
status_check

echo Install mysql client
dnf install mysql -y                                         &>> $log_file
status_check

echo load schema
mysql_root_password=$1
mysql -h mysql.sriharsha.shop -uroot -p$mysql_root_password < /app/schema/backend.sql     &>>$log_file
status_check





