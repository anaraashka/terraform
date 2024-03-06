You are hired as an AWS Cloud Engineer at Walmart. One of your best skills is scripting in Terraform. 
Your manager assigned a task to move the existing infrastructure to Terraform.
Before starting the migration to terraform please follow these instructions with the naming convention of resources!
a) Go to the AWS console and create resources manually(NOTE: Not in terraform)
b) Create VPC, the name is vpc_walmart
c) Create Subnets, names are public_subnet_walmart, private_subnet_walmart, attach subnets to vpc_walmart
d) Create an Internet Gateway, the name is internet_gateway_walmart, attach it vpc_walmart
c) Create Route Tables, route_tb_public_walmart, route_tb_private_walmart, associate particular subnets
1) Now, you can start migrating resources to Terraform.
   Create terraform configuration files following the naming convention
   Import all resources one by one, which you created before on AWS Console
   Once you get import success output in the terminal take a screenshot and save it
2) Now, your all resources are managed by Terraform. To make differentiated student results, please make some changes to the naming convention.
   You have to rename on both terraform configuration files and state file without destroy any resources
   vpc_walmart -> vpc_yourname   ( Example: vpc_john, vpc_tom, ...etc applied all resources below)
   public_subnet_walmart -> public_subnet_yourname
   private_subnet_walmart -> private_subnet_yourname
   internet_gateway_walmart -> internet_gateway_yourname
   route_tb_public_walmart -> route_tb_public_yourname
   route_tb_private_walmart -> route_tb_private_yourname
   Once you get rename success output in the terminal take a screenshot and save it
3) When you completed all tasks please save all screenshots on your local computer, I will review them, next class!

Good luck;)
