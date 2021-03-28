#!/bin/bash

validate_return_code () {
    echo "aws cli return code: $1"
    if [[ $1 -gt 0 ]]
    then
        exit 1
    fi
}

echo "Validating template"
aws cloudformation validate-template --template-body file://$3.yml
validate_return_code $?

STACK_NAME="$1-$2-$3"

echo "Running command: aws cloudformation describe-stacks --stack-name $STACK_NAME"
aws cloudformation describe-stacks --stack-name "$STACK_NAME"
RETURN_CODE="$?"

echo "describe-stacks return code: $RETURN_CODE"

if [[ $RETURN_CODE -gt 0 ]]
then
    echo "Creating stack: $STACK_NAME"
    aws cloudformation create-stack --stack-name "$STACK_NAME" --template-body file://$3.yml --parameters ParameterKey=Environment,ParameterValue=$1 ParameterKey=AppName,ParameterValue=$2
    validate_return_code $?

    echo "Waiting for create command to complete"
    aws cloudformation wait stack-create-complete --stack-name "$STACK_NAME"
else
    echo "Updating stack: $STACK_NAME"
    aws cloudformation update-stack --stack-name "$STACK_NAME" --template-body file://$3.yml --parameters ParameterKey=Environment,ParameterValue=$1 ParameterKey=AppName,ParameterValue=$2
    validate_return_code $?

    echo "Waiting for update command to complete"
    aws cloudformation wait stack-update-complete --stack-name "$STACK_NAME"
fi