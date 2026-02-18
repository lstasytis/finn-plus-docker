docker build \
  --build-arg USERNAME=$(whoami) \
  --build-arg UID=$(id -u) \
  --build-arg GID=$(id -g) \
  -t finn-plus-dev .

docker run -it \
    -v ~/finn-plus:/workspace \
    -v /mnt/labstore:/mnt/labstore \
    --name finn-plus-dev \
    finn-plus-dev

