log_file=/tmp/expense.log

download_and_extract() {
echo download the $component code from s3    
curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip   >> $log_file
status_check

echo unzipping the downloaded code     
unzip /tmp/$component.zip                 >> $log_file
status_check
}

status_check() {
    if [ $? -eq 0 ]; then
  echo -e "\e[32mSUCCESS\e[0m"
else
  echo -e "\e[31mFAILURE\e[0m"
fi
}