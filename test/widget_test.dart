import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:partnership/coordinator/AppCoordinator.dart';
import 'package:partnership/ui/LoginPage.dart';
import 'package:partnership/ui/widgets/RoundedGradientButton.dart';

void main() {
  testWidgets('Vérifcation du boutton co', (WidgetTester tester) async {
    await tester.pumpWidget(PartnershipApp());
    expect(find.byType(RoundedGradientButton), findsNothing);
  });
}
