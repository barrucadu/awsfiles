variable "domain" {
  type        = "string"
  description = "The domain name"
}

variable "ttl" {
  type        = "string"
  description = "The time-to-live"
  default     = 300
}

variable "a" {
  type        = "list"
  description = "List of A records to use for (*.){domain}"
  default     = []
}

variable "aaaa" {
  type        = "list"
  description = "List of AAAA records to use for (*.){domain}"
  default     = []
}

variable "mx" {
  type        = "list"
  description = "List of MX records to use for {domain}"
  default     = []
}

/* ************************************************************************* */

locals {
  create_a    = "${length(var.a)    > 0 ? 1 : 0}"
  create_aaaa = "${length(var.aaaa) > 0 ? 1 : 0}"
  create_mx   = "${length(var.mx)   > 0 ? 1 : 0}"
}

resource "aws_route53_zone" "domain" {
  name = "${var.domain}."
}

resource "aws_route53_record" "A" {
  count   = "${local.create_a}"
  zone_id = "${aws_route53_zone.domain.zone_id}"
  name    = "${aws_route53_zone.domain.name}"
  type    = "A"

  alias {
    zone_id = "${aws_route53_record.A_star[0].zone_id}"
    name    = "${aws_route53_record.A_star[0].name}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "A_star" {
  count   = "${local.create_a}"
  zone_id = "${aws_route53_zone.domain.zone_id}"
  name    = "*.${aws_route53_zone.domain.name}"
  type    = "A"
  ttl     = "${var.ttl}"
  records = "${var.a}"
}

resource "aws_route53_record" "AAAA" {
  count   = "${local.create_aaaa}"
  zone_id = "${aws_route53_zone.domain.zone_id}"
  name    = "${aws_route53_zone.domain.name}"
  type    = "AAAA"

  alias {
    zone_id = "${aws_route53_record.AAAA_star[0].zone_id}"
    name    = "${aws_route53_record.AAAA_star[0].name}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "AAAA_star" {
  count   = "${local.create_aaaa}"
  zone_id = "${aws_route53_zone.domain.zone_id}"
  name    = "*.${aws_route53_zone.domain.name}"
  type    = "AAAA"
  ttl     = "${var.ttl}"
  records = "${var.aaaa}"
}

resource "aws_route53_record" "MX" {
  count   = "${local.create_mx}"
  zone_id = "${aws_route53_zone.domain.zone_id}"
  name    = "${aws_route53_zone.domain.name}"
  type    = "MX"
  ttl     = "${var.ttl}"
  records = "${var.mx}"
}

/* ************************************************************************* */

output "zone_id" {
  value       = "${aws_route53_zone.domain.zone_id}"
  description = "The ID of the DNS zone."
}

output "domain" {
  value       = "${aws_route53_zone.domain.name}"
  description = "The domain name."
}

output "name_servers" {
  value = "${aws_route53_zone.domain.name_servers}"
}
