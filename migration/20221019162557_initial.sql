-- create "todos" table
CREATE TABLE `todos` (`id` uuid NOT NULL, `text` text NOT NULL, `done` bool NOT NULL DEFAULT false, `updated_at` datetime NOT NULL, `created_at` datetime NOT NULL, `user_todos` uuid NOT NULL, PRIMARY KEY (`id`), CONSTRAINT `todos_users_todos` FOREIGN KEY (`user_todos`) REFERENCES `users` (`id`) ON DELETE NO ACTION);
-- create "users" table
CREATE TABLE `users` (`id` uuid NOT NULL, `name` text NOT NULL, `created_at` datetime NOT NULL, PRIMARY KEY (`id`));
