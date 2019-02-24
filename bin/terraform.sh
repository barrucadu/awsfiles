#! /usr/bin/env nix-shell
#! nix-shell -i bash -p crudini terraform

PROJECT="$1"
PROJECT_DIR="projects/$PROJECT"
shift

if [[ ! -f "$PROJECT_DIR/main.tf" ]]; then
  echo "usage: $0 project command [arg...]"
  exit 1
fi

export AWS_ACCESS_KEY="`crudini --get ~/.aws/credentials "terraform" aws_access_key_id`"
export AWS_SECRET_ACCESS_KEY="`crudini --get ~/.aws/credentials "terraform" aws_secret_access_key`"

if [[ -z "$AWS_ACCESS_KEY" ]] || [[ -z "$AWS_SECRET_ACCESS_KEY" ]]; then
  echo "could not fetch AWS credentials for 'terraform' profile"
  exit 2
fi

pushd "$PROJECT_DIR" &>/dev/null
terraform "$@"
