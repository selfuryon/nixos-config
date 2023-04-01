{
  # AM VPS
  deployment = {
    targetUser = "syakovlev";
    privilegeEscalationCommand = ["doas"];
    tags = ["vps"];
  };
}
