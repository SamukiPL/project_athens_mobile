import 'package:flutter/material.dart';

class LabeledCheckbox extends StatefulWidget {
  LabeledCheckbox({
    required this.value,
    required this.label,
    required this.onChange
  });

  final Widget label;
  final bool value;
  final void Function(bool newValue) onChange;

  @override
  _LabeledCheckboxState createState() => _LabeledCheckboxState(
    label: label,
    value: value,
    onChange: onChange
  );
}

class _LabeledCheckboxState extends State<LabeledCheckbox> {
  _LabeledCheckboxState({
    required this.value,
    required this.label,
    required this.onChange
  });

  final Widget label;
  bool value;
  final void Function(bool newValue) onChange;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (bool? newValue) {
            setState(() {
              value = newValue == true;
              onChange(value);
            });
          },
        ),
        label
      ],
    );
  }
}