# Create AWS ECS cluster 
```
docker build -t ecs-stack .

docker run \
  -e AWS_ACCESS_KEY_ID=MyKey \ 
  -e AWS_SECRET_ACCESS_KEY=MySecretKey \
  -e AWS_REGION=eu-north-1 \
  ecs-stack "deploy" "dev" "app"
```
