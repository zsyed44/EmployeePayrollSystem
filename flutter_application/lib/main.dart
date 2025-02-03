import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Employee Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const EmployeeSelectionPage(),
    );
  }
}

class EmployeeSelectionPage extends StatelessWidget {
  const EmployeeSelectionPage({super.key});

  final List<String> employees = const [
    'Alice', 'Bob', 'Charlie', 'David', 'Eve'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Employee')),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(employees[index]),
            trailing: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PinEntryPage(employeeName: employees[index]),
                  ),
                );
              },
              child: const Text('Login'),
            ),
          );
        },
      ),
    );
  }
}

class PinEntryPage extends StatefulWidget {
  final String employeeName;
  
  const PinEntryPage({super.key, required this.employeeName});

  @override
  _PinEntryPageState createState() => _PinEntryPageState();
}

class _PinEntryPageState extends State<PinEntryPage> {
  final TextEditingController _pinController = TextEditingController();
  final String correctPin = '1234'; // Example PIN for validation

  void _validatePin() {
    if (_pinController.text == correctPin) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EmployeeInfoPage(employeeName: widget.employeeName),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect PIN')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter PIN for ${widget.employeeName}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter PIN'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _validatePin,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeInfoPage extends StatelessWidget {
  final String employeeName;

  const EmployeeInfoPage({super.key, required this.employeeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${employeeName}'s Information")),
      body: Center(
        child: Text(
          'Welcome, $employeeName! This is your information page.',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
