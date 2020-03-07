docker build -t timramone/client:latest -t timramone/client:$SHA -f ./client/Dockerfile ./client
docker build -t timramone/server:latest -t timramone/server:$SHA -f ./server/Dockerfile ./server
docker build -t timramone/worker:latest -t timramone/worker:$SHA -f ./worker/Dockerfile ./worker

docker push timramone/client:latest 
docker push timramone/server:latest 
docker push timramone/worker:latest 

docker push timramone/client:$SHA 
docker push timramone/server:$SHA 
docker push timramone/worker:$SHA 

kubectl apply -f ./k8s
kubectl set image deployments/client-deployment client=timramone/client:$SHA
kubectl set image deployments/server-deployment server=timramone/server:$SHA
kubectl set image deployments/worker-deployment worker=timramone/worker:$SHA