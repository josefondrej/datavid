# DataVID-19
![CI/CD](https://github.com/tomaskourim/datavid/workflows/CI/CD/badge.svg)

Server IP - 134.209.241.50

## Versioning
Application provides endpoint `/version` which shows sha of the commit it is running.
```bash
> curl 134.209.241.50:8080/version
{"version":"47ddbd82b6825a3952b0a382d68f0b393a3978f9"}
```

## Deployment
- application is published to Docker Hub on each commit to master with image
```bash
datavid19/backend
```
- on publish, hook to our server is activated and the [deployment server](https://github.com/LukasForst/hook-deployment-server)
deploys this application using following script
```makefile
redeploy:
	git pull; \
	docker pull datavid19/backend:latest; \
	docker stop datavid19-backend || true; \
	docker rm datavid19-backend || true; \
	docker-compose -f docker-compose.prod.yml up -d backend;
```

## Runtime
- docker-compose runtime with [prod](docker-compose.prod.yml) yaml
- application is running on the server on the port `8080`
- application home directory is `/lukasapp/backend`

- deployment server is running on the port `8081`
- deployment server home directory is `/lukasapp/devops`

## Databases
Databases are not exposed to the outer internet. (yet)

## Local development
One should develop python app locally on the bare metal. 
To start the databases, one can execute `docker-compose up` to start postgres and redis. 
Database credentials are in [.env.compose](.env.compose) file.

### Dev stack:
Using `pipenv` as dependency management tool.

- [Flask](https://github.com/pallets/flask) - development server and facade
- [gunicorn](https://github.com/benoitc/gunicorn) - production server
- [flask-restx](https://github.com/python-restx/flask-restx) - requests processing, swagger
- [requests](https://github.com/psf/requests) - sending HTTP requests to Roman/Bot
- [redis](https://github.com/andymccurdy/redis-py) - storage for information about bots and services
- [dacite](https://github.com/konradhalas/dacite) - simple Dataclass parsing from JSON
