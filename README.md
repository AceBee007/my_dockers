# my_dockers
To save my dockerfile and docker-compse.yml files

# BUILD
how to build

`docker build -f Dockerfile -t username/label:latest .`

if you have a proxy problem, try to use host network option

`docker build --network host -f Dockerfile -t username/label:latest .`
