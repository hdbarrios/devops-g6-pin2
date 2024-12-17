provider "aws" {
  region  = var.aws_region                            # Región de AWS
  profile = var.aws_profile                      # Perfil configurado con acceso programático
}

# Leer la clave pública desde el archivo .pem
# Generar la clave privada localmente
# openssl genpkey -algorithm RSA -out apache-key.pem
# openssl rsa -in apache-key.pem -text -noout

resource "aws_key_pair" "apache_key" {
  key_name   = "apache-key"                        
  public_key = file("${var.profile_path}/apache-key.pub") # Asegúrate de tener la clave pública generada
}

# Crear la instancia EC2
#
resource "aws_instance" "apache_server" {
  ami             = var.ec2_ami
  instance_type   = var.ec2_instance_type
  key_name        = aws_key_pair.apache_key.key_name

  # Asociar la EC2 con la subred de la VPC
  subnet_id       = aws_subnet.subnet_public.id
  vpc_security_group_ids = [aws_security_group.sg.id]  # Asociar el grupo de seguridad

  root_block_device {
    volume_type = var.ec2_storage_type   # Tipo de volumen EBS (por ejemplo, gp2)
    volume_size = var.ec2_storage        # Tamaño del volumen en GB (40GB en tu caso)
    encrypted  = false                   # Si se debe encriptar el volumen (false en este caso)
  }

  tags = merge(
    var.tags,
    {
      Name         = var.ec2_name
      Project = "PIN2"
      Group = "Grupo6"
    }
  )
  
  #user_data = "${file("profiles/provision.sh")}"
  user_data = templatefile("${var.profile_path}/provision.sh", {
    ami_user = "ubuntu"
  })

}


output "instance_ip" {
  description = "Dirección IP pública de la instancia"
  value       = aws_instance.apache_server.public_ip
}

