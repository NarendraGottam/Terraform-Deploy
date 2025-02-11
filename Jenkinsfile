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
                withCredentials([usernamePassword(credentialsId: 'GIT_CREDENTIALS', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
                    // Using GitHub credentials securely from Jenkins Credentials Manager
                    sh 'git clone https://${GIT_USER}:${GIT_PASS}@github.com/NarendraGottam/Terraform-Deploy.git'
                }
            }
        }

        stage('Set AWS Credentials') {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_CREDENTIALS']]) {
                    // Using AWS credentials securely from Jenkins Credentials Manager
                    sh 'aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID'
                    sh 'aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY'
                    sh 'aws configure set region $AWS_REGION'
                }
            }
        }

        stage('Terraform Init') {
            steps {
                // Initialize Terraform with backend config pointing to S3 and DynamoDB
                sh 'terraform init -backend-config="bucket=$S3_BUCKET" -backend-config="dynamodb_table=$DYNAMODB_TABLE"'
            }
        }

        stage('Run Security Scan with Checkov') {
            steps {
                // Run security scan with Checkov for Terraform code
                sh 'checkov -d . --quiet --output cli'
            }
        }

        stage('Terraform Plan') {
            steps {
                // Generate Terraform execution plan
                sh 'terraform plan -out=tfplan'
            }
        }

        stage('Terraform Apply') {
            steps {
                // Apply Terraform plan
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }

    post {
        failure {
            echo "Deployment failed. Rolling back..."
            // Pull state and rollback if deployment fails
            sh 'terraform state pull > last_successful_state.tfstate'
            sh 'terraform apply -auto-approve last_successful_state.tfstate'
        }
    }
}

