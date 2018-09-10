
LOCALDIR=`pwd`
IMAGE=quay.octanner.io/developer/bashir:latest
docker run --rm -v $LOCALDIR:/app  --env-file env.env  $IMAGE 
