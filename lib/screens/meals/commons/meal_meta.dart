import 'package:flutter/material.dart';

class MealMeta extends StatelessWidget {
  const MealMeta({
    super.key,
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: Colors.white,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
        )
      ],
    );
  }
}
