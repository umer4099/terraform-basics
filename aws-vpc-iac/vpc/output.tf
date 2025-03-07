output "vpc_id" {
    description = "output-vpc"
    value = aws_vpc.example.id
  
}
# output "private_subnets" {
#     description = "private-vpc"
#     value = var.private_subnet_cidrs
# }
# output "public_subnets" {
#   description = "public-vpc"
#   value = var.public_subnet_cidrs
# }
output "public_subnet" {
  value = aws_subnet.public_subnets[*].id
}
output "private_subnet" {
  value = aws_subnet.private_subnets[*].id
}
