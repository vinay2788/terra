package terraform.analysis

# Define a helper function with 'if'
allows_all_traffic(after) if {
    after.ip_protocol == "-1"
    after.cidr_ipv4 == "0.0.0.0/0"
}

allows_all_traffic(after) if {
    after.ip_protocol == "-1"
    after.cidr_ipv6 == "::/0"
}

deny[msg] if {
    rc := input.resource_changes[_]
    rc.type == "aws_vpc_security_group_ingress_rule"
    rc.change.actions[_] == "create"
    after := rc.change.after
    allows_all_traffic(after)
    msg := sprintf("Creating ingress rule %s that allows all traffic", [rc.address])
}

deny[msg] if {
    rc := input.resource_changes[_]
    rc.type == "aws_vpc_security_group_ingress_rule"
    rc.change.actions[_] == "update"
    after := rc.change.after
    allows_all_traffic(after)
    msg := sprintf("Updating ingress rule %s to allow all traffic", [rc.address])
}

deny[msg] if {
    rc := input.resource_changes[_]
    rc.type == "aws_vpc_security_group_egress_rule"
    rc.change.actions[_] == "create"
    after := rc.change.after
    allows_all_traffic(after)
    msg := sprintf("Creating egress rule %s that allows all traffic", [rc.address])
}

deny[msg] if {
    rc := input.resource_changes[_]
    rc.type == "aws_vpc_security_group_egress_rule"
    rc.change.actions[_] == "update"
    after := rc.change.after
    allows_all_traffic(after)
    msg := sprintf("Updating egress rule %s to allow all traffic", [rc.address])
}

allow if {
    count(deny) == 0
}
