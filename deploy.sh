docker build -t ashirahraj09/multi-client:latest -t ashirahraj09/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ashirahraj09/multi-server:latest -t ashirahraj09/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ashirahraj09/multi-worker:latest -t ashirahraj09/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ashirahraj09/multi-client:latest
docker push ashirahraj09/multi-server:latest
docker push ashirahraj09/multi-worker:latest

docker push ashirahraj09/multi-client:$SHA
docker push ashirahraj09/multi-server:$SHA
docker push ashirahraj09/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ashirahraj09/multi-server:$SHA
kubectl set image deployments/client-deployment client=ashirahraj09/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ashirahraj09/multi-worker:$SHA