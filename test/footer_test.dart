import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysite/app/sections/contact/contact_desktop.dart';
import 'package:mysite/app/widgets/footer.dart';
import 'package:mysite/app/widgets/social_icons.dart';
import 'package:mysite/changes/strings.dart';
import 'package:sizer/sizer.dart';

Widget _app(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

/// Pumps [ContactDesktop] at a desktop width (breakpoint starts at 1024 px).
Future<void> _pumpContactDesktop(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1400, 900);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: ContactDesktop()),
        ),
      ),
    ),
  );
  // Let the (failing, offline) image requests settle on the fallback icon.
  await tester.pump();
}

/// Nearest decorated ancestor of the icons row: the contact card itself.
Finder _card() => find
    .ancestor(
      of: find.byType(SocialIconsRow),
      matching: find.byType(DecoratedBox),
    )
    .first;

void main() {
  group('Footer', () {
    testWidgets('shows the copyright line with the current year',
        (WidgetTester tester) async {
      await tester.pumpWidget(_app(const Footer()));

      final String expected =
          'Made with Flutter Web by Hichem Benabadji © '
          '${DateTime.now().year}. All rights reserved.';
      final Iterable<String> lines = tester
          .widgetList<RichText>(find.byType(RichText))
          .map((RichText w) => w.text.toPlainText());

      expect(lines, isNotEmpty);
      expect(lines, everyElement(expected));
    });

    testWidgets('scrolls the line continuously to the left',
        (WidgetTester tester) async {
      await tester.pumpWidget(_app(const Footer()));

      double translation() => tester
          .widget<Transform>(find.byType(Transform).first)
          .transform
          .getTranslation()
          .x;

      final double before = translation();
      await tester.pump(const Duration(milliseconds: 500));
      final double after = translation();

      expect(after, lessThan(before));
    });
  });

  group('SocialIconsRow', () {
    testWidgets('renders the 7 networks, in order, in identical boxes',
        (WidgetTester tester) async {
      await tester.pumpWidget(_app(const SocialIconsRow()));
      // Let the (failing, offline) image requests settle on the fallback icon.
      await tester.pump();

      final Finder buttons = find.byType(SocialIconButton);
      expect(buttons, findsNWidgets(7));

      final List<String> names = tester
          .widgetList<SocialIconButton>(buttons)
          .map((SocialIconButton b) => b.item.name)
          .toList();
      expect(names, <String>[
        'LinkedIn',
        'GitHub',
        'Google Play Store',
        'YouTube',
        'X (Twitter)',
        'TikTok',
        'Instagram',
      ]);

      final SocialIconsRow row =
          tester.widget<SocialIconsRow>(find.byType(SocialIconsRow));
      expect(row.iconSize, 30);
      expect(row.boxSize, 56);

      double previousLeft = double.negativeInfinity;
      final double top = tester.getTopLeft(buttons.first).dy;
      for (int i = 0; i < 7; i++) {
        final Finder button = buttons.at(i);
        expect(tester.getSize(button), Size(row.boxSize, row.boxSize));
        final Offset topLeft = tester.getTopLeft(button);
        expect(topLeft.dx, greaterThan(previousLeft), reason: 'order of $i');
        expect(topLeft.dy, top, reason: 'single horizontal row');
        previousLeft = topLeft.dx;
      }
    });
  });

  group('ContactDesktop', () {
    testWidgets('centers the icons row between the separator and card bottom',
        (WidgetTester tester) async {
      await _pumpContactDesktop(tester);

      final Finder row = find.byType(SocialIconsRow);
      final Finder separator = find.byWidgetPredicate((Widget w) =>
          w is Container && w.color == Colors.white.withValues(alpha: 0.2));

      expect(row, findsOneWidget);
      expect(separator, findsOneWidget);

      final Rect rowRect = tester.getRect(row);
      final double spaceAbove = rowRect.top - tester.getRect(separator).bottom;
      final double spaceBelow = tester.getRect(_card()).bottom - rowRect.bottom;

      expect(spaceAbove, greaterThan(0));
      expect(spaceBelow, closeTo(spaceAbove, 0.5));
    });

    testWidgets('centers the heading block on the same axis as the icons',
        (WidgetTester tester) async {
      await _pumpContactDesktop(tester);

      final double axis = tester.getCenter(_card()).dx;
      final Finder heading = find.text(contactHeadding);
      final Finder subHeading = find.text(contactSubHeadding);

      expect(tester.getCenter(heading).dx, closeTo(axis, 0.5));
      expect(tester.getCenter(subHeading).dx, closeTo(axis, 0.5));
      expect(tester.getCenter(find.byType(SocialIconsRow)).dx,
          closeTo(axis, 0.5));

      // Only the real button is hit-testable; its invisible twin on the left
      // (used to balance the row) is not. The button must stay clear of the
      // text block.
      final Finder button = find
          .ancestor(
            of: find.text('Contact Me').hitTestable(),
            matching: find.byType(InkWell),
          )
          .first;
      expect(find.text('Contact Me').hitTestable(), findsOneWidget);
      expect(tester.getRect(button).left,
          greaterThan(tester.getRect(subHeading).right));
      expect(tester.getRect(button).right,
          closeTo(tester.getRect(_card()).right - 70, 0.5),
          reason: 'flush with the card content edge (5% of 1400 px padding)');
    });
  });
}
