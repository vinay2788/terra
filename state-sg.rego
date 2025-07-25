package terraform.analysis

deny[msg] {
  some sg
  sg = input.resources[_]
  sg.type == "aws_security_group"
  some instance
  instance = sg.instances[_]
  some rule
  rule = instance.attributes.ingress[_]
  rule.from_port == 0
  rule.to_port == 0
  rule.protocol == "-1"
  some cidr
  cidr = rule.cidr_blocks[_]
  cidr == "0.0.0.0/0"
  msg = sprintf("Security group %s currently allows all traffic", [sg.name])
}