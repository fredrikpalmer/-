# Create AWS ECS cluster 
```
docker build -t ecs-deploy \ 
  --build-arg AWS_ACCESS_KEY_ID=MyKey \
  --build-arg AWS_SECRET_ACCESS_KEY=MySecretKey \
  --build-arg AWS_REGION=eu-north-1 .

docker run ecs-deploy "deploy" "dev" "app"
```
