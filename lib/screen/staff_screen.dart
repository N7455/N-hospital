import 'package:flutter/material.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final searchController = TextEditingController();

  final List<Map<String, String>> staffMembers = [
    {
      'name': 'Anjali Sharma',
      'id': 'S001',
      'role': 'Nurse',
      'phone': '9876543210',
    },
    {
      'name': 'Rohit Kumar',
      'id': 'S002',
      'role': 'Receptionist',
      'phone': '9876543211',
    },
    {
      'name': 'Neha Verma',
      'id': 'S003',
      'role': 'Lab Technician',
      'phone': '9876543212',
    },
  ];

  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    nameController.dispose();
    roleController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void addStaff() {
    nameController.clear();
    roleController.clear();
    phoneController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151515),
          title: const Text('Add Staff Member'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Staff Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                TextField(
                  controller: roleController,
                  decoration: const InputDecoration(
                    labelText: 'Staff Role',
                    prefixIcon: Icon(Icons.work),
                  ),
                ),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
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
                    roleController.text.trim().isEmpty ||
                    phoneController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                setState(() {
                  staffMembers.add({
                    'name': nameController.text.trim(),
                    'id':
                        'S${(staffMembers.length + 1).toString().padLeft(3, '0')}',
                    'role': roleController.text.trim(),
                    'phone': phoneController.text.trim(),
                  });
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Save Staff'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredStaff = staffMembers.where((staff) {
      final query = searchController.text.toLowerCase();

      return staff['name']!.toLowerCase().contains(query) ||
          staff['role']!.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hospital Staff'),
        backgroundColor: const Color(0xFF151515),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addStaff,
        backgroundColor: const Color(0xFFE50914),
        icon: const Icon(Icons.person_add),
        label: const Text('Add Staff'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search staff by name or role',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: filteredStaff.isEmpty
                  ? const Center(child: Text('No staff found'))
                  : ListView.builder(
                      itemCount: filteredStaff.length,
                      itemBuilder: (context, index) {
                        final staff = filteredStaff[index];

                        return Card(
                          color: const Color(0xFF151515),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const CircleAvatar(
                              backgroundColor: Color(0xFF2979FF),
                              child: Icon(Icons.badge, color: Colors.white),
                            ),
                            title: Text(
                              staff['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'ID: ${staff['id']}\nRole: ${staff['role']}\nPhone: ${staff['phone']}',
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
