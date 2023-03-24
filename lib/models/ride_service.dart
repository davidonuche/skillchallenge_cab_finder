import 'dart:convert';
import 'package:http/http.dart' as http;

import '../services/ride_api_service.dart';

class RideService {
  final String apiUrl;

  RideService({required this.apiUrl});

  Future<List<Ride>> getAvailableRides(
      {required double startLat,
      required double startLng,
      required double endLat,
      required double endLng}) async {
    final url =
        '$apiUrl/rides?start_location=$startLat,$startLng&end_location=$endLat,$endLng';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final ridesData = jsonDecode(response.body)['rides'];
      final rides = <Ride>[];
      for (final rideData in ridesData) {
        final ride = Ride.fromJson(rideData);
        rides.add(ride);
      }
      return rides;
    } else {
      throw Exception(
          'Error fetching available rides: ${response.statusCode}');
    }
  }

  Future<Ride> requestRide({required String rideId}) async {
    final url = '$apiUrl/rides/$rideId/request';
    final response = await http.post(Uri.parse(url));
    if (response.statusCode == 201) {
      final rideData = jsonDecode(response.body)['ride'];
      final ride = Ride.fromJson(rideData);
      return ride;
    } else {
      throw Exception('Error requesting ride: ${response.statusCode}');
    }
  }

  Future<Ride> cancelRide({required String rideId}) async {
    final url = '$apiUrl/rides/$rideId/cancel';
    final response = await http.put(Uri.parse(url));
    if (response.statusCode == 200) {
      final rideData = jsonDecode(response.body)['ride'];
      final ride = Ride.fromJson(rideData);
      return ride;
    } else {
      throw Exception('Error cancelling ride: ${response.statusCode}');
    }
  }
}
