class Ride {
  final String id;
  final String startLocation;
  final String endLocation;
  final String rideService;
  final String estimatedArrivalTime;
  final double price;

  Ride({
    required this.id,
    required this.startLocation,
    required this.endLocation,
    required this.rideService,
    required this.estimatedArrivalTime,
    required this.price,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'],
      startLocation: json['start_location'],
      endLocation: json['end_location'],
      rideService: json['ride_service'],
      estimatedArrivalTime: json['estimated_arrival_time'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'start_location': startLocation,
      'end_location': endLocation,
      'ride_service': rideService,
      'estimated_arrival_time': estimatedArrivalTime,
      'price': price,
    };
  }
}
