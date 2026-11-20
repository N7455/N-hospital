
import 'package:flutter/material.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String selectedPeriod = 'Monthly';

  static const Color red = Color(0xFFE50914);
  static const Color blue = Color(0xFF2979FF);
  static const Color cardColor = Color(0xFF151515);

  final List<Map<String, dynamic>> departments = [
    {'name': 'Cardiology', 'patients': 45, 'color': Colors.red},
    {'name': 'Neurology', 'patients': 32, 'color': Colors.blue},
    {'name': 'Orthopedics', 'patients': 28, 'color': Colors.orange},
    {'name': 'Pediatrics', 'patients': 20, 'color': Colors.green},
  ];

  List<double> get revenueData {
    switch (selectedPeriod) {
      case 'Weekly':
        return [20, 35, 25, 50, 40, 65, 55];
      case 'Yearly':
        return [35, 45, 40, 60, 55, 75, 65, 80, 70, 90, 85, 100];
      default:
        return [30, 45, 35, 60, 50, 75, 65, 90, 70, 85, 60, 100];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        title: const Text(
          'Hospital Reports',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: cardColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reports & Analytics',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Monitor your hospital performance',
              style: TextStyle(color: Colors.white60),
            ),

            const SizedBox(height: 22),

            const Text(
              'Select Report Period',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            DropdownButtonFormField<String>(
              initialValue: selectedPeriod,
              dropdownColor: cardColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: cardColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: ['Weekly', 'Monthly', 'Yearly']
                  .map(
                    (period) => DropdownMenuItem(
                      value: period,
                      child: Text(period),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedPeriod = value);
                }
              },
            ),

            const SizedBox(height: 24),

            const Text(
              'Hospital Overview',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
              children: [
                statCard(
                  'Total Patients',
                  '120',
                  Icons.people_alt_outlined,
                  blue,
                  '+12 this month',
                ),
                statCard(
                  'Total Doctors',
                  '18',
                  Icons.medical_services_outlined,
                  red,
                  'Active doctors',
                ),
                statCard(
                  'Appointments',
                  '35',
                  Icons.calendar_month_outlined,
                  Colors.orange,
                  'Scheduled',
                ),
                statCard(
                  'Total Revenue',
                  '₹45,000',
                  Icons.currency_rupee,
                  Colors.green,
                  'Demo amount',
                ),
              ],
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Revenue Analytics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Revenue performance overview',
                    style: TextStyle(color: Colors.white54),
                  ),
                  const SizedBox(height: 25),

                  SizedBox(
                    height: 170,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: revenueData.map((value) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 3,
                            ),
                            child: FractionallySizedBox(
                              heightFactor: value / 100,
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: blue,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedPeriod == 'Weekly'
                            ? 'Day 1'
                            : selectedPeriod == 'Yearly'
                                ? 'Jan'
                                : 'Jan',
                        style: const TextStyle(color: Colors.white54),
                      ),
                      Text(
                        selectedPeriod == 'Weekly'
                            ? 'Day 7'
                            : selectedPeriod == 'Yearly'
                                ? 'Dec'
                                : 'Dec',
                        style: const TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Department-wise Patients',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                children: departments.map((department) {
                  final int patients = department['patients'];
                  final Color color = department['color'];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(department['name']),
                            Text(
                              '$patients Patients',
                              style: const TextStyle(
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 9),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: patients / 50,
                            minHeight: 9,
                            backgroundColor: Colors.white12,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(color),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Summary',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Paid Amount'),
                      Text(
                        '₹35,000',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pending Amount'),
                      Text(
                        '₹10,000',
                        style: TextStyle(color: Colors.orange),
                      ),
                    ],
                  ),
                  Divider(height: 28, color: Colors.white24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Revenue',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹45,000',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Center(
              child: Text(
                'N HOSPITAL • CARE • TRUST • HEALTH',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 11,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget statCard(
    String title,
    String value,
    IconData icon,
    Color color,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 27),
          const SizedBox(height: 9),
          Text(
            value,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
