log_file = /tmp/expense.log

download and extract(){

echo download the code content from s3    
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip   >> $log_file

echo unzipping the downloaded code     
unzip /tmp/frontend.zip                 >> $log_file

}