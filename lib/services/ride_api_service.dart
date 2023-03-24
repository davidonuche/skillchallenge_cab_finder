import 'dart:convert';
import 'package:http/http.dart' as http;

class RideApiService {
  final String apiUrl;

  RideApiService({required this.apiUrl});

  Future<List<Ride>> fetchRides(String startLocation, String endLocation) async {
    final url = Uri.parse('$apiUrl/rides?start_location=$startLocation&end_location=$endLocation');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      final List<Ride> rides = jsonData.map((data) => Ride.fromJson(data)).toList();
      return rides;
    } else {
      throw Exception('Failed to fetch rides');
    }
  }
}

class Ride {
  final int id;
  final String startLocation;
  final String endLocation;
  final String rideService;
  final DateTime estimatedArrivalTime;

  Ride({
    required this.id,
    required this.startLocation,
    required this.endLocation,
    required this.rideService,
    required this.estimatedArrivalTime,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'],
      startLocation: json['start_location'],
      endLocation: json['end_location'],
      rideService: json['ride_service'],
      estimatedArrivalTime: DateTime.parse(json['estimated_arrival_time']),
    );
  }
}
