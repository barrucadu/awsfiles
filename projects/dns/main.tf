locals {
  "dunwich_ipv4"      = "116.203.134.200"
  "dunwich_ipv6"      = "2a01:4f8:c2c:2b22::"
  "nyarlathotep_ipv6" = "2a01:4b00:8573:d700::1d3"
}

/* ************************************************************************* */

module "barrucadu_co_uk" {
  source = "../../modules/dns"
  domain = "barrucadu.co.uk"
  a      = ["${local.dunwich_ipv4}"]
  aaaa   = ["${local.dunwich_ipv6}"]
  mx     = ["10 mail.protonmail.ch", "20 mailsec.protonmail.ch"]
}

module "dunwich_barrucadu_co_uk" {
  source    = "../../modules/dns_subdomain"
  zone_id   = "${module.barrucadu_co_uk.zone_id}"
  domain    = "${module.barrucadu_co_uk.domain}"
  subdomain = "dunwich"
  a         = ["${local.dunwich_ipv4}"]
  aaaa      = ["${local.dunwich_ipv6}"]
}

module "nyarlathotep_barrucadu_co_uk" {
  source    = "../../modules/dns_subdomain"
  zone_id   = "${module.barrucadu_co_uk.zone_id}"
  domain    = "${module.barrucadu_co_uk.domain}"
  subdomain = "nyarlathotep"
  aaaa      = ["${local.nyarlathotep_ipv6}"]
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

resource "aws_route53_record" "barrucadu_co_uk-mail" {
  zone_id = "${module.barrucadu_co_uk.zone_id}"
  name    = ""
  type    = "TXT"
  ttl     = 300
  records = [
    "protonmail-verification=68e94ed315f5df9a3060beb99c6c8ca059e0c741",
    "v=spf1 include:_spf.protonmail.ch mx ~all",
  ]
}

resource "aws_route53_record" "barrucadu_co_uk-mail-dkim" {
  zone_id = "${module.barrucadu_co_uk.zone_id}"
  name    = "protonmail._domainkey"
  type    = "TXT"
  ttl     = 300
  records = [
    "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDT7ZHsQ5JugP93QTFy7aINyXIQ16edbhP26ug+3+7Wg55Q4+IRuuBfqxqRtXr8DUJM42RTauL/T+aPJ16esAI+Y7kXC77wmEsDVXWGvhwEQMnWSpJhog8OUaKQqhGP4tlEaszw/kjDbfABTfx8ZRr0RGzGv9vxY8D/nWvvhEy15QIDAQAB"
  ]
}

resource "aws_route53_record" "barrucadu_co_uk-mail-dmarc" {
  zone_id = "${module.barrucadu_co_uk.zone_id}"
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 300
  records = [
    "v=DMARC1; p=none; rua=mailto:barrucadu.fallback@gmail.com"
  ]
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
