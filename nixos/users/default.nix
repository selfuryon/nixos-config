{users, ...}: {
  imports = [
    users.syakovlev.default
  ];
  users.users.root = {
    hashedPassword = "$6$skRJZuaIN8S0Ohgf$UwgLyx9DGZ8acjl/EwsaEnecPSZAwAwp42NS449CQpoLaGZKK7uo2GdiF0Tl6eMfIg6gxz5Rb6rudC34r5V0C/";
    openssh.authorizedKeys.keyFiles = [./syakovlev/keys.pub];
  };
}
