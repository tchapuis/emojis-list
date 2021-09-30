# Getting Started

## Start the project

Configuration
```bash
# copy the environment variable
$ cp .env.dist .env

# execute sql file into db container
$ docker-compose exec db -T db mysql -u {USERNAME} -p{DB_PASSWORD} smmdd {DB_NAME} < emojisList.sql
```

```bash
# install dependencies
$ npm install

# start docker-compose
$ docker-compose up

# serve with hot reload at localhost:3000
$ npm run dev

# build for production and launch server
$ npm run build
$ npm run start

# generate static project
$ npm run generate
```

For prisma check the doc
¯\_(ツ)_/¯

