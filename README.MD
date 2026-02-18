Self-contained scripts to generate a docker container with finn-plus installed using poetry.


to build and start the container:
git clone https://github.com/eki-project/finn-plus.git
cp startup.sh finn-plus/
cp run.sh finn-plus/
./docker_start.sh

inside the container:
env variables setup:
./startup.sh

if using finn-examples:
dvc pull


example run:
./run.sh
