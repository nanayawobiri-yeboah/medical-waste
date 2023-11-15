import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



class CustomerRegistrationPage extends StatelessWidget {
  const CustomerRegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
      ),

        body: Stack(
        children: <Widget>[
          
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8), 
                borderRadius: BorderRadius.circular(16),
                
              ),
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              child: const CustomerRegistrationForm(),
            ),
          ),
        ],
      ),
    );
         
    
  }
}

class CustomerRegistrationForm extends StatefulWidget {
  const CustomerRegistrationForm({Key? key}) : super(key: key);

  @override
  _CustomerRegistrationFormState createState() => _CustomerRegistrationFormState();
}



class _CustomerRegistrationFormState extends State<CustomerRegistrationForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
 
  final TextEditingController _controllerCustomerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPhone = TextEditingController();

  String? _selectedCustomerType;
  String? _selectedRegion;
  String? _selectedDistrict;

  List<String> _customerTypes = []; 
  List<String> _regions = []; 
  List<String> _districts = []; 


  @override
  void initState() {
    super.initState();
    
    fetchCustomerTypes();
    fetchRegions();
    fetchDistricts();
  }

Future<void> fetchCustomerTypes() async {
  final dio = Dio();
  final response = await dio.get('http://13.39.163.41/medical_waste/api/customer-types');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = response.data;
      final List<dynamic> data = responseData['data'];
  
      setState(() {
      // Extract the 'name' field from each customer type object and add it to the list
         _customerTypes = data.map((item) => item['name'].toString()).toList();
         });
    } else {
      throw Exception('Failed to fetch customer types');
  }
}

Future<void> fetchRegions() async {
  final dio = Dio();
  final response = await dio.get('http://13.39.163.41/medical_waste/api/regions');

  if (response.statusCode == 200) {
    final List<dynamic> data = response.data['data'];
    setState(() {
       _regions = data.map((item) => item['name'].toString()).toList();
    });
  } else {
    throw Exception('Failed to fetch regions');
  }
}


Future<void> fetchDistricts() async {
  final dio = Dio();
  final response = await dio.get('http://13.39.163.41/medical_waste/api/districts');

  if (response.statusCode == 200) {
    final List<dynamic> data = response.data['data'];

    setState(() {
      _districts = data.map((item) => item['name'].toString()).toList();
    });
  } else {
    throw Exception('Failed to fetch districts');
  }
}



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              "Customer Registration",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Text(
              "Customer Information",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 35),
            TextFormField(
              controller: _controllerCustomerName,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                labelText: "Customer Name",
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter customer name.";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedCustomerType,
              onChanged: (value) {
                setState(() {
                  _selectedCustomerType = value;
                });
              },
              items: _customerTypes.map((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: "Customer Type",
                prefixIcon: const Icon(Icons.category),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please select customer type.";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedRegion,
              onChanged: (value) {
                setState(() {
                  _selectedRegion = value;
                });
              },
              items: _regions.map((region) {
                return DropdownMenuItem<String>(
                  value: region,
                  child: Text(region),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: "Select a Region",
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please select a region.";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDistrict,
              onChanged: (value) {
                setState(() {
                  _selectedDistrict = value;
                });
              },
              items: _districts.map((district) {
                return DropdownMenuItem<String>(
                  value: district,
                  child: Text(district),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: "Select a District",
                prefixIcon: const Icon(Icons.location_city),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please select a district.";
                }
                return null;
              },
            ),
            const SizedBox(height: 20), 
            TextFormField(
              controller: _controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter email.";
                } else if (!(value.contains('@') && value.contains('.'))) {
                  return "Invalid email";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _controllerPhone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Phone Number",
                prefixIcon: const Icon(Icons.phone),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Please enter phone number.";
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Add your registration logic here.
                    }
                  },
                  child: const Text("Register"),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controllerCustomerName.dispose();
    _controllerEmail.dispose();
    _controllerPhone.dispose();
    super.dispose();
  }
}


