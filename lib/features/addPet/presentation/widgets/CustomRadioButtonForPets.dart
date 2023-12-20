import 'package:flutter/material.dart';

class CustomRadioButtonForPets extends StatelessWidget {
  final String value;
  final String groupValue;
  final String imageURL;
  final void Function(String)? onChanged;

  const CustomRadioButtonForPets({
    required this.value,
    required this.groupValue,
    required this.imageURL,
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
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).hoverColor,
              borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(360), left: Radius.circular(360))),
          child: Container(
              child: Row(
                children: [
                  CircleAvatar(backgroundImage: AssetImage(imageURL)),
                  SizedBox(width: 4.0),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: selected
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ],
              ))),
    );
  }
}