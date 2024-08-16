locals {
  foreachset = var.setstr1
  str1= strcontains(var.str1, "ipsum")? "true" : "false"
  any1= var.any1

}

resource "null_resource" "example" {
  triggers = {
    echo = local.str1
    name = "dev-${local.any1}"
    http = "${var.mapProtocolVsPort["HTTP"]}"
    //upper = [ for i in local.foreachset :  tostring(i) if i !="a" ]
    setname =join("-", [ for i in local.foreachset :  tostring(i) if i !="a" ])
    }
}

resource "local_file" "devops" {
  count    = length(var.liststr2)
  filename = "${var.liststr2[0]}-${var.liststr1[0]}.txt"
  content  = join("-", var.setstr1)

}