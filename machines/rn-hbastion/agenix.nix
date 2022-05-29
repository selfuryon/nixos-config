{ config, ... }: {
  # Agenix secret configuration
  age.secrets.rn-wireguard.file = ./secrets/wireguard.age;
}
