
import 'package:flutter/material.dart';
import 'package:dio/dio.dart'; // Import Dio package
import 'package:medical_waste/screens/home.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Dio dio = Dio();
  String authToken = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }



   Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await dio.post(
          'http://medical.nerasolgh.com/api/login', 
          data: {
            'username': _usernameController.text,
            'password': _passwordController.text,
          },
        );

        if (response.statusCode == 200) {
          final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

          if (responseData.containsKey('meta') && responseData['meta'] is Map) {
            final Map<String, dynamic> meta = responseData['meta'] as Map<String, dynamic>;

            if (meta.containsKey('token') && meta['token'] is String) {
              authToken = meta['token'] as String;
              
              // Handle a successful login and token retrieval here
              _navigateToHomePage();
            } else {
              _showErrorMessage('Invalid server response: Missing authentication token');
            }
          } else {
            _showErrorMessage('Invalid server response: Missing "meta" field');
          }
        } else {
          // Handle other status codes 
          final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
          if (responseData.containsKey('message')) {
            _showErrorMessage(responseData['message'].toString());
          } else {
            _showErrorMessage('Login failed with status code: ${response.statusCode}');
          }
        }
      } catch (e) {
        _showErrorMessage('Error during login: $e');
      }
    }
  }


  void _navigateToHomePage() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }


  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }


  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/login.jpg',
                      width: 550.0,
                      height: 500.0,
                    ),
                    const SizedBox(height: 30.0),
                    TextFormField(
                      controller: _usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Phone number',
                        prefixIcon: Icon(Icons.person, color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        child: const Text('Login'),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        // Add forgot password functionality here
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        // Add sign-up functionality here
                      },
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
