import 'package:flutter/material.dart';
import 'package:medical_waste/screens/fuelpurchase.dart';


class CustomDrawer extends StatelessWidget {
  final String name;
  final String email;

  const CustomDrawer({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(name), 
            accountEmail: Text(email), 
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.black),
            ),
          ),
  
          
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Cash Payment'),
            onTap: () {
              // Add navigation to the relevant page
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_gas_station),
            title: const Text('Record Fuel Purchased'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FuelPurchasePage(), // Navigate to the fuel purchase page
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
            
            },
          ),
        ],
      ),
    );
  }
}
