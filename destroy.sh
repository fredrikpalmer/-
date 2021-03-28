#!/bin/bash

STACKS=("ecs-cluster" "loadbalancer" "security-groups" "network")

for stack in ${STACKS[@]}; do
    echo "Destroying stack: $stack"
    ./destroy-stack.sh "$1" "$2" "$stack" || exit 1;
done || exit 1