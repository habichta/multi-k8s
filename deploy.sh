docker build -t habichta/multi-client:latest -t habichta/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t habichta/multi-server:latest -t habichta/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t habichta/multi-worker:latest -t habichta/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push habichta/multi-client:latest
docker push habichta/multi-server:latest
docker push habichta/multi-worker:latest

docker push habichta/multi-client:$SHA
docker push habichta/multi-server:$SHA
docker push habichta/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/client-deployment client=habichta/multi-client:$SHA
kubectl set image deployments/server-deployment server=habichta/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=habichta/multi-worker:$SHA