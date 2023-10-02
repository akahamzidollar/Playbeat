import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  const DrawerItem({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Icon(
              icon,
              size: 25,
            ),
            const SizedBox(width: 20),
            Text(
              text,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          thickness: 1.5,
        ),
      ],
    );
  }
}
