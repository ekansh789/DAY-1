# ==========================================
# terraform.tfvars
# ==========================================

aws_region = "ap-south-1"

# Existing AWS EC2 Key Pair
key_name = "Ekansh-bootcamp"

# Your Public IP for SSH Access
allowed_ssh_ip = "106.222.214.102/32"

# ==========================================
# Mandatory Resource Tags
# ==========================================

owner        = "ekansh.dwivedi@einfochips.com"
dm           = "Bharatkumar.advani@einfochips.com"
department   = "PES"
project_name = "EIC internal"
end_date     = "26/08/2026"
bu           = "IA"
vpc_id       = "vpc-02358ddc1cb955bcd"
route_table_id      = "rtb-0898c89baeb6ebb57" 
internet_gateway_id = "igw-095a43d99a5ec72d6"

