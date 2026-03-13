module "infrastructure" {
  source = "./modules/infrastructure"

  vpc_cidr         = "10.0.0.0/16"
  instance_type    = "t2.micro"
  assign_public_ip = true
    subnet_count = 2
}