resource "aws_key_pair" "deployer" {
  key_name   = "dove-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ5oq4+Mp/p8tdebZNl2LXnFY6pv5qnd/4QtugYzsaot HP@DESKTOP-EF4JLAG"
}

resource "aws_key_pair" "test-key" {
  key_name   = "test-key"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDTSZxbX2e6rJZz5diK2FtivuyLqdTmoNj7c15eoT2y1 HP@DESKTOP-EF4JLAG"
}