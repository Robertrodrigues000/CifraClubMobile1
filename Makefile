.PHONY: pub-get build-runner format prepare format-exiting-if-changed test coverage-result generate-localization ci

pub-get:
	flutter pub get

build-runner:
	flutter packages pub run build_runner build --delete-conflicting-outputs

format:
	dart format --line-length=120 lib test

prepare: pub-get build-runner format

format-exiting-if-changed:
	dart format --line-length=120 --set-exit-if-changed lib test

analyze:
	flutter analyze --no-pub .

generate_coverage_helper:
	rm -rf test/coverage_helper_test.dart
	dart ci/generate_coverage_helper.dart

test:
	flutter test --no-pub --coverage

png-to-webp:
	find assets/images -name '*.png' | awk -F ".png" '{printf "%s\n", $$1}' | xargs -I% bash -c 'cwebp -q 80 %.png -o %.webp && rm %.png'

coverage-result:
	dart pub global activate pull_request_coverage 2.1.0
	git diff origin/development | pull_request_coverage
	flutter pub run dlcov --exclude-files $COVERAGE_EXCLUDE_FILES --exclude-suffix=$COVERAGE_EXCLUDE_FILES_SUFFIX

generate-localization:
	flutter gen-l10n

ci: generate-localization format generate_coverage_helper analyze test coverage-result
