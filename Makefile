docker-build:
	docker build -t datavid19/backend .

docker-run: docker-build
	docker run --rm -p 8080:8080 datavid19/backend

publish: docker-build
	docker push datavid19/backend

redis:
	docker-compose up -d redis

postgres:
	docker-compose up -d postgres

install-shell:
	pip install pipenv --user

shell:
	pipenv shell

install-deps:
	pipenv install

local-redeploy:
	git pull; \
	docker stop datavid19-backend || true; \
	docker rm datavid19-backend || true; \
	docker-compose -f docker-compose.prod.yml up -d --build backend;

redeploy:
	git pull; \
	docker pull datavid19/backend:latest; \
	docker stop datavid19-backend || true; \
	docker rm datavid19-backend || true; \
	docker-compose -f docker-compose.prod.yml up -d backend;

logs:
	docker-compose -f docker-compose.prod.yml logs --follow backend;
