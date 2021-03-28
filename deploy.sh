#!/bin/bash

STACKS=("network" "security-groups" "loadbalancer" "ecs-cluster")

for stack in ${STACKS[@]}; do
    echo "Deploying stack: $stack"
    ./execute-command.sh "$1" "$2" "$stack";
done