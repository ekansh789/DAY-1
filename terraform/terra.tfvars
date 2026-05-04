# ==========================================
# terraform.tfvars
# ==========================================

aws_region = "ap-south-1"

# Existing AWS EC2 Key Pair
key_name = "my-existing-key"

# Your Public IP for SSH Access
allowed_ssh_ip = "X.X.X.X/32"

# ==========================================
# Mandatory Resource Tags
# ==========================================

owner        = "ekansh.dwivedi@einfochips.com"
dm           = "Bharatkumar.advani@einfochips.com"
department   = "PES"
project_name = "EIC internal"
end_date     = "26/08/2026"
bu           = "IA"