// knexfile.ts

import { Knex } from 'knex';

const config: { [key: string]: Knex.Config } = {
  development: {
    client: 'pg',
    connection: {
      host: '127.0.0.1',
      user: 'winballuser',
      password: 'winballpw',
      database: 'winballdb'
    },
    migrations: {
      directory: './migrations'
    }
  },
  production: {
    client: 'pg',
    connection: {
      host: 'localhost',
      port: 5433,
      user: 'winballuser',
      password: 'winballpw',
      database: 'winballdb'
    },
    migrations: {
      directory: './migrations'
    }
  }
};

export default config;
