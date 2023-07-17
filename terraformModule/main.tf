provider "aws"{
 region = "us-east-1"
}

module "module2"{
 source = "../"
}
