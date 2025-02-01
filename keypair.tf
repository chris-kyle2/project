resource "aws_key_pair" "MyServer1" {
  key_name   = "MyServer1"
  public_key = file(var.PUB_KEY_PATH)

}
