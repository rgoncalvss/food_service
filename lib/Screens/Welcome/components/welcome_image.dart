import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
              color: kPrimaryColor,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: const Text(
                "Food Service",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
          ),
        ),
        const SizedBox(height: defaultPadding * 2),
        Row(
          children: [
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(300),
              child: Image.asset(
                'assets/images/logo.png',
                height: 250,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: defaultPadding * 6),
      ],
    );
  }
}