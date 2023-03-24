import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RideForm extends StatefulWidget {
  final void Function({
    required String startLocation,
    required String endLocation,
    required String rideService,
    required DateTime estimatedArrivalTime,
  }) onFormSubmitted;

  const RideForm({Key? key, required this.onFormSubmitted}) : super(key: key);

  @override
  _RideFormState createState() => _RideFormState();
}

class _RideFormState extends State<RideForm> {
  final _formKey = GlobalKey<FormState>();
  final startLocationController = TextEditingController();
  final endLocationController = TextEditingController();
  final rideServiceController = TextEditingController();
  DateTime? estimatedArrivalTime;

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required.';
    }
    return null;
  }


  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final startLocation = startLocationController.text;
    final endLocation = endLocationController.text;
    final rideService = rideServiceController.text;

    widget.onFormSubmitted(
      startLocation: startLocation,
      endLocation: endLocation,
      rideService: rideService,
      estimatedArrivalTime: estimatedArrivalTime!,
    );
  }

  @override
  void dispose() {
    startLocationController.dispose();
    endLocationController.dispose();
    rideServiceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: startLocationController,
            decoration: const InputDecoration(
              labelText: 'Start Location',
            ),
            validator: _validateLocation,
          ),
          TextFormField(
            controller: endLocationController,
            decoration: const InputDecoration(
              labelText: 'End Location',
            ),
            validator: _validateLocation,
          ),
          TextFormField(
            controller: rideServiceController,
            decoration: const InputDecoration(
              labelText: 'Ride Service',
            ),
            validator: _validateLocation,
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (pickedDate == null) return;

              final pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime == null) return;
              final dateTime = DateTime(
                pickedDate.year,
                pickedDate.month,
                pickedDate.day,
                pickedTime.hour,
                pickedTime.minute,
              );
              setState(() {
                estimatedArrivalTime = dateTime;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade200,
              ),
              child: Row(
                children: [
                  const Icon(Icons.access_time),
                  const SizedBox(width: 16),
                  Text(
                    estimatedArrivalTime == null
                        ? 'Select estimated arrival time'
                        : DateFormat('yyyy-MM-dd HH:mm').format(
                            estimatedArrivalTime!,
                          ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
