

import 'package:flutter/material.dart';

class BillingScreen extends StatefulWidget {
  const BillingScreen({super.key});

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  final List<Map<String, dynamic>> bills = [
    {
      'id': 'BILL001',
      'patient': 'Rahul Sharma',
      'service': 'Consultation',
      'amount': 500,
      'status': 'Paid',
    },
    {
      'id': 'BILL002',
      'patient': 'Priya Singh',
      'service': 'Blood Test',
      'amount': 1200,
      'status': 'Pending',
    },
    {
      'id': 'BILL003',
      'patient': 'Amit Kumar',
      'service': 'X-Ray',
      'amount': 800,
      'status': 'Paid',
    },
  ];

  final patientController = TextEditingController();
  final serviceController = TextEditingController();
  final amountController = TextEditingController();

  final Color red = const Color(0xFFE50914);
  final Color blue = const Color(0xFF2979FF);

  int get totalAmount =>
      bills.fold(0, (sum, bill) => sum + (bill['amount'] as int));

  int get paidAmount => bills
      .where((bill) => bill['status'] == 'Paid')
      .fold(0, (sum, bill) => sum + (bill['amount'] as int));

  @override
  void dispose() {
    patientController.dispose();
    serviceController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void addBill() {
    patientController.clear();
    serviceController.clear();
    amountController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF151515),
        title: const Text('Add New Bill'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: patientController,
                decoration: const InputDecoration(
                  labelText: 'Patient Name',
                ),
              ),
              TextField(
                controller: serviceController,
                decoration: const InputDecoration(
                  labelText: 'Service',
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Amount (₹)',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              final amount = int.tryParse(amountController.text.trim());

              if (patientController.text.trim().isEmpty ||
                  serviceController.text.trim().isEmpty ||
                  amount == null ||
                  amount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter valid bill details'),
                  ),
                );
                return;
              }

              setState(() {
                bills.insert(0, {
                  'id': 'BILL${(bills.length + 1).toString().padLeft(3, '0')}',
                  'patient': patientController.text.trim(),
                  'service': serviceController.text.trim(),
                  'amount': amount,
                  'status': 'Pending',
                });
              });

              Navigator.pop(context);
            },
            child: const Text('Add Bill'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      appBar: AppBar(
        title: const Text('Billing Management'),
        backgroundColor: const Color(0xFF151515),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: red,
        foregroundColor: Colors.white,
        onPressed: addBill,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: summaryCard(
                    'Total Bills',
                    '${bills.length}',
                    Icons.receipt_long,
                    blue,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: summaryCard(
                    'Total Amount',
                    '₹$totalAmount',
                    Icons.currency_rupee,
                    red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            summaryCard(
              'Paid Amount',
              '₹$paidAmount',
              Icons.check_circle_outline,
              Colors.green,
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recent Bills',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: bills.length,
                itemBuilder: (context, index) {
                  final bill = bills[index];
                  final isPaid = bill['status'] == 'Paid';

                  return Card(
                    color: const Color(0xFF151515),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: blue.withValues(alpha: 0.15),
                        child: Icon(
                          Icons.receipt,
                          color: blue,
                        ),
                      ),
                      title: Text(
                        bill['patient'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${bill['id']} • ${bill['service']}',
                        style: const TextStyle(color: Colors.white60),
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '₹${bill['amount']}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            bill['status'],
                            style: TextStyle(
                              color: isPaid ? Colors.green : Colors.orange,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
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

  Widget summaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
