package terraform.analysis

deny[msg] {
  some change
  change = input.resource_changes[_]
  startswith(change.address, "aws_security_group.")
  change.change.after.ingress[_].from_port == 0
  change.change.after.ingress[_].to_port == 0
  change.change.after.ingress[_].protocol == "-1"
  change.change.after.ingress[_].cidr_blocks[_] == "0.0.0.0/0"
  msg = sprintf("Proposed change to security group %s would allow all traffic", [change.address])
}