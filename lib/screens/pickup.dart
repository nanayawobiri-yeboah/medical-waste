import 'package:flutter/material.dart';
import 'package:medical_waste/screens/wastedetails.dart';

void main() {
  runApp(const MaterialApp(
    home: PickupMedicalWastePage(),
  ));
}

class PickupMedicalWastePage extends StatelessWidget {
  const PickupMedicalWastePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Up Medical Waste'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            ClientCard(
              clientName: 'Client 1',
              address: '123 Main St',
            ),
            ClientCard(
              clientName: 'Client 2',
              address: '456 Elm St',
            ),
            ClientCard(
              clientName: 'Client 3',
              address: '789 Oak St',
            ),
            // Add more client cards as needed
          ],
        ),
      ),
    );
  }
}

class ClientCard extends StatelessWidget {
  final String clientName;
  final String address;

  const ClientCard({
    Key? key,
    required this.clientName,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) =>
                const WasteDetailsPage(), 
          ),
        );
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          tileColor: Colors.white,
          title: Text(
            clientName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            address,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          trailing: const Icon(Icons
              .arrow_forward), 
        ),
      ),
    );
  }
}


