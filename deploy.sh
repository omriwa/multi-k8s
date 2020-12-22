docker build -t omriwallach/multi-client:latest -t omriwallach/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t omriwallach/multi-server:latest -t omriwallach/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t omriwallach/multi-worker:latest -t omriwallach/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# push
docker push omriwallach/multi-client:latest
docker push omriwallach/multi-server:latest
docker push omriwallach/multi-worker:latest

docker push omriwallach/multi-client:$SHA
docker push omriwallach/multi-server:$SHA
docker push omriwallach/multi-worker:$SHA

# k8s
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=omriwallach/multi-server:$SHA
kubectl set image deployments/client-deployment client=omriwallach/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=omriwallach/multi-worker:$SHA
