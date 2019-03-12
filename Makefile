mutate: test ## Run mutation tests
	@bundle exec mutant --include spec/ --require ./config/environment --use rspec -- 'ProjectManagement::Developer'

.PHONY: help test
.DEFAULT_GOAL := help
