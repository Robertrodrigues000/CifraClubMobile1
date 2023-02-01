import 'dart:async';

import 'package:cifraclub/presentation/widgets/filter_capsule/filter.dart';
import 'package:cifraclub/presentation/widgets/filter_capsule/filter_capsule_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_helpers/test_wrapper.dart';

void main() {
  testWidgets("when tapping a filter, expect its onTap callback to be called", (widgetTester) async {
    final completer = Completer<void>();
    final filters = [
      Filter(
        label: 'Todos',
        onTap: completer.complete,
        isSelected: false,
      ),
    ];

    await widgetTester.pumpWidget(
      TestWrapper(
        child: FilterCapsuleList(
          filters: filters,
        ),
      ),
    );

    await widgetTester.tap(
      find.byKey(
        Key(
          filters.first.label,
        ),
      ),
    );

    expect(completer.isCompleted, isTrue);
  });
}
