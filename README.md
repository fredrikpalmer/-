# Create AWS ECS cluster 
```
docker build \ 
  --build-arg AWS_ACCESS_KEY_ID=MyKey \
  --build-arg AWS_SECRET_ACCESS_KEY=MySecretKey \
  --build-arg AWS_REGION=eu-north-1 \
  --build-arg Environment=dev \
  --build-arg APP_NAME=app .
```
