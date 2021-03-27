FROM amazon/aws-cli:2.1.32 as aws-configure

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_REGION

RUN aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
RUN aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
RUN aws configure set aws_region ${AWS_REGION}

COPY execute-command.sh .
RUN chmod +x execute-command.sh

FROM aws-configure as network-stack
COPY --from=aws-configure . .

ARG APP_NAME
ARG Environment

COPY network.yml .
RUN ./execute-command.sh "${Environment}" "${APP_NAME}" "network"

FROM network-stack as security-groups-stack
COPY --from=aws-configure . .

ARG APP_NAME
ARG Environment

COPY security-groups.yml .
RUN ./execute-command.sh "${Environment}" "${APP_NAME}" "security-groups"

FROM security-groups-stack as loadbalancer-stack
COPY --from=aws-configure . .

ARG APP_NAME
ARG Environment

COPY loadbalancer.yml .
RUN ./execute-command.sh "${Environment}" "${APP_NAME}" "loadbalancer"

FROM loadbalancer-stack as ecs-cluster-stack
COPY --from=aws-configure . .

ARG APP_NAME
ARG Environment

ADD ecs-cluster.yml .
RUN ./execute-command.sh "${Environment}" "${APP_NAME}" "ecs-cluster"