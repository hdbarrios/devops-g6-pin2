output "apache_instance_ip" {
  description = "IP pública de la instancia Apache"
  value       = aws_instance.apache_server.public_ip
}

output "apache_instance_private_ip" {
  description = "IP privada de la instancia Apache"
  value       = aws_instance.apache_server.private_ip
}

output "apache_instance_id" {
  description = "ID de la instancia Apache"
  value       = aws_instance.apache_server.id
}

output "apache_instance_type" {
  description = "Tipo de la instancia Apache"
  value       = aws_instance.apache_server.instance_type
}

output "apache_instance_state" {
  description = "Estado actual de la instancia Apache"
  value       = aws_instance.apache_server.instance_state
}

output "apache_instance_public_dns" {
  description = "DNS público de la instancia Apache"
  value       = aws_instance.apache_server.public_dns
}

output "apache_instance_private_dns" {
  description = "DNS privado de la instancia Apache"
  value       = aws_instance.apache_server.private_dns
}

output "vpc_id" {
  description = "ID de la VPC"
  value       = aws_vpc.vpc.id
}

output "subnet_id" {
  description = "ID de la subred en la que se encuentra la instancia"
  value       = aws_subnet.subnet_public.id
}

output "security_group_id" {
  description = "ID del Security Group asociado"
  value       = aws_security_group.sg.id
}

output "route_table_id" {
  description = "ID de la tabla de rutas de la VPC"
  value       = aws_route_table.route_table.id
}

output "internet_gateway_id" {
  description = "ID del Internet Gateway"
  value       = aws_internet_gateway.igw.id
}

output "availability_zone" {
  description = "Zona de disponibilidad de la instancia"
  value       = element(data.aws_availability_zones.azs.names, 0)
}

output "instance_key_name" {
  description = "Nombre de la clave SSH de la instancia"
  value       = aws_instance.apache_server.key_name
}


