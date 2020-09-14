#! /usr/bin/env nix-shell
#! nix-shell -i bash -p crudini "python3.withPackages (ps: [ps.virtualenv])"

set -e

if [[ -z "$AWS_ACCESS_KEY_ID" ]]; then
  AWS_ACCESS_KEY_ID="$(crudini --get ~/.aws/credentials "octodns" aws_access_key_id)"
  export AWS_ACCESS_KEY_ID
fi

if [[ -z "$AWS_SECRET_ACCESS_KEY" ]]; then
  AWS_SECRET_ACCESS_KEY="$(crudini --get ~/.aws/credentials "octodns" aws_secret_access_key)"
  export AWS_SECRET_ACCESS_KEY
fi

if [[ -z "$AWS_ACCESS_KEY_ID" ]] || [[ -z "$AWS_SECRET_ACCESS_KEY" ]]; then
  echo "could not fetch AWS credentials for 'octodns' profile"
  exit 2
fi

cd octodns

if [[ -d venv ]]; then
  source venv/bin/activate
else
  virtualenv venv
  source venv/bin/activate
  pip install -r requirements-freeze.txt
fi

octodns-sync --config-file dns.yaml "$@"
