DB_URL=postgresql://postgres:hoanganh@localhost:5433/simple_bank?sslmode=disable

postgres:
	docker run --name postgres -p 5433:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=hoanganh -d postgres:14-alpine

createdb:
	docker exec -it postgres createdb --username=postgres --owner=postgres simple_bank

dropdb:
	docker exec -it postgres dropdb --username=postgres simple_bank

migrateup:
	migrate -path db/migration -database "$(DB_URL)" -verbose up

migratedown:
	migrate -path db/migration -database "$(DB_URL)" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc