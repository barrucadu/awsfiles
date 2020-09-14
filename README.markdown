awsfiles
========

My [AWS][] [Terraform][] and [OctoDNS][] configuration and assorted
other crap.

[AWS]: https://aws.amazon.com/
[Terraform]: https://www.terraform.io/
[OctoDNS]: https://github.com/github/octodns

Organisation
------------

### Terraform

Each subdirectory under `terraform/projects/` is a distinct piece of
infrastructure which can be applied and destroyed independent of the
others.

A project has three files:

- `terraform/projects/PROJECT/main.tf` - infrastructure defined by the project
- `terraform/projects/PROJECT/provider.tf` - configuration for terraform
- `terraform/projects/PROJECT/version.tf` - the version of terraform to use

Use the `./bin/terraform.sh` script to run terraform commands on a
project.  It assumes you have a `terraform` profile in your
`~/.aws/credentials` file with the access key ID and secret access key
given.

### OctoDNS

Each config file in `octodns/zones/` is a distinct DNS zone which can
be applied independently of the others.

Use the `./bin/octodns.sh` script to run OctoDNS commands on a zone.
It assumes you have an `octodns` profile in your `~/.aws/credentials`
file with the access key ID and secret access key given.
