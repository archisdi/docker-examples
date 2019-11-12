docker build -t archisdi/multi-client:latest -t archisdi/multi-client:$SHA -f ./kubernetes/complexk8/client/Dockerfile ./kubernetes/complexk8/client
docker build -t archisdi/multi-server:latest -t archisdi/multi-server:$SHA -f ./kubernetes/complexk8/server/Dockerfile ./kubernetes/complexk8/server
docker build -t archisdi/multi-worker:latest -t archisdi/multi-worker:$SHA -f ./kubernetes/complexk8/worker/Dockerfile ./kubernetes/complexk8/worker

docker push archisdi/multi-client:latest
docker push archisdi/multi-server:latest
docker push archisdi/multi-worker:latest

docker push archisdi/multi-client:$SHA
docker push archisdi/multi-server:$SHA
docker push archisdi/multi-worker:$SHA

kubectl apply -f ./kubernetes/complexk8/k8s

kubectl set image deployment/multi-client-deployment client=archisdi/multi-client:$SHA
kubectl set image deployment/multi-server-deployment server=archisdi/multi-server:$SHA
kubectl set image deployment/multi-worker-deployment worker=archisdi/multi-worker:$SHA