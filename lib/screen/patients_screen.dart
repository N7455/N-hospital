
import 'package:flutter/material.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> patients = [
    {
      'name': 'Rahul Sharma',
      'id': 'P001',
      'age': '28',
      'gender': 'Male',
      'phone': '9876543210',
    },
    {
      'name': 'Priya Singh',
      'id': 'P002',
      'age': '24',
      'gender': 'Female',
      'phone': '9876543211',
    },
    {
      'name': 'Amit Kumar',
      'id': 'P003',
      'age': '35',
      'gender': 'Male',
      'phone': '9876543212',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void addPatient() {
    final nameController = TextEditingController();
    final ageController = TextEditingController();
    final phoneController = TextEditingController();
    String gender = 'Male';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF151515),
              title: const Text('Add New Patient'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Patient Name',
                      ),
                    ),
                    TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Age',
                      ),
                    ),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                      ),
                    ),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      value: gender,
                      decoration: const InputDecoration(
                        labelText: 'Gender',
                      ),
                      items: ['Male', 'Female', 'Other']
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setDialogState(() => gender = value);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.trim().isEmpty ||
                        ageController.text.trim().isEmpty ||
                        phoneController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields'),
                        ),
                      );
                      return;
                    }

                    setState(() {
                      patients.add({
                        'name': nameController.text.trim(),
                        'id': 'P${(patients.length + 1).toString().padLeft(3, '0')}',
                        'age': ageController.text.trim(),
                        'gender': gender,
                        'phone': phoneController.text.trim(),
                      });
                    });

                    Navigator.pop(dialogContext);
                    nameController.dispose();
                    ageController.dispose();
                    phoneController.dispose();
                  },
                  child: const Text('Save Patient'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredPatients = patients.where((patient) {
      return patient['name']!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()) ||
          patient['id']!.toLowerCase().contains(
                searchController.text.toLowerCase(),
              );
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Patients'),
        backgroundColor: const Color(0xFF151515),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addPatient,
        backgroundColor: const Color(0xFFE50914),
        icon: const Icon(Icons.person_add),
        label: const Text('Add Patient'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search patient by name or ID',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: filteredPatients.isEmpty
                  ? const Center(
                      child: Text('No patients found'),
                    )
                  : ListView.builder(
                      itemCount: filteredPatients.length,
                      itemBuilder: (context, index) {
                        final patient = filteredPatients[index];

                        return Card(
                          color: const Color(0xFF151515),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFF2979FF),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              patient['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'ID: ${patient['id']}  •  Age: ${patient['age']}  •  ${patient['gender']}\nPhone: ${patient['phone']}',
                            ),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
