awsfiles
========

My [AWS][] [Terraform][] and [OctoDNS][] configuration and assorted
other crap.

[AWS]: https://aws.amazon.com/
[Terraform]: https://www.terraform.io/
[OctoDNS]: https://github.com/github/octodns

Organisation
------------

### OctoDNS

Each config file in `octodns/zones/` is a distinct DNS zone which can
be applied independently of the others.

Use the `./bin/octodns.sh` script to run OctoDNS commands on a zone.
It assumes you have an `octodns` profile in your `~/.aws/credentials`
file with the access key ID and secret access key given.

#### Basic DNS records

New domains should generally have at lease these records:

```yaml
"":
# A record on the apex domain
- type: "A"
  values:
  - "{ipv4 address goes here}"

# AAAA record on the apex domain
- type: "AAAA"
  values:
  - "{ipv6 address goes here}"

# MX record specifying that no mail is received
- type: "MX"
  values:
  - exchange: "."
    preference: 0

# TXT SPF record specifying that no mail is sent
- type: "TXT"
  values:
  - "v=spf1 -all"

"*":
# A record on the wildcard subdomain
- type: "A"
  values:
  - "{ipv4 address goes here}"

# AAAA record on the wildcard subdomain
- type: "AAAA"
  values:
  - "{ipv6 address goes here}"

# TXT DKIM record specifying an empty public key
"*._domainkey":
  type: "TXT"
  value: "v=DKIM1\\; p="

# TXT DMARC record specifying to reject all mail
"_dmarc":
  type: "TXT"
  values:
  - "v=DMARC1\\; p=reject\\; sp=reject\\; adkim=s\\; aspf=s\\; fo=1\\; rua=mailto:mike+dmarc@barrucadu.co.uk"
```

For more information about the mail records, [see the guidance on
GOV.UK][].

[see the guidance on GOV.UK]: https://www.gov.uk/guidance/protect-domains-that-dont-send-email
