#!bin/bash
# Describes list of VPC
aws ec2 --output text --query 'Vpcs[*].{VpcId:VpcId,Name:Tags[?Key==`Name`].Value|[0],CidrBlock:CidrBlock}' describe-vpcs

# Describes specific subnets 
aws ec2 --output text --query 'Subnets[*].{SubnetId:SubnetId,Name:Tags[?Key==`Name`].Value|[0]}' describe-subnets --filter 'Name=vpc-id,Values='vpc-0f39a5151b856b8bd

# Describes gateway
aws ec2 describe-internet-gateways --filters 'Name=attachment.vpc-id,Values='vpc-0f39a5151b856b8bd --query 'InternetGateways[*].InternetGatewayId[]' --output text

# Describes route tables
aws ec2 describe-route-tables --filters 'Name=vpc-id,Values='vpc-0f39a5151b856b8bd --query 'RouteTables[*].{RouteTableId:RouteTableId,Name:Tags[?Key==`Name`].Value|[0]}' --output text
