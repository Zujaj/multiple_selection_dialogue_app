import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multiple_selection_dialogue_app/widgets/multi_select_dialog.dart';

void main() {
  /// Holds the question.
  var questionText = 'What is your favourite color?';

  /// Holds the answers.
  var answerList = ['Red', 'Green', 'Blue'];

  // Create a [MultiSelectDialog] widget
  var multiSelectDialogWidget = MultiSelectDialog(
    answers: answerList,
    question: Text(questionText, key: Key('title')),
  );

  /// Builds the [MultiSelectDialog] widget
  Future<void> init(WidgetTester tester) async {
    // Pump the [MultiSelectDialog] by wrapping it inside a [MaterialApp] widget
    await tester.pumpWidget(MaterialApp(home: multiSelectDialogWidget));

    // Wait for the build method to finish
    await tester.pumpAndSettle();
  }

  Future<void> tapAtCheckBoxListTile(
      {@required WidgetTester tester, @required int index}) async {
    // Build the MultiSelectDialog Widget
    await tester.pumpWidget(MaterialApp(home: multiSelectDialogWidget));

    // Find the [CheckboxListTile] Widget
    var checkBoxListTileFinder = find.byType(CheckboxListTile);

    // Expect three [CheckboxListTile] Widgets
    expect(checkBoxListTileFinder, findsNWidgets(answerList.length));

    // Tap on the second [CheckboxListTile] Widget
    await tester.tap(checkBoxListTileFinder.at(index));

    // Wait for animation to finish
    await tester.pump();

    // Find the [ElevatedButton] Widget having specific properties.
    var submitButtonFinder = find.byWidgetPredicate((widget) =>
        widget is ElevatedButton &&
        widget.child is Text &&
        widget.onPressed != () => Null);

    // Expect a single [ElevatedButton] Widget
    expect(submitButtonFinder, findsOneWidget);

    // Tap on the [ElevatedButton] Widget
    await tester.tap(submitButtonFinder);

    // Wait for animation to finish
    await tester.pump();

    // Expect [selectedItems] is not empty
    expect(multiSelectDialogWidget.selectedItems.isEmpty, isFalse);

    // Expect [selectedItems] has a value
    expect(multiSelectDialogWidget.selectedItems.contains(answerList[index]),
        isTrue);
  }

  group('[Multi Select Dialog Widget] UI - ', () {
    testWidgets('Returns a [SimpleDialog] Widget', (WidgetTester tester) async {
      // Build the MultiSelectDialog Widget
      await init(tester);

      // Print the Widget Tree
      // tester.allWidgets.forEach((element) => print(element.toStringShallow()));

      // Find the widget [SimpleDialog] by type
      var simpleDialog = find.byType(SimpleDialog);

      // Expect only one [SimpleDialog] widget.
      expect(simpleDialog, findsOneWidget);
    });
    testWidgets('The [title] of [SimpleDialog] is a [Text] Widget',
        (WidgetTester tester) async {
      // Build the MultiSelectDialog Widget
      await init(tester);

      // Find the [Text] widget with the key 'title'.
      var titleText = find.byKey(Key('title'));

      // Expect only one [Text] widget with the key 'title'.
      expect(titleText, findsOneWidget);
      expect(titleText, isNotNull);

      // Expect the [Text] widget is not empty.
      expect(find.text(''), findsNothing);
      expect(find.text(questionText), findsOneWidget);
    });

    testWidgets('The [SimpleDialog] has three [CheckboxListTile] Widgets',
        (WidgetTester tester) async {
      // Build the MultiSelectDialog Widget
      await init(tester);

      /// Holds List[CheckboxListTile] with no selection
      var checkBoxLists = answerList
          .map((answer) => CheckboxListTile(
                title: Text(answer),
                controlAffinity: ListTileControlAffinity.platform,
                value: false,
                onChanged: (value) => value,
              ))
          .toList();

      /// Holds List[Finder] for each [CheckboxListTile] widgets.
      var checkBoxListFinder = [];

      // Find the [CheckboxListTile] widget.
      checkBoxLists.forEach((checkBoxList) =>
          checkBoxListFinder.add(find.byWidget(checkBoxList)));

      //  Expect three [CheckboxListTile] widgets.
      expect(checkBoxListFinder.length == 3, isTrue);

      for (int i = 0; i < 3; i++) {
        // Expect the CheckboxListTile's [title] is a Text Widget.
        expect(checkBoxLists[i].title is Text, isTrue);

        // Expect the CheckboxListTile's [title] Text Widget has answers.
        expect(find.text(answerList[i]), findsOneWidget);

        // Expect the CheckboxListTile's [value] is false.
        expect(checkBoxLists[i].value == true, isFalse);

        // Expect the CheckboxListTile's [controlAffinity] depends upon the platform.
        expect(
            checkBoxLists[i].controlAffinity ==
                ListTileControlAffinity.platform,
            isTrue);
      }
    });

    testWidgets(
        'The [SimpleDialog] has an [ElevatedButton] wrapped in [Align] Widget',
        (WidgetTester tester) async {
      // Build the MultiSelectDialog Widget
      await init(tester);

      // Find the [ElevatedButton] wrapped in [Align] widget.
      var submitButtonFinder = find.byWidgetPredicate((widget) =>
          widget is Align &&
          widget.alignment == Alignment.center &&
          widget.child is ElevatedButton);

      // Expect a single [ElevatedButton] with Text('Submit').
      expect(find.text('Submit'), findsOneWidget);

      // Expect a single [ElevatedButton].
      expect(submitButtonFinder, findsOneWidget);

      // Tap on the [ElevatedButton] widget.
      await tester.press(submitButtonFinder);

      // Wait for the button press event to finish.
      await tester.pump();

      // Expect to get no result after tapping as [CheckboxListTile]'s values were false.
      expect(multiSelectDialogWidget.selectedItems.isNotEmpty, isFalse);
    });
  });

  group('[Multi Select Dialog Widget] - ', () {
    testWidgets(
        'On Tapping the first [CheckboxListTile], the result is Red',
        (WidgetTester tester) async =>
            await tapAtCheckBoxListTile(tester: tester, index: 0));

    testWidgets(
        'On Tapping the second [CheckboxListTile], the result is Green',
        (WidgetTester tester) async =>
            await tapAtCheckBoxListTile(tester: tester, index: 1));

    testWidgets(
        'On Tapping the third [CheckboxListTile], the result is Blue',
        (WidgetTester tester) async =>
            await tapAtCheckBoxListTile(tester: tester, index: 2));
  });
}
