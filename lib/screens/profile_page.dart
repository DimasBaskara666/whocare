import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  bool _isChecked = false;
  String _gender = 'Male';

  void _showSnackbar(BuildContext context) {
    final snackBar = SnackBar(content: Text('Profile saved'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nama'),
            ),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                Text('Subscribe to newsletter'),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 'Male',
                  groupValue: _gender,
                  onChanged: (String? value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                Text('Male'),
                Radio(
                  value: 'Female',
                  groupValue: _gender,
                  onChanged: (String? value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _showSnackbar(context);
              },
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
