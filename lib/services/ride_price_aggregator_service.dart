import 'dart:async';

import '../models/ride.dart';
import '../models/ride_service.dart';

class RidePriceAggregatorService {
  final RideService rideService;
  final _streamController = StreamController<double>();

  Stream<double> get totalPriceStream => _streamController.stream;

  RidePriceAggregatorService({required this.rideService});

  Future<void> calculatePrice(Ride ride) async {
    //final priceResponse = await rideService.calculatePrice(
      // startLat: ride.startLat,
      // startLng: ride.startLng,
      // endLat: ride.endLat,
      // endLng: ride.endLng,
    //);

  //   if (priceResponse['success']) {
  //     _streamController.add(priceResponse['price']);
  //   } else {
  //     _streamController.addError(priceResponse['error']);
  //   }
  }

  void dispose() {
    _streamController.close();
  }
}
