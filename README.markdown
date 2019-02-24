awsfiles
========

My [AWS][] [Terraform][] configuration and assorted other crap.

[AWS]: https://aws.amazon.com/
[Terraform]: https://www.terraform.io/

Organisation
------------

Each subdirectory under `projects/` is a distinct piece of
infrastructure which can be applied and destroyed independent of the
others.

A project has two files:

- `projects/PROJECT/main.tf` - infrastructure defined by the project
- `projects/PROJECT/provider.tf` - configuration for terraform

Use the `./bin/terraform.sh` script to run terraform commands on a
project.  It assumes you have a `terraform` profile in your
`~/.aws/credentials` file with the access key ID and secret access key
given.
