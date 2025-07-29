package terraform.analysis

# IPv4 allow‐all
allows_all(after) if {
    after.ip_protocol == "-1"
    after.cidr_ipv4  == "0.0.0.0/0"
}

# IPv6 allow‐all
allows_all(after) if {
    after.ip_protocol == "-1"
    after.cidr_ipv6  == "::/0"
}

# Deny any ingress‐rule in state that allows all traffic
deny[msg] if {
    res := input.values.root_module.resources[_]
    res.type == "aws_vpc_security_group_ingress_rule"
    allows_all(res.values)
    msg := sprintf("State ingress rule %s allows all traffic", [res.address])
}

# Deny any egress‐rule in state that allows all traffic
deny[msg] if {
    res := input.values.root_module.resources[_]
    res.type == "aws_vpc_security_group_egress_rule"
    allows_all(res.values)
    msg := sprintf("State egress rule %s allows all traffic", [res.address])
}

