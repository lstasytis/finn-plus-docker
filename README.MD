Self-contained scripts to generate a docker container with finn-plus installed using poetry.


to build and start the container:

``git clone https://github.com/eki-project/finn-plus.git``

``cp startup.sh finn-plus/``

``cp run.sh finn-plus/``

``./docker_start.sh``


inside the container:

``poetry install``

``poetry add --dev "pathspec==0.10.3"``

``poetry add --dev "dvc[webdav]==3.59.1"``


env variables setup:

``./startup.sh``

if using finn-examples:

``dvc pull``


example run:
``./run.sh``
