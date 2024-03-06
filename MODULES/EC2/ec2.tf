resource "aws_instance" "ziyotek-instance-1" {
  ami                         = data.aws_ami.example.image_id #"ami-0436be3ca85657f11" #data.aws_ami.example.image_id
  instance_type               = var.instance_type
  associate_public_ip_address = true #bool
  subnet_id                   = var.subnet_id
  key_name                    = var.your_key
  vpc_security_group_ids      = var.vpc_security_group #[aws_security_group.ziyotek_devops_all_all.id]
  iam_instance_profile        = var.instance_profile   #aws_iam_instance_profile.ec2_profile.id
  user_data                   = file("../MODULES/FILES/userdata.sh")
  lifecycle {
      #create_before_destroy = true
      #prevent_destroy = true
      ignore_changes = [tags]
 }
   tags = {
    Name = "SampleApp"    
  }
}