echo "building client"
docker build -t timramone/client:latest -t timramone/client:$SHA -f ./client/Dockerfile ./client
echo "building server"
docker build -t timramone/server:latest -t timramone/server:$SHA -f ./server/Dockerfile ./server
echo "building worker"
docker build -t timramone/worker:latest -t timramone/worker:$SHA -f ./worker/Dockerfile ./worker

echo "pushing client latest"
docker push timramone/client:latest 
echo "pushing server latest"
docker push timramone/server:latest 
echo "pushing worker latest"
docker push timramone/worker:latest 

echo "pushing client $SHA"
docker push timramone/client:$SHA 
echo "pushing server $SHA"
docker push timramone/server:$SHA 
echo "pushing worker $SHA"
docker push timramone/worker:$SHA 

echo "applying k8s"
kubectl apply -f ./k8s
echo "setting client image"
kubectl set image deployments/client-deployment client=timramone/client:$SHA
echo "setting server image"
kubectl set image deployments/server-deployment server=timramone/server:$SHA
echo "setting worker image"
kubectl set image deployments/worker-deployment worker=timramone/worker:$SHA