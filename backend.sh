source common.sh
component=backend

echo downloading nodejs repo
type npm                                                       &>>$log_file
if [ $? -ne 0 ]; then
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
fi                                                            &>> $log_file
status_check

rm -rf /app

mkdir /app
cd /app

download_and_extract
status_check

echo installing dependencies
npm install                                                   &>> $log_file
status_check


echo loading user and enabling and starting $component service
systemctl daemon-reload                                       &>> $log_file
systemctl enable backend                                      &>> $log_file
systemctl start backend                                       &>> $log_file
status_check

echo loading to the database
dnf install mysql -y                                         &>> $log_file
status_check
mysql -h mysql.sriharsha.shop -uroot -pSriharsha@1 < /app/schema/backend.sql   &>> $log_file
status_check





