# ------------------------------------------------------------------------------
# SSH Key Pair
# ------------------------------------------------------------------------------

resource "aws_key_pair" "ec2_keypair" {
  key_name   = "rhel6-build"
  public_key = local.ec2_data["public-key"]
}
