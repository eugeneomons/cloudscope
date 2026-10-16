#!/bin/bash

dnf update -y

dnf install git python3 python3-pip -y

echo "CloudScope bootstrap completed" > /tmp/cloudscope-bootstrap.log