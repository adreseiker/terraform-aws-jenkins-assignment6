#########################
# keys.tf 
# Use an already created EC2 Key Pair.
# Nothing is created here to avoid InvalidKeyPair.Duplicate.
#########################

# Expect a variable with the name of an existing EC2 Key Pair
# Example usage in instances:
#   key_name = var.key_name

# If you ever want Terraform to create a new key instead,
# replace this file with a version that defines:
#   - tls_private_key
#   - local_file (to save the private key)
#   - aws_key_pair (using the public key)
# But for the assignment, using an existing Key Pair is simpler and safer.
