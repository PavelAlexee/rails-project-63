install:
	bundle install

console:
	bin/console

lint:
	bundle exec rubocop

lint-fix:
	bundle exec rubocop -A

test:
	bundle exec rspec

.PHONY: install console test lint lint-fix
	