{ config, ... }: {
  # Agenix secret configuration
  age.secrets.sb-wireguard.file = ./secrets/wireguard.age;
}
