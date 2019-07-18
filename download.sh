USERNAME=dparlevliet

mkdir -p ~/.ssh

if ! [[ -f ~/.ssh/authorized_keys ]]; then
  echo "Creating new ~/.ssh/authorized_keys"
  touch ~/.ssh/authorized_keys
  chmod 664 ~/.ssh/authorized_keys
fi

keys=$(curl https://api.github.com/users/$USERNAME/keys | grep "ssh-" | sed 's/"key": "//g' | sed 's/"//g' | sed -E 's/    //g')

echo "" > ~/.ssh/authorized_keys
while read -r key; do
  echo $key
  grep -q "$key" ~/.ssh/authorized_keys || echo "$key" >> ~/.ssh/authorized_keys
done <<< $keys
echo "" >> ~/.ssh/authorized_keys # fix for ssh read bug
