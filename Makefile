.PHONY: migration/status
migration/status:
	go run -mod=mod ariga.io/atlas/cmd/atlas@master migrate status \
		--revisions-schema="migration_history" \
		--dir="file://migration" \
		--url="sqlite://main.db?_fk=1"

.PHONY: migration/run
migration/run:
	go run -mod=mod ariga.io/atlas/cmd/atlas@master migrate apply \
		--revisions-schema="migration_history" \
		--dir="file://migration" \
		--url="sqlite://main.db?_fk=1"

cleanup: main.db
	rm -f main.db
