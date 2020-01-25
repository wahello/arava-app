#!/usr/bin/env bash

if [[ $1 == "codegen" ]]
then
   flutter pub run build_runner build --delete-conflicting-outputs
   exit 0
fi

if [[ $1 == "intl" ]]
then
   flutter pub run intl_translation:extract_to_arb --output-dir lib/i18n lib/i18n/localizations.dart
   flutter pub run intl_translation:generate_from_arb --output-dir=lib/i18n --no-use-deferred-loading lib/i18n/localizations.dart lib/i18n/intl_en.arb lib/i18n/intl_fr.arb lib/i18n/intl_zh_Hans.arb
   exit 0
fi

echo "Available commands intl | codegen"
exit 1