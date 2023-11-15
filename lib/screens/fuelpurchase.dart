import 'package:flutter/material.dart';

class FuelPurchasePage extends StatelessWidget {
  const FuelPurchasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuel Purchase'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Fuel Purchase Amount',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            FuelAmountInput(), 
          ],
        ),
      ),
    );
  }
}

class FuelAmountInput extends StatefulWidget {
  const FuelAmountInput({super.key});

  @override
  _FuelAmountInputState createState() => _FuelAmountInputState();
}

class _FuelAmountInputState extends State<FuelAmountInput> {
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number, // Allow only numeric input
      decoration: const InputDecoration(
        labelText: 'Amount (in liters or currency)',
        border: OutlineInputBorder(),
      ),
      // You can add more styling or validation if needed
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
