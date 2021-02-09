import 'package:flutter/material.dart';
import 'package:multiple_selection_dialogue_app/widgets/multi_select_dialog.dart';

/// A demo page that displays an [ElevatedButton]
class DemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Stores the selected flavours
    List<String> flavours = [];

    return ElevatedButton(
        child: Text('Flavours'),
        onPressed: () async {
          flavours = await showDialog<List<String>>(
                  context: context,
                  builder: (_) => MultiSelectDialog(
                          question: Text('Select Your Flavours'),
                          answers: [
                            'Chocolate',
                            'Caramel',
                            'Vanilla',
                            'Peanut Butter'
                          ])) ??
              [];
          print(flavours);
          // Logic to save selected flavours in the database
        });
  }
}
