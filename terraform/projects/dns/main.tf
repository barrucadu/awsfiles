locals {
  dunwich_ipv4 = "116.203.134.200"
  dunwich_ipv6 = "2a01:4f8:c2c:2b22::"

  dreamlands_ipv4 = "94.130.74.147"
  dreamlands_ipv6 = "2a01:4f8:c0c:77b3::"
}

/* ************************************************************************* */

variable "group_dns_user_names" {
  type = list(string)
}

module "group_dns" {
  source           = "../../modules/group_user"
  group_name       = "dns"
  group_user_names = var.group_dns_user_names

  group_policy_arns = [
    aws_iam_policy.tool_octodns.arn,
  ]
}

resource "aws_iam_policy" "tool_octodns" {
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "route53:*"
            ],
            "Effect": "Allow",
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}

/* ************************************************************************* */

module "barrucadu_co_uk" {
  source = "../../modules/dns"
  domain = "barrucadu.co.uk"
  a      = [local.dunwich_ipv4]
  aaaa   = [local.dunwich_ipv6]
  mx     = ["10 mail.protonmail.ch", "20 mailsec.protonmail.ch"]
}

module "dunwich_barrucadu_co_uk" {
  source    = "../../modules/dns_subdomain"
  zone_id   = module.barrucadu_co_uk.zone_id
  domain    = module.barrucadu_co_uk.domain
  subdomain = "dunwich"
  a         = [local.dunwich_ipv4]
  aaaa      = [local.dunwich_ipv6]
}

module "dreamlands_barrucadu_co_uk" {
  source    = "../../modules/dns_subdomain"
  zone_id   = module.barrucadu_co_uk.zone_id
  domain    = module.barrucadu_co_uk.domain
  subdomain = "dreamlands"
  a         = [local.dreamlands_ipv4]
  aaaa      = [local.dreamlands_ipv6]
}

module "barrucadu_uk" {
  source = "../../modules/dns"
  domain = "barrucadu.uk"
  a      = [local.dunwich_ipv4]
  aaaa   = [local.dunwich_ipv6]
}

module "barrucadu_dev" {
  source = "../../modules/dns"
  domain = "barrucadu.dev"
  a      = [local.dreamlands_ipv4]
  aaaa   = [local.dreamlands_ipv6]
}

resource "aws_route53_record" "barrucadu_co_uk-mail" {
  zone_id = module.barrucadu_co_uk.zone_id
  name    = ""
  type    = "TXT"
  ttl     = 300
  records = [
    "protonmail-verification=68e94ed315f5df9a3060beb99c6c8ca059e0c741",
    "v=spf1 include:_spf.protonmail.ch mx ~all",
  ]
}

resource "aws_route53_record" "barrucadu_co_uk-mail-dkim_1" {
  zone_id = module.barrucadu_co_uk.zone_id
  name    = "protonmail._domainkey"
  type    = "CNAME"
  ttl     = 300
  records = [
    "protonmail.domainkey.dpk2ikzsdalpp7gz5u7nsmcwt5wtskf627vh7o2tr5qictip25yoq.domains.proton.ch."
  ]
}

resource "aws_route53_record" "barrucadu_co_uk-mail-dkim_2" {
  zone_id = module.barrucadu_co_uk.zone_id
  name    = "protonmail2._domainkey"
  type    = "CNAME"
  ttl     = 300
  records = [
    "protonmail2.domainkey.dpk2ikzsdalpp7gz5u7nsmcwt5wtskf627vh7o2tr5qictip25yoq.domains.proton.ch."
  ]
}

resource "aws_route53_record" "barrucadu_co_uk-mail-dkim_3" {
  zone_id = module.barrucadu_co_uk.zone_id
  name    = "protonmail3._domainkey"
  type    = "CNAME"
  ttl     = 300
  records = [
    "protonmail3.domainkey.dpk2ikzsdalpp7gz5u7nsmcwt5wtskf627vh7o2tr5qictip25yoq.domains.proton.ch."
  ]
}

resource "aws_route53_record" "barrucadu_co_uk-mail-dmarc" {
  zone_id = module.barrucadu_co_uk.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = 300
  records = [
    "v=DMARC1; p=none; rua=mailto:barrucadu.fallback@gmail.com"
  ]
}

output "barrucadu_co_uk_name_servers" {
  value = module.barrucadu_co_uk.name_servers
}

output "barrucadu_uk_name_servers" {
  value = module.barrucadu_uk.name_servers
}

output "barrucadu_dev_name_servers" {
  value = module.barrucadu_dev.name_servers
}

/* ************************************************************************* */

module "lainon_life" {
  source = "../../modules/dns"
  domain = "lainon.life"
  a      = ["91.121.0.148"]
  aaaa   = ["2001:41d0:0001:5394::1"]
}

output "lainon_life_name_servers" {
  value = module.lainon_life.name_servers
}
