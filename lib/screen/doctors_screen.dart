import 'package:flutter/material.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  final searchController = TextEditingController();

  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Amit Sharma',
      'id': 'D001',
      'specialization': 'Cardiologist',
      'phone': '9876543210',
    },
    {
      'name': 'Dr. Priya Singh',
      'id': 'D002',
      'specialization': 'Dermatologist',
      'phone': '9876543211',
    },
    {
      'name': 'Dr. Rahul Verma',
      'id': 'D003',
      'specialization': 'Neurologist',
      'phone': '9876543212',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void addDoctor() {
    final nameController = TextEditingController();
    final specializationController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151515),
          title: const Text('Add New Doctor'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Doctor Name'),
                ),
                TextField(
                  controller: specializationController,
                  decoration: const InputDecoration(
                    labelText: 'Specialization',
                  ),
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
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
                    specializationController.text.trim().isEmpty ||
                    phoneController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                setState(() {
                  doctors.add({
                    'name': nameController.text.trim(),
                    'id': 'D${(doctors.length + 1).toString().padLeft(3, '0')}',
                    'specialization': specializationController.text.trim(),
                    'phone': phoneController.text.trim(),
                  });
                });

                Navigator.pop(dialogContext);
                nameController.dispose();
                specializationController.dispose();
                phoneController.dispose();
              },
              child: const Text('Save Doctor'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors = doctors.where((doctor) {
      final query = searchController.text.toLowerCase();

      return doctor['name']!.toLowerCase().contains(query) ||
          doctor['specialization']!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctors'),
        backgroundColor: const Color(0xFF151515),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addDoctor,
        backgroundColor: const Color(0xFFE50914),
        icon: const Icon(Icons.person_add),
        label: const Text('Add Doctor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search doctor or specialization',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: filteredDoctors.isEmpty
                  ? const Center(child: Text('No doctors found'))
                  : ListView.builder(
                      itemCount: filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = filteredDoctors[index];

                        return Card(
                          color: const Color(0xFF151515),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFFE50914),
                              child: Icon(
                                Icons.medical_services,
                                color: Colors.white,
                              ),
                            ),
                            title: Text(
                              doctor['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'ID: ${doctor['id']}\n${doctor['specialization']}\nPhone: ${doctor['phone']}',
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
