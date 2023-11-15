import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; 

class WasteDetailsPage extends StatefulWidget {
  const WasteDetailsPage({super.key});

  @override
  _WasteDetailsPageState createState() => _WasteDetailsPageState();
}

class _WasteDetailsPageState extends State<WasteDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _weightController = TextEditingController();
  String? _selectedVehicle;
  String? _selectedWasteType;

  List<String> _vehicles = [];
  
  List<String> _wasteTypes = [];



  @override
  void initState() {
    super.initState();
  
    fetchVehicles();
    fetchWasteTypes();
  }

  Future<void> fetchVehicles() async {
      final dio = Dio();
      final response = await dio.get('http://13.39.163.41/medical_waste/api/vehicles'); 


      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        setState(() {
          _vehicles = data.map((item) => item['name'].toString()).toList();
        });
    } else {
    throw Exception('Failed to fetch vehicles');
  }
  }

  void fetchWasteTypes() async {
     final dio = Dio();
      final response = await dio.get('http://15.236.239.177/medical_waste/api/waste-types');
       if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];

        setState(() {
          _wasteTypes = data.map((item) => item['name'].toString()).toList();
        });
    } else {
    throw Exception('Failed to fetch vehicles');
  }
   
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process and submit waste details
      final wasteWeight = double.parse(_weightController.text);
      print('Weight: $wasteWeight');
      print('Vehicle: $_selectedVehicle');
      print('Waste Type: $_selectedWasteType');
      // Implement your submission logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 40),
              Image.asset(
                'assets/wastage.png', 
                height: 150,
              ),
              const SizedBox(height: 20),
              const Text(
                'Enter Waste Details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Waste Weight (kg)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the waste weight.';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
    
              DropdownButtonFormField<String>(
                value: _selectedVehicle,
                onChanged: (value) {
                  setState(() {
                    _selectedVehicle = value;
                  });
                },
                items: _vehicles.map((vehicle) {
                  return DropdownMenuItem<String>(
                    value: vehicle,
                    child: Text(vehicle),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Select a Vehicle',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a vehicle.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedWasteType,
                onChanged: (value) {
                  setState(() {
                    _selectedWasteType = value;
                  });
                },
                items: _wasteTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  labelText: 'Select Waste Type',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select a waste type.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



