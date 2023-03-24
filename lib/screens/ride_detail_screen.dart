import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RideDetailScreen extends StatefulWidget {
  final String rideId;

  const RideDetailScreen({Key? key, required this.rideId}) : super(key: key);

  @override
  _RideDetailScreenState createState() => _RideDetailScreenState();
}

class _RideDetailScreenState extends State<RideDetailScreen> {
  late Future<Map<String, dynamic>> _rideDetails;

  @override
  void initState() {
    super.initState();
    // _rideDetails = RideService(apiUrl: 'https://myrideapi.com').getRideDetails(rideId: widget.rideId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ride Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _rideDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!['success']) {
              final ride = snapshot.data!['ride'];
              final startLocation = ride['start_location'];
              final endLocation = ride['end_location'];
              final rideService = ride['ride_service'];
              final estimatedArrivalTime = DateFormat('h:mm a').format(DateTime.parse(ride['estimated_arrival_time']));
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Start Location: $startLocation'),
                    const SizedBox(height: 16),
                    Text('End Location: $endLocation'),
                    const SizedBox(height: 16),
                    Text('Ride Service: $rideService'),
                    const SizedBox(height: 16),
                    Text('Estimated Arrival Time: $estimatedArrivalTime'),
                  ],
                ),
              );
            } else if (snapshot.hasData && !snapshot.data!['success']) {
              return Center(
                child: Text(snapshot.data!['error']),
              );
            } else {
              return const Center(
                child: Text('Error: Something went wrong!'),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
