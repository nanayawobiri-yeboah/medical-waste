
import 'package:flutter/material.dart';
import 'package:medical_waste/screens/drawer.dart';
import 'package:medical_waste/screens/registration.dart';
import 'package:medical_waste/screens/pickup.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Medical Waste Management',
            style: TextStyle(
              color: Color.fromARGB(255, 21, 4, 4),
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.blue, 
          elevation: 0,
        ),
        drawer: const CustomDrawer(name: 'Mustapha Salam', email: 'oboy_staff@hotmail.com',),
        body: Stack(
          fit: StackFit.expand, 
          children: <Widget>[
            Image.asset(
              'assets/login.jpg', 
              fit: BoxFit.cover,  
            ),
             Center(
              child: Transform.translate(
                offset: const Offset(0, -40), 
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/medical_waste_image.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.9, 
                    child: CustomButton(
                      onPressed: () {
                        
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CustomerRegistrationPage(),
                          ),
                        );
                      },
                      backgroundColor: Colors.blue,
                      text: 'Register Customer',
                      icon: Icons.person, 
                      arrowIcon: Icons.arrow_forward, 
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                  
                Align(
                  alignment: Alignment.center,
                  child: FractionallySizedBox(
                    widthFactor: 0.9, 
                    child: CustomButton(
                      onPressed: () {
                        
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PickupMedicalWastePage(),
                          ),
                        );
                      },
                      backgroundColor: Colors.green,
                      text: 'Pick Up Medical Waste',
                      icon: Icons.medical_services, 
                      arrowIcon: Icons.arrow_forward, 
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
        
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, 
    required this.onPressed,
    required this.backgroundColor,
    required this.text,
    required this.icon,
    required this.arrowIcon,
  });

  final VoidCallback onPressed;
  final Color backgroundColor;
  final String text;
  final IconData icon;
  final IconData arrowIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ],
          ),
          Icon(arrowIcon),
        ],
      ),
    );
  }
}



