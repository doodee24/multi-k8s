docker build -t doodee24/multi-client:latest -t doodee24/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t doodee24/multi-server:latest -t doodee24/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t doodee24/multi-worker:latest -t doodee24/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push doodee24/multi-client:latest
docker push doodee24/multi-server:latest
docker push doodee24/multi-worker:latest

docker push doodee24/multi-client:$SHA
docker push doodee24/multi-server:$SHA
docker push doodee24/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=doodee24/multi-server:$SHA
kubectl set image deployments/client-deployment client=doodee24/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=doodee24/multi-worker:$SHA
