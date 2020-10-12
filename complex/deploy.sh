docker build -t fescalhao/multi-client:latest -t fescalhao/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t fescalhao/multi-server:latest -t fescalhao/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t fescalhao/multi-worker:latest -t fescalhao/multi-worker:$SHA -f ./server/Dockerfile ./worker

docker push fescalhao/multi-client:latest
docker push fescalhao/multi-server:latest
docker push fescalhao/multi-worker:latest
docker push fescalhao/multi-client:$SHA
docker push fescalhao/multi-server:$SHA
docker push fescalhao/multi-worker:$SHA

kubectl apply -f ./k8s/deployments
kubectl apply -f ./k8s/cluster_ip_services
kubectl apply -f ./k8s/persistent_volume_claims
kubectl apply -f ./k8s/ingress_services

kubectl set image deployments/client-deployment server=fescalhao/multi-client:$SHA
kubectl set image deployments/server-deployment server=fescalhao/multi-server:$SHA
kubectl set image deployments/worker-deployment server=fescalhao/multi-worker:$SHA