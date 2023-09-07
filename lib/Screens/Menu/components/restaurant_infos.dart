import 'package:flutter/material.dart';

class restaurantInfos extends StatelessWidget {
  const restaurantInfos({
    Key? key,
    required this.establishmentName,
    required this.establishmentAddress,
    required this.establishmentTel,
    required this.establishmentQueueTime,
  }) : super(key: key);

  final String establishmentName;
  final String establishmentAddress;
  final String establishmentTel;
  final String establishmentQueueTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                  child: Opacity(
                    opacity: 0.7,
                    child: Image.asset(
                      "assets/images/hamburger.jpg",
                      fit: BoxFit.cover,
                      height: 300,
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/logo.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  establishmentName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  establishmentAddress,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  establishmentTel,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  establishmentQueueTime,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
