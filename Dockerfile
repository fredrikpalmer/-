FROM amazon/aws-cli:2.1.32

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_REGION

RUN aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
RUN aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
RUN aws configure set region ${AWS_REGION}

COPY deploy.sh .
RUN chmod +x deploy.sh

COPY execute-command.sh .
RUN chmod +x execute-command.sh

COPY . .

ENTRYPOINT [ "./deploy.sh" ] 