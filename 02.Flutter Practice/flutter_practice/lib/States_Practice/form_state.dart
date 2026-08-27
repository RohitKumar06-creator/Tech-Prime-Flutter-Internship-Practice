import 'package:flutter/material.dart';

class FormStateWidget extends StatefulWidget {
  const FormStateWidget({super.key});

  @override
  State<FormStateWidget> createState() => _FormStateWidgetState();
}

class _FormStateWidgetState extends State<FormStateWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  String _submittedName = '';

  @override
  void dispose() {
    // Controllers must be disposed to prevent memory leaks
    _nameController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _submittedName = _nameController.text;
      });
      _nameController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form State')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Enter your name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 40),
              if (_submittedName.isNotEmpty)
                Text(
                  'Welcome, $_submittedName!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
