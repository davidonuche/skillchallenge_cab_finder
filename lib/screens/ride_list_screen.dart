import 'package:flutter/material.dart';

import '../models/ride.dart';
import '../models/ride_service.dart';

class RideListScreen extends StatefulWidget {
  final Map<String, String> locations;

  RideListScreen({required this.locations});

  @override
  _RideListScreenState createState() => _RideListScreenState();
}

class _RideListScreenState extends State<RideListScreen> {
  final RideService _rideService = RideService(apiUrl: 'https://ride-sharing-app.com/api');
  late List<Ride> _rides;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRides();
  }

  void _fetchRides() async {
    final startLat = double.parse(widget.locations['start_lat']!);
    final startLng = double.parse(widget.locations['start_lng']!);
    final endLat = double.parse(widget.locations['end_lat']!);
    final endLng = double.parse(widget.locations['end_lng']!);

    // final result = await _rideService.getRides(
    //   startLat: startLat,
    //   startLng: startLng,
    //   endLat: endLat,
    //   endLng: endLng,
    // );

  //   if (result['success']) {
  //     final ridesData = result['rides'];
  //     setState(() {
  //       _rides = ridesData.map<Ride>((rideData) => Ride.fromJson(rideData)).toList();
  //       _isLoading = false;
  //     });
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(result['error'])),
  //     );
  //   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rides'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _rides.length,
              itemBuilder: (BuildContext context, int index) {
                final ride = _rides[index];
                return ListTile(
                  title: Text('Ride ID: ${ride.id}'),
                  //subtitle: Text('Driver: ${ride.driverName}'),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context).pushNamed('/ride-details', arguments: {'ride_id': ride.id});
                  },
                );
              },
            ),
    );
  }
}
