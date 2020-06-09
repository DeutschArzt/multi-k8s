docker build -t deutscharzt/multi-client:latest -t deutscharzt/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t deutscharzt/multi-server:latest -t deutscharzt/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t deutscharzt/multi-worker:latest -t deutscharzt/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push deutscharzt/multi-client:latest
docker push deutscharzt/multi-server:latest
docker push deutscharzt/multi-worker:latest

docker push deutscharzt/multi-client:$SHA
docker push deutscharzt/multi-server:$SHA
docker push deutscharzt/multi-worker:$SHA

kubectl apply -f k8s/
kubectl set image deployments/server-deployment server=deutscharzt/multi-server:$SHA
kubectl set image deployments/client-deployment client=deutscharzt/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=deutscharzt/multi-worker:$SHA