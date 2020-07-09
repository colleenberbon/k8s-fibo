docker build -t colleenberbon/gc-multi-client:latest -t colleenberbon/gc-multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t colleenberbon/gc-multi-api:latest -t colleenberbon/gc-multi-api:$SHA -f ./server/Dockerfile ./server
docker build -t colleenberbon/gc-multi-worker:latest -t colleenberbon/gc-multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push colleenberbon/gc-multi-client:latest
docker push colleenberbon/gc-multi-api:latest
docker push colleenberbon/gc-multi-worker:latest
docker push colleenberbon/gc-multi-client:$SHA
docker push colleenberbon/gc-multi-api:$SHA
docker push colleenberbon/gc-multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=colleenberbon/gc-multi-client:$SHA
kubectl set image deployments/server-deployment server=colleenberbon/gc-multi-api:$SHA
kubectl set image deployments/worker-deployment worker=colleenberbon/gc-multi-worker:$SHA

