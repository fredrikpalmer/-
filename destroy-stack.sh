#!/bin/bash

validate_return_code () {
    echo "aws cli return code: $1"
    if [[ $1 -gt 0 ]]
    then
        exit 1
    fi
}

STACK_NAME="$1-$2-$3"
aws cloudformation delete-stack --stack-name "$STACK_NAME"
validate_return_code $?

echo "Waiting for delete command to complete"
aws cloudformation wait stack-delete-complete --stack-name "$STACK_NAME"