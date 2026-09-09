import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fsuper/fsuper.dart';

/// Collects every background colour FControl actually paints, so assertions are
/// made against the rendered result rather than against FSuper's own fields.
List<Color?> paintedBackgroundColors(WidgetTester tester) {
  return tester
      .widgetList<Container>(find.byType(Container))
      .map((c) => c.decoration)
      .whereType<ShapeDecoration>()
      .map((d) => d.color)
      .toList();
}

/// The RichText that renders FSuper's `text` / `spans`.
RichText findTextPart(WidgetTester tester) {
  final candidates = tester.widgetList<RichText>(find.byType(RichText));
  expect(candidates, isNotEmpty, reason: 'FSuper should render a RichText');
  return candidates.first;
}

Widget host(Widget child) => MaterialApp(
      home: Scaffold(body: Center(child: child)),
    );

void main() {
  group('maxLines / overflow (#6)', () {
    testWidgets('are forwarded to the rendered text', (tester) async {
      await tester.pumpWidget(host(FSuper(
        width: 200,
        height: 40,
        text: 'a rather long piece of text that cannot fit',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )));
      await tester.pumpAndSettle();

      final rich = findTextPart(tester);
      expect(rich.maxLines, 1);
      expect(rich.overflow, TextOverflow.ellipsis);
    });

    testWidgets('default to the pre-2.2.0 behaviour (unlimited, clip)',
        (tester) async {
      await tester.pumpWidget(host(FSuper(
        width: 200,
        height: 40,
        text: 'short',
      )));
      await tester.pumpAndSettle();

      final rich = findTextPart(tester);
      // Before 2.2.0 neither argument was passed at all, so RichText's own
      // defaults applied: maxLines == null and overflow == TextOverflow.clip.
      expect(rich.maxLines, isNull);
      expect(rich.overflow, TextOverflow.clip);
    });

    testWidgets('every TextOverflow value is passed through unchanged',
        (tester) async {
      for (final o in TextOverflow.values) {
        await tester.pumpWidget(host(FSuper(
          width: 200,
          height: 40,
          text: 'x',
          maxLines: 2,
          overflow: o,
        )));
        await tester.pumpAndSettle();
        expect(findTextPart(tester).overflow, o, reason: 'overflow: $o');
        expect(findTextPart(tester).maxLines, 2, reason: 'overflow: $o');
      }
    });

    testWidgets('long text constrained to one line does not overflow the box',
        (tester) async {
      await tester.pumpWidget(host(FSuper(
        width: 120,
        height: 30,
        text: 'this text is far too long to fit inside one hundred and '
            'twenty logical pixels on a single line',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )));
      await tester.pumpAndSettle();

      // A layout overflow surfaces as an exception during pump.
      expect(tester.takeException(), isNull);
      final size = tester.getSize(find.byType(FSuper));
      expect(size.width, 120);
      expect(size.height, 30);
    });

    testWidgets('spans are still rendered alongside maxLines', (tester) async {
      await tester.pumpWidget(host(FSuper(
        width: 200,
        height: 40,
        text: 'prefix ',
        spans: [TextSpan(text: 'suffix')],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )));
      await tester.pumpAndSettle();

      final rich = findTextPart(tester);
      expect(rich.maxLines, 1);
      // `Text.rich(span)` wraps the supplied span as the single child of a root
      // TextSpan whose own `text` is null, so unwrap one level.
      final root = rich.text as TextSpan;
      expect(root.children?.length, 1);
      final supplied = root.children!.first as TextSpan;
      expect(supplied.text, 'prefix ');
      expect(supplied.children?.length, 1);
      expect((supplied.children!.first as TextSpan).text, 'suffix');
    });
  });

  group('pressedColor (#16)', () {
    const bg = Color(0xFF00FF00);
    const pressed = Color(0xFFFF0000);

    testWidgets('tap-down paints pressedColor, tap-up restores background',
        (tester) async {
      await tester.pumpWidget(host(FSuper(
        width: 100,
        height: 40,
        text: 'tap',
        backgroundColor: bg,
        pressedColor: pressed,
      )));
      await tester.pumpAndSettle();

      expect(paintedBackgroundColors(tester), contains(bg),
          reason: 'resting state should show backgroundColor');
      expect(paintedBackgroundColors(tester), isNot(contains(pressed)));

      final gesture =
          await tester.startGesture(tester.getCenter(find.byType(FSuper)));
      await tester.pumpAndSettle();
      expect(paintedBackgroundColors(tester), contains(pressed),
          reason: 'while held down the pressed colour must be painted');

      await gesture.up();
      await tester.pumpAndSettle();
      expect(paintedBackgroundColors(tester), contains(bg),
          reason: 'after release the background colour must come back');
      expect(paintedBackgroundColors(tester), isNot(contains(pressed)));
    });

    testWidgets('tap-cancel also restores the background colour',
        (tester) async {
      await tester.pumpWidget(host(FSuper(
        width: 100,
        height: 40,
        text: 'tap',
        backgroundColor: bg,
        pressedColor: pressed,
      )));
      await tester.pumpAndSettle();

      final gesture =
          await tester.startGesture(tester.getCenter(find.byType(FSuper)));
      await tester.pumpAndSettle();
      expect(paintedBackgroundColors(tester), contains(pressed));

      await gesture.cancel();
      await tester.pumpAndSettle();
      expect(paintedBackgroundColors(tester), contains(bg),
          reason: 'a cancelled tap must not leave the widget stuck highlighted');
      expect(paintedBackgroundColors(tester), isNot(contains(pressed)));
    });

    testWidgets('REGRESSION: onClick still fires when pressedColor is set',
        (tester) async {
      var clicks = 0;
      await tester.pumpWidget(host(FSuper(
        width: 100,
        height: 40,
        text: 'tap',
        backgroundColor: bg,
        pressedColor: pressed,
        onClick: () => clicks++,
      )));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FSuper));
      await tester.pumpAndSettle();
      expect(clicks, 1,
          reason: 'press feedback must not steal the tap from onClick');
    });

    testWidgets('REGRESSION: onClick fires without pressedColor (unchanged)',
        (tester) async {
      var clicks = 0;
      await tester.pumpWidget(host(FSuper(
        width: 100,
        height: 40,
        text: 'tap',
        backgroundColor: bg,
        onClick: () => clicks++,
      )));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FSuper));
      await tester.pumpAndSettle();
      expect(clicks, 1);
    });

    testWidgets('REGRESSION: no pressedColor means no highlight at all',
        (tester) async {
      await tester.pumpWidget(host(FSuper(
        width: 100,
        height: 40,
        text: 'tap',
        backgroundColor: bg,
      )));
      await tester.pumpAndSettle();

      final gesture =
          await tester.startGesture(tester.getCenter(find.byType(FSuper)));
      await tester.pumpAndSettle();
      expect(paintedBackgroundColors(tester), contains(bg),
          reason: 'without pressedColor the resting colour must not change');

      await gesture.up();
      await tester.pumpAndSettle();
    });

    testWidgets('REGRESSION: onChild1Click still wins over onClick',
        (tester) async {
      var childClicks = 0;
      var rootClicks = 0;
      await tester.pumpWidget(host(FSuper(
        width: 200,
        height: 60,
        backgroundColor: bg,
        pressedColor: pressed,
        onClick: () => rootClicks++,
        child1: SizedBox(
          width: 50,
          height: 30,
          child: Center(child: Text('c1')),
        ),
        child1Alignment: Alignment.center,
        onChild1Click: () => childClicks++,
      )));
      await tester.pumpAndSettle();

      await tester.tap(find.text('c1'));
      await tester.pumpAndSettle();
      expect(childClicks, 1, reason: 'child1 handler should receive the tap');
      expect(rootClicks, 0, reason: 'onClick must not also fire');
    });

    testWidgets('pressed state does not leak into a freshly created widget',
        (tester) async {
      Widget slot(String id) => host(FSuper(
            key: ValueKey(id),
            width: 100,
            height: 40,
            text: 'tap',
            backgroundColor: bg,
            pressedColor: pressed,
          ));

      await tester.pumpWidget(slot('a'));
      await tester.pumpAndSettle();

      final gesture =
          await tester.startGesture(tester.getCenter(find.byType(FSuper)));
      await tester.pumpAndSettle();
      expect(paintedBackgroundColors(tester), contains(pressed));
      await gesture.up();
      await tester.pumpAndSettle();

      // A different key means a fresh State: it must start unpressed rather
      // than inheriting the previous widget's flag.
      await tester.pumpWidget(slot('b'));
      await tester.pumpAndSettle();
      expect(paintedBackgroundColors(tester), contains(bg));
      expect(paintedBackgroundColors(tester), isNot(contains(pressed)));
    });
  });

  group('no regression in existing behaviour', () {
    testWidgets('renders with only text', (tester) async {
      await tester.pumpWidget(host(FSuper(width: 120, height: 40, text: 'hi')));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(find.text('hi'), findsOneWidget);
    });

    testWidgets('corner / gradient / shadow path still builds',
        (tester) async {
      await tester.pumpWidget(host(FSuper(
        width: 160,
        height: 60,
        text: 'styled',
        corner: FCorner.all(12),
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
        shadowColor: Colors.black26,
        shadowBlur: 8,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
      expect(findTextPart(tester).overflow, TextOverflow.ellipsis);
    });

    testWidgets('Neumorphism path still builds with pressedColor set',
        (tester) async {
      await tester.pumpWidget(host(FSuper(
        width: 160,
        height: 60,
        text: 'neu',
        isSupportNeumorphism: true,
        pressedColor: const Color(0xFFFF0000),
      )));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    });
  });

  group('key support', () {
    testWidgets('FSuper accepts a key and forwards it to the Element',
        (tester) async {
      const k = ValueKey<String>('fsuper-key');
      await tester.pumpWidget(host(FSuper(
        key: k,
        width: 100,
        height: 40,
        text: 'keyed',
      )));
      await tester.pumpAndSettle();

      expect(find.byKey(k), findsOneWidget);
      expect(tester.widget<FSuper>(find.byType(FSuper)).key, k);
      expect(tester.takeException(), isNull);
    });

    testWidgets('two keyed FSuper siblings keep independent state',
        (tester) async {
      const bg = Color(0xFF00FF00);
      const pressed = Color(0xFFFF0000);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Column(children: [
            FSuper(
              key: const ValueKey('first'),
              width: 100,
              height: 40,
              text: 'a',
              backgroundColor: bg,
              pressedColor: pressed,
            ),
            FSuper(
              key: const ValueKey('second'),
              width: 100,
              height: 40,
              text: 'b',
              backgroundColor: bg,
              pressedColor: pressed,
            ),
          ]),
        ),
      ));
      await tester.pumpAndSettle();

      // Press only the first one; the second must stay unhighlighted.
      final gesture = await tester
          .startGesture(tester.getCenter(find.byKey(const ValueKey('first'))));
      await tester.pumpAndSettle();

      expect(paintedBackgroundColors(tester), contains(pressed),
          reason: 'the pressed sibling shows the pressed colour');
      expect(
        paintedBackgroundColors(tester).where((c) => c == bg).length,
        greaterThanOrEqualTo(1),
        reason: 'the untouched sibling keeps its background colour',
      );

      await gesture.up();
      await tester.pumpAndSettle();
      expect(paintedBackgroundColors(tester), isNot(contains(pressed)));
    });

    testWidgets('key still works alongside child1 / child2', (tester) async {
      const k = ValueKey<String>('with-children');
      await tester.pumpWidget(host(FSuper(
        key: k,
        width: 200,
        height: 60,
        text: 'root',
        child1: SizedBox(width: 40, height: 20, child: Text('c1')),
        child1Alignment: Alignment.centerLeft,
        child2: SizedBox(width: 40, height: 20, child: Text('c2')),
        child2Alignment: Alignment.centerRight,
      )));
      await tester.pumpAndSettle();

      expect(find.byKey(k), findsOneWidget);
      expect(tester.takeException(), isNull);
      expect(find.text('c1'), findsOneWidget);
      expect(find.text('c2'), findsOneWidget);
    });
  });
}
