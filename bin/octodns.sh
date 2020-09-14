#! /usr/bin/env nix-shell
#! nix-shell -i bash -p crudini "python3.withPackages (ps: [ps.virtualenv])"

if [[ -z "$AWS_ACCESS_KEY_ID" ]]; then
  export AWS_ACCESS_KEY_ID="$(crudini --get ~/.aws/credentials "octodns" aws_access_key_id)"
fi

if [[ -z "$AWS_SECRET_ACCESS_KEY" ]]; then
  export AWS_SECRET_ACCESS_KEY="$(crudini --get ~/.aws/credentials "octodns" aws_secret_access_key)"
fi

if [[ -z "$AWS_ACCESS_KEY_ID" ]] || [[ -z "$AWS_SECRET_ACCESS_KEY" ]]; then
  echo "could not fetch AWS credentials for 'octodns' profile"
  exit 2
fi

pushd octodns &>/dev/null

if [[ -d venv ]]; then
  source venv/bin/activate || exit 1
else
  virtualenv venv || exit 1
  source venv/bin/activate || exit 1
  pip install -r requirements-freeze.txt || exit 1
fi

octodns-sync --config-file dns.yaml "$@"
