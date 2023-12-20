import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {
  final String value;
  final String groupValue;
  final void Function(String)? onChanged;

  const CustomRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;

    return GestureDetector(
      onTap: () {
        if (!selected && onChanged != null) {
          onChanged!(value);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).hoverColor,
        ),
        padding:
        const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
        child: Text(
          value,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: selected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
