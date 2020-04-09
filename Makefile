docker-build:
	docker build -t datavid19/backend .

docker-run: docker-build
	docker run --rm -p 8080:8080 datavid19/backend

publish: docker-build
	docker push datavid19/backend

db:
	docker-compose up -d redis

up:
	docker-compose up

install-shell:
	pip install pipenv --user

shell:
	pipenv shell

install-deps:
	pipenv install

local-build:
	docker stop datavid19-backend || true; \
	docker rm datavid19-backend || true; \
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d --build backend;

restart:
	docker pull datavid19/backend:latest; \
	docker stop datavid19-backend || true; \
	docker rm datavid19-backend || true; \
	docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d backend;

logs:
	docker-compose logs --follow backend;
