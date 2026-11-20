import 'package:flutter/material.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final List<Map<String, String>> appointments = [
    {
      'patient': 'Rahul Sharma',
      'doctor': 'Dr. Amit Sharma',
      'date': '05 Nov 2026',
      'time': '10:00 AM',
      'status': 'Confirmed',
    },
    {
      'patient': 'Priya Singh',
      'doctor': 'Dr. Priya Singh',
      'date': '05 Nov 2026',
      'time': '11:30 AM',
      'status': 'Pending',
    },
  ];

  final patientController = TextEditingController();
  final doctorController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    patientController.dispose();
    doctorController.dispose();
    super.dispose();
  }

  Future<void> addAppointment() async {
    patientController.clear();
    doctorController.clear();

    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF151515),
              title: const Text('New Appointment'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: patientController,
                      decoration: const InputDecoration(
                        labelText: 'Patient Name',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    TextField(
                      controller: doctorController,
                      decoration: const InputDecoration(
                        labelText: 'Doctor Name',
                        prefixIcon: Icon(Icons.medical_services),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_month),
                      title: const Text('Appointment Date'),
                      subtitle: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      ),
                      onTap: () async {
                        final date = await showDatePicker(
                          context: dialogContext,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );

                        if (date != null) {
                          setDialogState(() => selectedDate = date);
                        }
                      },
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.access_time),
                      title: const Text('Appointment Time'),
                      subtitle: Text(selectedTime.format(context)),
                      onTap: () async {
                        final time = await showTimePicker(
                          context: dialogContext,
                          initialTime: selectedTime,
                        );

                        if (time != null) {
                          setDialogState(() => selectedTime = time);
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext, false),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (patientController.text.trim().isEmpty ||
                        doctorController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(this.context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter patient and doctor name'),
                        ),
                      );
                      return;
                    }

                    Navigator.pop(dialogContext, true);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == true) {
      setState(() {
        appointments.add({
          'patient': patientController.text.trim(),
          'doctor': doctorController.text.trim(),
          'date':
              '${selectedDate.day} ${_monthName(selectedDate.month)} ${selectedDate.year}',
          'time': selectedTime.format(context),
          'status': 'Pending',
        });
      });
    }
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: const Color(0xFF151515),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: addAppointment,
        backgroundColor: const Color(0xFFE50914),
        icon: const Icon(Icons.add),
        label: const Text('Book Appointment'),
      ),
      body: appointments.isEmpty
          ? const Center(child: Text('No appointments available'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];

                return Card(
                  color: const Color(0xFF151515),
                  margin: const EdgeInsets.only(bottom: 14),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color(0xFF2979FF),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                appointment['patient']!,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              appointment['status']!,
                              style: TextStyle(
                                color: appointment['status'] == 'Confirmed'
                                    ? Colors.greenAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 25),
                        Text('Doctor: ${appointment['doctor']}'),
                        const SizedBox(height: 8),
                        Text('Date: ${appointment['date']}'),
                        const SizedBox(height: 8),
                        Text('Time: ${appointment['time']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
