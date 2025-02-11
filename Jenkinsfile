pipeline {
    agent any
    environment {
        AWS_REGION = 'eu-west-2'
        S3_BUCKET = 'terraform-state-bucket-gopi'
        DYNAMODB_TABLE = 'terraform-lock-table'
    }
    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/NarendraGottam/Terraform-Deploy.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -backend-config="bucket=$S3_BUCKET" -backend-config="dynamodb_table=$DYNAMODB_TABLE"'
            }
        }

        stage('Run Security Scan with Checkov') {
            steps {
                sh 'checkov -d . --quiet --output cli'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        failure {
            echo "Deployment failed. Rolling back..."
            sh 'terraform state pull > last_successful_state.tfstate'
            sh 'terraform apply -auto-approve last_successful_state.tfstate'
        }
    }
}

