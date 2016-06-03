gpg-agent --daemon --write-env-file ~/.gpg-agent-info > /dev/null 2>&1
eval (sed 's/^\(.*\)=\(.*\)$/set -x \1 \2/' ~/.gpg-agent-info)
