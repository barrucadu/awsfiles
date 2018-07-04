locals {
  "innsmouth_ipv4"  = "139.162.211.161"
  "innsmouth_ipv6"  = "2a01:7e00::f03c:91ff:fee4:c7d5"
  "lainonlife_ipv4" = "91.121.0.148"
  "lainonlife_ipv6" = "2001:41d0:0001:5394::1"
  "default_ttl"     = "86400"
}

/* ************************************************************************* */

resource "aws_route53_zone" "barrucadu_co_uk" {
  name = "barrucadu.co.uk."
}

resource "aws_route53_record" "A_barrucadu_co_uk" {
  zone_id = "${aws_route53_zone.barrucadu_co_uk.zone_id}"
  name    = "${aws_route53_zone.barrucadu_co_uk.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv4}"]
}

resource "aws_route53_record" "A_star_barrucadu_co_uk" {
  zone_id = "${aws_route53_zone.barrucadu_co_uk.zone_id}"
  name    = "*.${aws_route53_zone.barrucadu_co_uk.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv4}"]
}

resource "aws_route53_record" "AAAA_barrucadu_co_uk" {
  zone_id = "${aws_route53_zone.barrucadu_co_uk.zone_id}"
  name    = "${aws_route53_zone.barrucadu_co_uk.name}"
  type    = "AAAA"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv6}"]
}

resource "aws_route53_record" "AAAA_star_barrucadu_co_uk" {
  zone_id = "${aws_route53_zone.barrucadu_co_uk.zone_id}"
  name    = "*.${aws_route53_zone.barrucadu_co_uk.name}"
  type    = "AAAA"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv6}"]
}

resource "aws_route53_record" "CNAME_innsmouth_barrucadu_co_uk" {
  zone_id = "${aws_route53_zone.barrucadu_co_uk.zone_id}"
  name    = "innsmouth.${aws_route53_zone.barrucadu_co_uk.name}"
  type    = "CNAME"
  ttl     = "${local.default_ttl}"
  records = ["li1374-161.members.linode.com"]
}

resource "aws_route53_record" "MX_barrucadu_co_uk" {
  zone_id = "${aws_route53_zone.barrucadu_co_uk.zone_id}"
  name    = "${aws_route53_zone.barrucadu_co_uk.name}"
  type    = "MX"
  ttl     = "${local.default_ttl}"
  records = ["0 aspmx.l.google.com."]
}

/* ************************************************************************* */

resource "aws_route53_zone" "barrucadu_com" {
  name = "barrucadu.com."
}

resource "aws_route53_record" "A_barrucadu_com" {
  zone_id = "${aws_route53_zone.barrucadu_com.zone_id}"
  name    = "${aws_route53_zone.barrucadu_com.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv4}"]
}

resource "aws_route53_record" "A_star_barrucadu_com" {
  zone_id = "${aws_route53_zone.barrucadu_com.zone_id}"
  name    = "*.${aws_route53_zone.barrucadu_com.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv4}"]
}

resource "aws_route53_record" "AAAA_barrucadu_com" {
  zone_id = "${aws_route53_zone.barrucadu_com.zone_id}"
  name    = "${aws_route53_zone.barrucadu_com.name}"
  type    = "AAAA"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv6}"]
}

resource "aws_route53_record" "AAAA_star_barrucadu_com" {
  zone_id = "${aws_route53_zone.barrucadu_com.zone_id}"
  name    = "*.${aws_route53_zone.barrucadu_com.name}"
  type    = "AAAA"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv6}"]
}

/* ************************************************************************* */

resource "aws_route53_zone" "barrucadu_uk" {
  name = "barrucadu.uk."
}

resource "aws_route53_record" "A_barrucadu_uk" {
  zone_id = "${aws_route53_zone.barrucadu_uk.zone_id}"
  name    = "${aws_route53_zone.barrucadu_uk.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv4}"]
}

