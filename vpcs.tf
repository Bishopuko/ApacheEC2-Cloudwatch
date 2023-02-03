resource "aws_vpc" "task" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"
     tags = {
       "name" : "TaskVPC"
    }
}

resource "aws_subnet" "Pub-Subnet" {
    vpc_id = aws_vpc.task.id
    cidr_block = "10.0.0.0/28"
     tags = {
      "name" : "task1"
    }
}

resource "aws_subnet" "Pub-Subnet2" {
    vpc_id = aws_vpc.task.id
    cidr_block = "10.0.0.16/28"
     tags = {
      "name" : "task2"
    }
}

resource "aws_internet_gateway" "GW" {
    vpc_id = aws_vpc.task.id
    tags = {
        "name" : "Gateway-1"
    }
}

resource "aws_route_table" "RT" {
    vpc_id = aws_vpc.task.id
    route {
        cidr_block = "0.0.0.0/24"
        gateway_id = aws_internet_gateway.GW.id
    }
    tags = {
        "name" : "Route-1"
    }
}
resource "aws_route_table_association" "RT-Associate" {
    subnet_id = aws_subnet.Pub-Subnet.id
    route_table_id = aws_route_table.RT.id
}
resource "aws_route_table_association" "RT-Associate2" {
    subnet_id = aws_subnet.Pub-Subnet2.id
    route_table_id = aws_route_table.RT.id
}







resource "aws_subnet" "Pri-Subnet" {
    vpc_id = aws_vpc.task.id
    cidr_block = "10.0.0.32/28"
    tags = {
      "name" : "task3"
    }
}
resource "aws_subnet" "Pri-Subnet2" {
    vpc_id = aws_vpc.task.id
    cidr_block = "10.0.0.48/28"
     tags = {
      "name" : "task4"
    }
}

resource "aws_eip" "Elastic1" {
    vpc = true
    tags = {
      "name" : "Elastic-1"
    }
}
resource "aws_nat_gateway" "NAT-GW" {
    allocation_id = aws_eip.Elastic1.id
    subnet_id = aws_subnet.Pub-Subnet.id
    tags = {
      "name" : "NAT_GW"
    }
}
resource "aws_route_table" "Pri-Route" {
    vpc_id = aws_vpc.task.id
    route  {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.NAT-GW.id
    }
}
resource "aws_route_table_association" "Private1" {
    subnet_id = aws_subnet.Pri-Subnet.id
    route_table_id = aws_route_table.Pri-Route.id
    
}
resource "aws_route_table_association" "Private2" {
    subnet_id = aws_subnet.Pri-Subnet2.id
    route_table_id = aws_route_table.Pri-Route.id
    
}
