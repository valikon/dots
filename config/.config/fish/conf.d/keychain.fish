set -Ua SSH_KEYS_TO_AUTOLOAD ~/.ssh/github_id

if status is-interactive
    keychain --eval $SSH_KEYS_TO_AUTOLOAD | source
end