resource "aws_route53_record" "A_star_barrucadu_uk" {
  zone_id = "${aws_route53_zone.barrucadu_uk.zone_id}"
  name    = "*.${aws_route53_zone.barrucadu_uk.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv4}"]
}

resource "aws_route53_record" "AAAA_barrucadu_uk" {
  zone_id = "${aws_route53_zone.barrucadu_uk.zone_id}"
  name    = "${aws_route53_zone.barrucadu_uk.name}"
  type    = "AAAA"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv6}"]
}

resource "aws_route53_record" "AAAA_star_barrucadu_uk" {
  zone_id = "${aws_route53_zone.barrucadu_uk.zone_id}"
  name    = "*.${aws_route53_zone.barrucadu_uk.name}"
  type    = "AAAA"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv6}"]
}

/* ************************************************************************* */

resource "aws_route53_zone" "uzbl_org" {
  name = "uzbl.org."
}

resource "aws_route53_record" "A_uzbl_org" {
  zone_id = "${aws_route53_zone.uzbl_org.zone_id}"
  name    = "${aws_route53_zone.uzbl_org.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv4}"]
}

resource "aws_route53_record" "A_star_uzbl_org" {
  zone_id = "${aws_route53_zone.uzbl_org.zone_id}"
  name    = "*.${aws_route53_zone.uzbl_org.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv4}"]
}

resource "aws_route53_record" "AAAA_uzbl_org" {
  zone_id = "${aws_route53_zone.uzbl_org.zone_id}"
  name    = "${aws_route53_zone.uzbl_org.name}"
  type    = "AAAA"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv6}"]
}

resource "aws_route53_record" "AAAA_star_uzbl_org" {
  zone_id = "${aws_route53_zone.uzbl_org.zone_id}"
  name    = "*.${aws_route53_zone.uzbl_org.name}"
  type    = "AAAA"
  ttl     = "${local.default_ttl}"
  records = ["${local.innsmouth_ipv6}"]
}

/* ************************************************************************* */

resource "aws_route53_zone" "archhurd_org" {
  name = "archhurd.org."
}

resource "aws_route53_record" "A_archhurd_org" {
  zone_id = "${aws_route53_zone.archhurd_org.zone_id}"
  name    = "${aws_route53_zone.archhurd_org.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["128.199.32.197"]
}

resource "aws_route53_record" "A_star_archhurd_org" {
  zone_id = "${aws_route53_zone.archhurd_org.zone_id}"
  name    = "*.${aws_route53_zone.archhurd_org.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["128.199.32.197"]
}

/* ************************************************************************* */

resource "aws_route53_zone" "lainon_life" {
  name = "lainon.life."
}

resource "aws_route53_record" "A_lainon_life" {
  zone_id = "${aws_route53_zone.lainon_life.zone_id}"
  name    = "${aws_route53_zone.lainon_life.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["${local.lainonlife_ipv4}"]
}

resource "aws_route53_record" "A_star_lainon_life" {
  zone_id = "${aws_route53_zone.lainon_life.zone_id}"
  name    = "*.${aws_route53_zone.lainon_life.name}"
  type    = "A"
  ttl     = "${local.default_ttl}"
  records = ["${local.lainonlife_ipv4}"]
}

resource "aws_route53_record" "AAAA_lainon_life" {
  zone_id = "${aws_route53_zone.lainon_life.zone_id}"
  name    = "${aws_route53_zone.lainon_life.name}"
  type    = "AAAA"
  ttl     = "${local.default_ttl}"
  records = ["${local.lainonlife_ipv6}"]
}

resource "aws_route53_record" "AAAA_star_lainon_life" {
  zone_id = "${aws_route53_zone.lainon_life.zone_id}"
  name    = "*.${aws_route53_zone.lainon_life.name}"
  type    = "AAAA"
  ttl     = "${local.default_ttl}"
  records = ["${local.lainonlife_ipv6}"]
}
