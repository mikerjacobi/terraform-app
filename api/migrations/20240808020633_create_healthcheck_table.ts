// migrations/<timestamp>_create_healthcheck_table.ts

import { Knex } from 'knex';

export async function up(knex: Knex): Promise<void> {
  const exists = await knex.schema.hasTable('healthcheck');
  if (!exists) {
    return knex.schema.createTable('healthcheck', table => {
      table.increments('id').primary();
      table.timestamp('timestamp').defaultTo(knex.fn.now());
    });
  }
}

export async function down(knex: Knex): Promise<void> {
  return knex.schema.dropTableIfExists('healthcheck');
}
