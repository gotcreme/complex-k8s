docker build -t vovadykun/complex-client:latest -t vovadykun/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t vovadykun/complex-server:latest -t vovadykun/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t vovadykun/complex-worker:latest -t vovadykun/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push vovadykun/complex-client:latest
docker push vovadykun/complex-server:latest
docker push vovadykun/complex-worker:latest

docker push vovadykun/complex-client:$SHA
docker push vovadykun/complex-server:$SHA
docker push vovadykun/complex-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=vovadykun/complex-client:$SHA
kubectl set image deployments/server-deployment server=vovadykun/complex-server:$SHA
kubectl set image deployments/worker-deployment worker=vovadykun/complex-worker:$SHA