locals {
  "innsmouth_ipv4"  = "139.162.211.161"
  "innsmouth_ipv6"  = "2a01:7e00::f03c:91ff:fee4:c7d5"
  "dunwich_ipv4"    = "116.203.134.200"
  "dunwich_ipv6"    = "2a01:4f8:c2c:2b22::"
}

/* ************************************************************************* */

module "barrucadu_co_uk" {
  source = "../../modules/dns"
  domain = "barrucadu.co.uk"
  a      = ["${local.dunwich_ipv4}"]
  aaaa   = ["${local.dunwich_ipv6}"]
  mx     = ["0 aspmx.l.google.com."]
}

module "barrucadu_uk" {
  source = "../../modules/dns"
  domain = "barrucadu.uk"
  a      = ["${local.dunwich_ipv4}"]
  aaaa   = ["${local.dunwich_ipv6}"]
}

module "barrucadu_com" {
  source = "../../modules/dns"
  domain = "barrucadu.com"
  a      = ["${local.dunwich_ipv4}"]
  aaaa   = ["${local.dunwich_ipv6}"]
}

module "uzbl_org" {
  source = "../../modules/dns"
  domain = "uzbl.org"
  a      = ["${local.dunwich_ipv4}"]
  aaaa   = ["${local.dunwich_ipv6}"]
}

resource "aws_route53_record" "A_dunwich_barrucadu_co_uk" {
  zone_id = "${module.barrucadu_co_uk.zone_id}"
  name    = "dunwich.barrucadu.co.uk"
  type    = "A"
  ttl     = 300
  records = ["${local.dunwich_ipv4}"]
}
resource "aws_route53_record" "AAAA_dunwich_barrucadu_co_uk" {
  zone_id = "${module.barrucadu_co_uk.zone_id}"
  name    = "dunwich.barrucadu.co.uk"
  type    = "AAAA"
  ttl     = 300
  records = ["${local.dunwich_ipv6}"]
}
resource "aws_route53_record" "star_dunwich_barrucadu_co_uk" {
  zone_id = "${module.barrucadu_co_uk.zone_id}"
  name    = "*.dunwich.barrucadu.co.uk"
  type    = "CNAME"
  ttl     = 300
  records = ["dunwich.barrucadu.co.uk"]
}

resource "aws_route53_record" "innsmouth_barrucadu_co_uk" {
  zone_id = "${module.barrucadu_co_uk.zone_id}"
  name    = "innsmouth.barrucadu.co.uk"
  type    = "CNAME"
  ttl     = 300
  records = ["li1374-161.members.linode.com"]
}

output "barrucadu_co_uk_name_servers" {
  value = "${module.barrucadu_co_uk.name_servers}"
}

output "barrucadu_uk_name_servers" {
  value = "${module.barrucadu_uk.name_servers}"
}

output "barrucadu_com_name_servers" {
  value = "${module.barrucadu_com.name_servers}"
}

output "uzbl_org_name_servers" {
  value = "${module.uzbl_org.name_servers}"
}

/* ************************************************************************* */

module "archhurd_org" {
  source = "../../modules/dns"
  domain = "archhurd.org"
  a      = ["128.199.32.197"]
}

output "archhurd_org_name_servers" {
  value = "${module.archhurd_org.name_servers}"
}

/* ************************************************************************* */

module "lainon_life" {
  source = "../../modules/dns"
  domain = "lainon.life"
  a      = ["91.121.0.148"]
  aaaa   = ["2001:41d0:0001:5394::1"]
}

output "lainon_life_name_servers" {
  value = "${module.lainon_life.name_servers}"
}
