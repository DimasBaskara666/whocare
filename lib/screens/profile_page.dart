import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();

  String? _selectedGender;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isSubscribed = false;
  bool _isNotificationsEnabled = false;
  String _selectedActivityLevel = 'Moderate';
  List<String> _selectedInterests = [];

  final List<String> _activityLevels = [
    'Sedentary',
    'Light',
    'Moderate',
    'Very Active',
    'Extremely Active'
  ];
  final List<String> _interests = [
    'Fitness',
    'Nutrition',
    'Meditation',
    'Yoga',
    'Running',
    'Weight Training'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Profile'),
            centerTitle: true,
            floating: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {  
                    _showSnackBar('Profile updated successfully!');
                  }
                },
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.blue.withOpacity(0.1),
                                child: const Icon(Icons.person,
                                    size: 50, color: Colors.grey),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  radius: 18,
                                  child: IconButton(
                                    icon: const Icon(Icons.camera_alt,
                                        size: 18, color: Colors.white),
                                    onPressed: () {
                                      _showSnackBar(
                                          'Profile picture update coming soon!');
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildBasicInformation(),
                        const SizedBox(height: 16),
                        _buildPersonalDetails(),
                        const SizedBox(height: 16),
                        _buildPreferences(),
                        const SizedBox(height: 16),
                        _buildBioSection(),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _showSnackBar('Profile saved successfully!');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Save Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
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
        ],
      ),
    );
  }

  Widget _buildBasicInformation() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Basic Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalDetails() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Personal Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildGenderSelector(),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Date of Birth'),
              subtitle: Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            ),
            const Divider(),
            ListTile(
              title: const Text('Preferred Contact Time'),
              subtitle: Text(_selectedTime.format(context)),
              trailing: const Icon(Icons.access_time),
              onTap: () => _selectTime(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreferences() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Preferences',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Activity Level',
                border: OutlineInputBorder(),
              ),
              value: _selectedActivityLevel,
              items: _activityLevels.map((String level) {
                return DropdownMenuItem(
                  value: level,
                  child: Text(level),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedActivityLevel = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildInterestsSelector(),
            CheckboxListTile(
              title: const Text('Subscribe to newsletter'),
              value: _isSubscribed,
              onChanged: (bool? value) {
                setState(() {
                  _isSubscribed = value!;
                });
              },
              fillColor: WidgetStateProperty.resolveWith((states) {
                if (!states.contains(WidgetState.selected)) {
                  return Colors.transparent;
                }
                return Colors.blue;
              }),
            ),
            SwitchListTile(
              title: const Text('Enable notifications'),
              value: _isNotificationsEnabled,
              activeColor: Colors.blue,
              onChanged: (bool value) {
                setState(() {
                  _isNotificationsEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderSelector() {
    return Row(
      children: [
        Radio<String>(
            value: 'Male',
            groupValue: _selectedGender,
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
            fillColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.blue.withOpacity(.32);
              }
              return Colors.blue;
            })),
        const Text('Male'),
        Radio<String>(
          value: 'Female',
          groupValue: _selectedGender,
          onChanged: (value) {
            setState(() {
              _selectedGender = value!;
            });
          },
          fillColor:
              WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return Colors.blue.withOpacity(.32);
            }
            return Colors.blue;
          }),
        ),
        const Text('Female'),
      ],
    );
  }

  Widget _buildInterestsSelector() {
    return Wrap(
      spacing: 8,
      children: _interests.map((interest) {
        return FilterChip(
          label: Text(interest),
          selectedColor: Colors.blue[100],
          selected: _selectedInterests.contains(interest),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedInterests.add(interest);
              } else {
                _selectedInterests.remove(interest);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildBioSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bio',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bioController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Tell us about yourself...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
