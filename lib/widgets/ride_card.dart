import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {
  final String startLocation;
  final String endLocation;
  final String price;
  final VoidCallback onPressed;

  const RideCard({super.key, 
    required this.startLocation,
    required this.endLocation,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '$startLocation to $endLocation',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Price: $price',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Book Now'),
            ),
          ],
        ),
      ),
    );
  }
}
