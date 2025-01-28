build:
	docker compose build

buildn:
	docker compose build --no-cache

up:
	docker compose up

upd:
	docker compose up -d

re:
	docker compose restart

down:
	docker compose down --remove-orphans

logs:
	docker compose logs -f

b:
	docker compose exec backend bash

modb:
	docker compose run backend bash -c "bundle install"

test:
	docker compose run backend bash -c "RAILS_ENV=test bundle exec rspec"

swagger:
	docker compose run backend bash -c "RAILS_ENV=test bundle exec rake rswag:specs:swaggerize"
