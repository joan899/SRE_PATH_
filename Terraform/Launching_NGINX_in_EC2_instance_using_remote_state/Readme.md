# Terraform challenge: Create an EC2 instance in AWS by Terraform using remote state locking

Goal: Configure user data to automatically install and start NGINX when the EC2 instance launches. Verify that the NGINX server is accessible via a web browser using the instance's public IP. Also, store the state remotely using AWS S3 service and lock the file to avoid issues when many people are contributing to the infrastructure.

All the files used to complete this challenge can be found in this repository.

### Setting AWS profile 🛠️
Before you begin creating the plan, applying it and see the results, you must configure your AWS profile by the following commands:
Make sure you have [AWS CLI](https://docs.aws.amazon.com/es_es/cli/latest/userguide/getting-started-install.html) installed. 
If you are not sure if you have it already installed, you can run this command:
```aws --version```

Make use of this command to configure the profile:
```aws configure```

It will ask you to provide the AWS Access Key ID, AWS Secret Access Key, default region name and the default output format.
You can find this information from the AWS Console, navigating to the Identity and Access Management service, and selecting your user. 
Get a access key from the security credentials tab.

Lastly, check that your profile is ready to be used, you will see the account id and user related to the profile:
```aws sts get-caller-identity```

---

### Setting up all the necessary resources before planning and applying the infrastructure 🛠️
To complete this challenge, we need to create an AWS S3 bucket and an AWS dynamo table to store the state file remotely.
To achieve this run the following commands:
- Create a bucket
```aws s3api create-bucket \ --bucket terraformchallenges \ --region us-east-1```

- Make sure the bucket was created successfully:
```aws s3api list-buckets```

- Create the table:
```aws dynamodb create-table --table-name my-table-dynamodb --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5```

- Check if the table was created successfully:
```aws dynamodb list-tables --region us-east-1```

---

### Creating the terraform plan.
Open a terminal, and locate the folder where the tf files are placed. 
Once you're in the right directory, run this command to create the terraform plan:
```terraform plan```

Through this command, the plan that the configuration will create can be check and see if that's the expected result. You can see the number of components that will be created, changed or destroyed. 

---

### Apply the terraform configuration.
Now, that you have checked through the terraform plan that the configuration is going to create the infrastructure as expected, it is time to apply it. 
You can achieve this by this command: 
```terraform apply```

The command will prompt you with a confirmation request, asking if you want to proceed. Enter ```yes``` to continue.
Once the command has finished, you can double check the number of resources that were added, updated or deleted from the output.

---

### Test the configuration.
At the end of the output, you will find the public ip of the new instance (this behavior is define in the output.tf file), with this ip you can access the server via web browser.
For example: 
http://3.94.53.52

---

### Results.
Now, you should be able to see the 'Welcome to nginx' page. Also, you can navigate to the AWS Console and should be able to see the terraform state in the respective bucket. 

---

### Last step.
ultimately, if you want to destroy the previous infrastructure, run this command: 
```terraform destroy```
Through this command, all the resources created by the configuration will be deleted. You can double check this by navigating to the AWS Console.
