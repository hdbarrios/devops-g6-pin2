
# Crear VPC en us-east-1
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr         # Usar la variable CIDR del VPC
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = merge(
    var.tags,
    {
      Name    = "terraform-vpc"
      Project = "PIN2"
      Group   = "Grupo6"
    }
  )
}

# Obtener todas las zonas de disponibilidad para la región
data "aws_availability_zones" "azs" {
  state = "available"
}

# Crear Subred Pública #1 en la primera zona de disponibilidad
resource "aws_subnet" "subnet_public" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet_cidrs[0]  # Usar CIDR para la subred pública
  map_public_ip_on_launch = true  # Permitir asignación de IP pública
  tags = {
    Name = "subnet-public-1"
  }
}

# Crear Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}

# Crear tabla de rutas
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  
  tags = {
    Name = "Route_Table"
  }
}

# Agregar una ruta predeterminada (0.0.0.0/0) a la tabla de rutas
resource "aws_route" "route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Asociar la tabla de rutas con la Subnet Pública
resource "aws_route_table_association" "subnet_association_public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.route_table.id
}

# Crear Grupo de Seguridad (SG) para permitir TCP/80 y TCP/22
resource "aws_security_group" "sg" {
  name        = "sg"
  description = "Allow TCP/80 & TCP/22"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr   # Usar la variable de CIDR permitidas para SSH
  }

  ingress {
    description = "Allow HTTP traffic on TCP/80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

