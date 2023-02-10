.PHONY: pub-get build-runner format prepare format-exiting-if-changed test coverage-result generate-localization ci

pub-get:
	flutter pub get

build-runner:
	flutter packages pub run build_runner build --delete-conflicting-outputs

format:
	dart format --line-length=200 lib test

prepare: pub-get build-runner format

format-exiting-if-changed:
	dart format --line-length=200 --set-exit-if-changed lib test

analyze:
	flutter analyze --no-pub .

test:
	dart ci/generate_coverage_helper.dart
	flutter test --no-pub --coverage

coverage-result:
	git diff origin/development | flutter pub run pull_request_coverage --minimum-coverage 97 --maximum-uncovered-lines 5
	flutter pub run dlcov --exclude-files $COVERAGE_EXCLUDE_FILES --exclude-suffix=$COVERAGE_EXCLUDE_FILES_SUFFIX

generate-localization:
	flutter gen-l10n

ci: generate-localization format-exiting-if-changed analyze test coverage-result
