
# resource "aws_instance" "cz-jump-ec2" {
#   ami           = "ami-0e449927258d45bc4"
#   instance_type = "t2.micro"
#   subnet_id     = var.subnet_id #pb-1
#   vpc_security_group_ids = var.vpc_security_group_ids
            
#   tags = {
#     Name = "cz-jump-ec2"
#   }
# }

resource "aws_launch_template" "cz-ecs-asg-tmpl" {
  tags = {
    name = "cz-ecs-asg-tmpl"
  }

  name = "cz-launch-tmpl"
  image_id = "ami-0e449927258d45bc4"
  instance_type = "t2.micro"
  vpc_security_group_ids = var.vpc_security_group_ids
  user_data = "./user-data.sh"
  
}

resource "aws_autoscaling_group" "cz-ecs-asg" {
  name                 = "cz-ecs-asg"
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  vpc_zone_identifier  = var.vpc_private_subnets
  launch_template {
    id = aws_launch_template.cz-ecs-asg-tmpl.id
    } 
}