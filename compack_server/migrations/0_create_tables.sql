CREATE TABLE IF NOT EXISTS "Account" (
  "id" text NOT NULL,
  "email" text NULL,
  "phone" text NULL,
  "password" text NULL,
  "role" int8 NULL,
  "token" text NULL,
  "refresh_token" text NULL,
  "time_created" int8 NULL,
  "last_logon_time" int8 NULL
);