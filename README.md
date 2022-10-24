# How to reproduce
Check migration status beforehand.

```bash
make migration/status
go run -mod=mod ariga.io/atlas/cmd/atlas@master migrate status \
        --revisions-schema="migration_history" \
        --dir="file://migration" \
        --url="sqlite://main.db?_fk=1"
Migration Status: PENDING
  -- Current Version: No migration applied yet
  -- Next Version:    20221019162557
  -- Executed Files:  0
  -- Pending Files:   2
```

Run migration then.

```bash
$ make migration/run
go run -mod=mod ariga.io/atlas/cmd/atlas@master migrate apply \
        --revisions-schema="migration_history" \
        --dir="file://migration" \
        --url="sqlite://main.db?_fk=1"
Migrating to version 20221021082152 (2 migrations in total):

  -- migrating version 20221019162557
    -> CREATE TABLE `todos` (`id` uuid NOT NULL, `text` text NOT NULL, `done` bool NOT NULL DEFAULT false, `updated_at` datetime NOT NULL, `created_at` datetime NOT NULL, `user_todos` uuid NOT NULL, PRIMARY KEY (`id`), CONSTRAINT `todos_users_todos` FOREIGN KEY (`user_todos`) REFERENCES `users` (`id`) ON DELETE NO ACTION);
    -> CREATE TABLE `users` (`id` uuid NOT NULL, `name` text NOT NULL, `created_at` datetime NOT NULL, PRIMARY KEY (`id`));
  -- ok (130.980649ms)

  -- migrating version 20221021082152
    -> CREATE TABLE `categories` (`id` uuid NOT NULL, `name` text NOT NULL, `created_at` datetime NOT NULL, PRIMARY KEY (`id`));
    -> CREATE TABLE `category_todos` (`category_id` uuid NOT NULL, `todo_id` uuid NOT NULL, PRIMARY KEY (`category_id`, `todo_id`), CONSTRAINT `category_todos_category_id` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE, CONSTRAINT `category_todos_todo_id` FOREIGN KEY (`todo_id`) REFERENCES `todos` (`id`) ON DELETE CASCADE);
  -- ok (176.833662ms)

  -------------------------
  -- 309.091529ms
  -- 2 migrations
  -- 4 sql statements
```

Try migrating again to see no migration available anymore

```bash
$ make migration/run
go run -mod=mod ariga.io/atlas/cmd/atlas@master migrate apply \
        --revisions-schema="migration_history" \
        --dir="file://migration" \
        --url="sqlite://main.db?_fk=1"
No migration files to execute
```

See migration status again, then it unexpectedly says that there are pending migrations, even though we cannot run migration again.

```bash
make migration/status
go run -mod=mod ariga.io/atlas/cmd/atlas@master migrate status \
        --revisions-schema="migration_history" \
        --dir="file://migration" \
        --url="sqlite://main.db?_fk=1"
Migration Status: PENDING
  -- Current Version: No migration applied yet
  -- Next Version:    20221019162557
  -- Executed Files:  0
  -- Pending Files:   2
```
