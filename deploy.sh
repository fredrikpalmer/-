#!/bin/bash

STACKS=("network" "security-groups" "loadbalancer" "ecs-cluster")

for stack in ${STACKS[@]}; do
    echo "Deploying stack: $stack"
    ./deploy-stack.sh "$1" "$2" "$stack" || exit 1;
done || exit 1