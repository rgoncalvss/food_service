import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class LoginScreenTopImage extends StatelessWidget {
  const LoginScreenTopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 1),
        Row(
          children: [
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 200,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        SizedBox(height: defaultPadding * 10),
      ],
    );
  }
}
