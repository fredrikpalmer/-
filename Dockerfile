FROM amazon/aws-cli:2.1.32

COPY commander.sh .
RUN chmod +x commander.sh

COPY deploy.sh .
RUN chmod +x deploy.sh

COPY deploy-stack.sh .
RUN chmod +x deploy-stack.sh

COPY destroy.sh .
RUN chmod +x destroy.sh

COPY destroy-stack.sh .
RUN chmod +x destroy-stack.sh

COPY . .

ENTRYPOINT [ "./commander.sh" ] 