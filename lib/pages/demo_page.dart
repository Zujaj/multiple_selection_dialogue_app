import 'package:flutter/material.dart';
import 'package:multiple_selection_dialogue_app/widgets/multi_select_form_field.dart';

/// A demo page that displays an [ElevatedButton]
class DemoPage extends StatelessWidget {
  /// A Global Key to track the form's state
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: MultiSelectFormField(
        context: context,
        buttonText: 'FLAVOURS',
        itemList: ['Chocolate', 'Caramel', 'Vanilla', 'Peanut Butter'],
        questionText: 'Select Your Flavours',
        validator: (flavours) =>
            flavours.length == 0 ? 'Please select at least one flavor!' : null,
        onSaved: (flavours) {
          print(flavours);
          // Logic to save selected flavours in the database
        },
      ),
      onChanged: () {
        if (_formKey.currentState.validate()) {
          // Invokes the OnSaved Method
          _formKey.currentState.save();
        }
      },
    );
  }
}
