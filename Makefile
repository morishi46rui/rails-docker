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
