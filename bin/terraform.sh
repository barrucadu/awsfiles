#! /usr/bin/env nix-shell
#! nix-shell -i bash -p crudini terraform

set -e

PROJECT="$1"
PROJECT_DIR="terraform/projects/$PROJECT"
shift

if [[ ! -f "$PROJECT_DIR/main.tf" ]]; then
  echo "usage: $0 project command [arg...]"
  exit 1
fi

if [[ -z "$AWS_ACCESS_KEY" ]]; then
  AWS_ACCESS_KEY="$(crudini --get ~/.aws/credentials "terraform" aws_access_key_id)"
  export AWS_ACCESS_KEY
fi

if [[ -z "$AWS_SECRET_ACCESS_KEY" ]]; then
  AWS_SECRET_ACCESS_KEY="$(crudini --get ~/.aws/credentials "terraform" aws_secret_access_key)"
  export AWS_SECRET_ACCESS_KEY
fi

if [[ -z "$AWS_ACCESS_KEY" ]] || [[ -z "$AWS_SECRET_ACCESS_KEY" ]]; then
  echo "could not fetch AWS credentials for 'terraform' profile"
  exit 2
fi

cd "$PROJECT_DIR"
terraform "$@"
