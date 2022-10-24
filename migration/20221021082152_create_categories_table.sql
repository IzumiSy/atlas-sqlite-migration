-- create "categories" table
CREATE TABLE `categories` (`id` uuid NOT NULL, `name` text NOT NULL, `created_at` datetime NOT NULL, PRIMARY KEY (`id`));
-- create "category_todos" table
CREATE TABLE `category_todos` (`category_id` uuid NOT NULL, `todo_id` uuid NOT NULL, PRIMARY KEY (`category_id`, `todo_id`), CONSTRAINT `category_todos_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE, CONSTRAINT `category_todos_todo_id` FOREIGN KEY (`todo_id`) REFERENCES `todos` (`id`) ON DELETE CASCADE);
