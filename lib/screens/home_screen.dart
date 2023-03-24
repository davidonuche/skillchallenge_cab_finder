import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String startLocation = '';
  String endLocation = '';

  void _navigateToSearchScreen(
      BuildContext context, String locationType) async {
    final result = await Navigator.of(context)
        .pushNamed('/search', arguments: locationType);
    if (result != null) {
      setState(() {
        if (locationType == 'start') {
          // startLocation = result;
        } else {
          // endLocation = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Sharing App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Start Location'),
              controller: TextEditingController(text: startLocation),
              onTap: () => _navigateToSearchScreen(context, 'start'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: 'End Location'),
              controller: TextEditingController(text: endLocation),
              onTap: () => _navigateToSearchScreen(context, 'end'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (startLocation.isNotEmpty && endLocation.isNotEmpty) {
                  Navigator.of(context).pushNamed(
                    '/rides',
                    arguments: {
                      'start_location': startLocation,
                      'end_location': endLocation,
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Please enter both start and end locations.')),
                  );
                }
              },
              child: const Text('Find Rides'),
            ),
          ],
        ),
      ),
    );
  }
}
