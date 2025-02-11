# Terraform-Deploy
# install jenkins

sudo apt update
sudo apt install openjdk-17-jre

java -version

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins

#install Terraform on Linux
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

terraform -version 

#install aws cli
sudo apt update && sudo apt upgrade -y
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

aws --version
aws configure

#Install Checkov in a Virtual Environment 
This keeps your system clean and avoids conflicts.

Step 1: Install Virtual Environment Package

sudo apt install python3-venv -y

Step 2: Create a Virtual Environment

python3 -m venv checkov-env

Step 3: Activate the Virtual Environment

source checkov-env/bin/activate

Your terminal will now show something like:


(checkov-env) ubuntu@ip-xxx-xxx-xxx:~$
Step 4: Install Checkov Inside the Virtual Environment

pip install checkov

Step 5: Run Checkov

checkov --version

Step 6: Deactivate the Virtual Environment (When Done)

deactivate






