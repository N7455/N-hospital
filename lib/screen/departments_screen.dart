
import 'package:flutter/material.dart';

class DepartmentsScreen extends StatefulWidget {
  const DepartmentsScreen({super.key});

  @override
  State<DepartmentsScreen> createState() => _DepartmentsScreenState();
}

class _DepartmentsScreenState extends State<DepartmentsScreen> {
  final List<Map<String, String>> departments = [
    {'name': 'Cardiology', 'head': 'Dr. Amit Sharma'},
    {'name': 'Neurology', 'head': 'Dr. Rahul Verma'},
    {'name': 'Orthopedics', 'head': 'Dr. Raj Malhotra'},
    {'name': 'Dermatology', 'head': 'Dr. Priya Singh'},
    {'name': 'Pediatrics', 'head': 'Dr. Neha Gupta'},
    {'name': 'Emergency', 'head': 'Dr. Anil Kumar'},
  ];

  final nameController = TextEditingController();
  final headController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    headController.dispose();
    super.dispose();
  }

  void addDepartment() {
    nameController.clear();
    headController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151515),
          title: const Text('Add Department'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Department Name',
                  prefixIcon: Icon(Icons.apartment),
                ),
              ),
              TextField(
                controller: headController,
                decoration: const InputDecoration(
                  labelText: 'Department Head',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty ||
                    headController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill all fields'),
                    ),
                  );
                  return;
                }

                setState(() {
                  departments.add({
                    'name': nameController.text.trim(),
                    'head': headController.text.trim(),
                  });
                });

                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
        backgroundColor: const Color(0xFF151515),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addDepartment,
        backgroundColor: const Color(0xFFE50914),
        icon: const Icon(Icons.add),
        label: const Text('Add Department'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: departments.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.15,
        ),
        itemBuilder: (context, index) {
          final department = departments[index];

          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF151515),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xFF2979FF).withOpacity(0.5),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.local_hospital,
                  color: Color(0xFFE50914),
                  size: 35,
                ),
                const SizedBox(height: 12),
                Text(
                  department['name']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  department['head']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
