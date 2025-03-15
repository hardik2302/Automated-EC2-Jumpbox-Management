# Automated-EC2-Jumpbox-Management

## Overview  
This project automates the shutdown of AWS EC2 jumpboxes to optimize costs and enhance security. It uses **AWS Lambda** to identify running jumpbox instances and stop them at scheduled intervals. The infrastructure is fully managed using **Terraform**, ensuring seamless deployment and scalability.

## Features  
**Automated EC2 Shutdown** – Stops jumpbox instances automatically  
**AWS Lambda + Terraform** – Serverless and Infrastructure as Code (IaC)  
**EventBridge Scheduling** – Runs daily at **10 PM UTC** (configurable)  
**Cost Optimization** – Prevents unnecessary EC2 usage  
**Security Enhancement** – Ensures jumpboxes aren’t left running  

## Tech Stack  
- **AWS Lambda** (Python-based automation)  
- **Amazon EC2** (Jumpboxes)  
- **Amazon EventBridge** (Scheduled trigger)  
- **Terraform** (Infrastructure as Code)  

## How It Works  
1. **Lambda Function**: Scans AWS for EC2 instances tagged as jumpboxes.  
2. **Filtering**: Identifies instances based on the tag format:  

## Prerequisites

- **AWS CLI installed and configured**
- **Terraform installed**
- **IAM permissions to deploy AWS resources**

## Steps

**Clone this repository:**
- git clone https://github.com/hardik2302/Automated-EC2-Jumpbox-Management.git
- cd Automated-EC2-Jumpbox-Management

**Initialize and apply Terraform:**

- terraform init
- terraform apply

## Configuration

**Schedule Modification:** Update the EventBridge rule in Terraform to change execution time.

