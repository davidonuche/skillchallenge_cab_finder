import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/ride_service.dart';

class RideFormScreen extends StatefulWidget {
  @override
  _RideFormScreenState createState() => _RideFormScreenState();
}

class _RideFormScreenState extends State<RideFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final startLocationController = TextEditingController();
  final endLocationController = TextEditingController();
  final rideServiceController = TextEditingController();
  final estimatedArrivalTimeController = TextEditingController();
  final rideService = RideService(apiUrl: 'http://localhost:3000/api');

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  }

  String? _validateTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }

    final dateTime = DateFormat('yyyy-MM-dd HH:mm').parse(value, true);
    if (dateTime == null) {
      return 'Please enter a valid date and time (yyyy-MM-dd HH:mm).';
    }

    final now = DateTime.now();
    if (dateTime.isBefore(now)) {
      return 'Please enter a date and time in the future.';
    }

    return null;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final rideService = rideServiceController.text;
    final estimatedArrivalTime = estimatedArrivalTimeController.text;

    // final result = await rideService.addRide(
    //   startLat: 0,
    //   startLng: 0,
    //   endLat: 0,
    //   endLng: 0,
    //   rideService: rideService,
    //   estimatedArrivalTime: estimatedArrivalTime,
    // );

  //   if (result['success']) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Ride added successfully.')),
  //     );
  //     Navigator.of(context).pushNamed('/');
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(result['error'])),
  //     );
  //   }
  }

  @override
  void dispose() {
    startLocationController.dispose();
    endLocationController.dispose();
    rideServiceController.dispose();
    estimatedArrivalTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Ride'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Start Location',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: startLocationController,
                  validator: _validateLocation,
                  decoration: const InputDecoration(hintText: 'Enter start location'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'End Location',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: endLocationController,
                  validator: _validateLocation,
                  decoration: const InputDecoration(hintText: 'Enter end location'),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Ride Service',
                  style:  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  // controller: startLocationController,
                  // validator: _validateLocation,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'End Location'),
                  controller: endLocationController,
                  validator: _validateLocation,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Ride Service'),
                  controller: rideServiceController,
                  validator: _validateLocation,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Estimated Arrival Time (yyyy-MM-dd HH:mm)'),
                  controller: estimatedArrivalTimeController,
                  validator: _validateTime,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Add Ride'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
