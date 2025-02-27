import boto3  # Import AWS SDK for Python

# Set AWS region where the EC2 instances are located
REGION = "ap-south-1" 

def lambda_handler(event, context):
    """
    AWS Lambda function to stop all running EC2 instances in the specified region.
    """
    # Initialize EC2 client
    ec2 = boto3.client("ec2", region_name=REGION)
    
    # Describe all running instances
    response = ec2.describe_instances(Filters=[
        {"Name": "instance-state-name", "Values": ["running"]}
    ])
    
    # List to store instances that will be stopped
    stopped_instances = []
    
    # Loop through response to extract running instance details
    for reservation in response["Reservations"]:
        for instance in reservation["Instances"]:
            instance_id = instance["InstanceId"]  # Get instance ID
            
            # Get instance name tag, default to 'Unknown' if not found
            name = next((tag["Value"] for tag in instance.get("Tags", []) if tag["Key"] == "Name"), "Unknown")
            
            # Store instance details
            stopped_instances.append({"InstanceId": instance_id, "Name": name})
    
    # Stop instances if any are found
    if stopped_instances:
        instance_ids = [inst["InstanceId"] for inst in stopped_instances]  # Extract instance IDs
        ec2.stop_instances(InstanceIds=instance_ids)  # Stop instances
        
        # Print stopped instances for CloudWatch logging
        print(f"Stopping instances: {stopped_instances}")
        for inst in stopped_instances:
            print(f"Stopped Instance - ID: {inst['InstanceId']}, Name: {inst['Name']}")
        
        return {"StoppedInstances": stopped_instances}  # Return JSON response
    
    # No running instances found
    print("No running instances found.")
    return {"Message": "No running instances found."}
