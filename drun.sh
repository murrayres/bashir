
LOCALDIR=`pwd`
IMAGE=quay.octanner.io/developer/bashir:latest
docker run --rm -v $LOCALDIR:/app  -e APP_PATH=$2 -e APP_ENV=$1 $IMAGE 
