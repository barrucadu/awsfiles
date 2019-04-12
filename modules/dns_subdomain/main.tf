variable "zone_id" {
  type        = "string"
  description = "The Route53 Zone ID of the parent domain"
}

variable "domain" {
  type        = "string"
  description = "The domain name"
}

variable "subdomain" {
  type        = "string"
  description = "The subdomain name"
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

/* ************************************************************************* */

locals {
  create_a    = "${length(var.a)    > 0 ? 1 : 0}"
  create_aaaa = "${length(var.aaaa) > 0 ? 1 : 0}"
}

resource "aws_route53_record" "A" {
  count   = "${local.create_a}"
  zone_id = "${var.zone_id}"
  name    = "${var.subdomain}.${var.domain}"
  type    = "A"

  alias {
    zone_id = "${aws_route53_record.A_star.zone_id}"
    name    = "${aws_route53_record.A_star.name}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "A_star" {
  count   = "${local.create_a}"
  zone_id = "${var.zone_id}"
  name    = "*.${var.subdomain}.${var.domain}"
  type    = "A"
  ttl     = "${var.ttl}"
  records = ["${var.a}"]
}

resource "aws_route53_record" "AAAA" {
  count   = "${local.create_aaaa}"
  zone_id = "${var.zone_id}"
  name    = "${var.subdomain}.${var.domain}"
  type    = "AAAA"

  alias {
    zone_id = "${aws_route53_record.AAAA_star.zone_id}"
    name    = "${aws_route53_record.AAAA_star.name}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "AAAA_star" {
  count   = "${local.create_aaaa}"
  zone_id = "${var.zone_id}"
  name    = "*.${var.subdomain}.${var.domain}"
  type    = "AAAA"
  ttl     = "${var.ttl}"
  records = ["${var.aaaa}"]
}
