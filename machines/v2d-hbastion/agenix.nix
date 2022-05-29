{ config, ... }: {
  # Agenix secret configuration
  age.secrets.v2d-wireguard.file = ./secrets/wireguard.age;
}
