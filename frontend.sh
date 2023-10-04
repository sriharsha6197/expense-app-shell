source common.sh
component=frontend

echo Installing nginx
dnf install nginx -y                  >> $log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
fi

echo enabling and restarting nginx
systemctl enable nginx                >> $log_file
systemctl start nginx                 >> $log_file
if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
else
    echo -e "\e[31mFAILURE\e[0m"
fi

echo Setting up configuration file
cp expense.conf /etc/nginx/default.d/expense.conf
if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
else
   echo -e "\e[31mFAILURE\e[0m"
fi

rm -rf /usr/share/nginx/html/* 
cd /usr/share/nginx/html

download_and_extract
if [ $? -eq 0 ]; then
   echo -e "\e[32mSUCCESS\e[0m"
else
   echo -e "\e[31mFAILURE\e[0m"
fi

echo restarting nginx
systemctl restart nginx                    >> $log_file
if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
fi