
// import 'package:flutter/material.dart';

// import 'patients_screen.dart';
// import 'doctors_screen.dart';
// import 'appointments_screen.dart';
// import 'departments_screen.dart';
// import 'staff_screen.dart';
// import 'billing_screen.dart';
// import 'reports_screen.dart';

// class DashboardScreen extends StatelessWidget {
//   const DashboardScreen({super.key});

//   final List<Map<String, dynamic>> modules = const [
//     {
//       'title': 'Patients',
//       'icon': Icons.people_alt_outlined,
//       'color': Color(0xFF2979FF),
//     },
//     {
//       'title': 'Doctors',
//       'icon': Icons.medical_services_outlined,
//       'color': Color(0xFFE50914),
//     },
//     {
//       'title': 'Appointments',
//       'icon': Icons.calendar_month_outlined,
//       'color': Color(0xFF00BFA5),
//     },
//     {
//       'title': 'Departments',
//       'icon': Icons.apartment_outlined,
//       'color': Color(0xFFFF9800),
//     },
//     {
//       'title': 'Staff',
//       'icon': Icons.badge_outlined,
//       'color': Color(0xFF9C27B0),
//     },
//     {
//       'title': 'Billing',
//       'icon': Icons.receipt_long_outlined,
//       'color': Color(0xFF4CAF50),
//     },
//     {
//       'title': 'Reports',
//       'icon': Icons.bar_chart_outlined,
//       'color': Color(0xFF00BCD4),
//     },
//   ];

//   void openModule(BuildContext context, int index) {
//     final screens = [
//       const PatientsScreen(),
//       const DoctorsScreen(),
//       const AppointmentsScreen(),
//       const DepartmentsScreen(),
//       const StaffScreen(),
//       const BillingScreen(),
//       const ReportsScreen(),
//     ];

//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => screens[index],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'N Hospital',
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         backgroundColor: const Color(0xFF151515),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.notifications_outlined),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout),
//             onPressed: () {
//               Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 '/',
//                 (route) => false,
//               );
//             },
//           ),
//         ],
//       ),

//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Welcome to N Hospital',
//                 style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 8),

//               const Text(
//                 'Manage your hospital activities easily.',
//                 style: TextStyle(color: Colors.white70),
//               ),

//               const SizedBox(height: 25),

//               Row(
//                 children: [
//                   _buildSummaryCard(
//                     'Patients',
//                     '120',
//                     Icons.people,
//                     const Color(0xFF2979FF),
//                   ),
//                   const SizedBox(width: 12),
//                   _buildSummaryCard(
//                     'Doctors',
//                     '18',
//                     Icons.medical_services,
//                     const Color(0xFFE50914),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 12),

//               Row(
//                 children: [
//                   _buildSummaryCard(
//                     'Appointments',
//                     '35',
//                     Icons.calendar_month,
//                     const Color(0xFF00BFA5),
//                   ),
//                   const SizedBox(width: 12),
//                   _buildSummaryCard(
//                     'Departments',
//                     '8',
//                     Icons.apartment,
//                     const Color(0xFFFF9800),
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),

//               const Text(
//                 'Hospital Management',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),

//               const SizedBox(height: 15),

//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemCount: modules.length,
//                 gridDelegate:
//                     const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 14,
//                   mainAxisSpacing: 14,
//                   childAspectRatio: 1.3,
//                 ),
//                 itemBuilder: (context, index) {
//                   final module = modules[index];

//                   return Container(
//                     decoration: BoxDecoration(
//                       color: const Color(0xFF151515),
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(
//                         color: (module['color'] as Color).withOpacity(0.5),
//                       ),
//                     ),
//                     child: InkWell(
//                       borderRadius: BorderRadius.circular(15),
//                       onTap: () => openModule(context, index),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             module['icon'] as IconData,
//                             color: module['color'] as Color,
//                             size: 38,
//                           ),

//                           const SizedBox(height: 12),

//                           Text(
//                             module['title'] as String,
//                             style: const TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSummaryCard(
//     String title,
//     String count,
//     IconData icon,
//     Color color,
//   ) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: const Color(0xFF151515),
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(icon, color: color, size: 28),
//             const SizedBox(height: 12),
//             Text(
//               count,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               title,
//               style: const TextStyle(color: Colors.white70),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }






























import 'package:flutter/material.dart';

import 'patients_screen.dart';
import 'doctors_screen.dart';
import 'appointments_screen.dart';
import 'departments_screen.dart';
import 'staff_screen.dart';
import 'billing_screen.dart';
import 'reports_screen.dart';
import 'notifications_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  final List<Map<String, dynamic>> modules = const [
    {
      'title': 'Patients',
      'icon': Icons.people_alt_outlined,
      'color': Color(0xFF2979FF),
    },
    {
      'title': 'Doctors',
      'icon': Icons.medical_services_outlined,
      'color': Color(0xFFE50914),
    },
    {
      'title': 'Appointments',
      'icon': Icons.calendar_month_outlined,
      'color': Color(0xFF00BFA5),
    },
    {
      'title': 'Departments',
      'icon': Icons.apartment_outlined,
      'color': Color(0xFFFF9800),
    },
    {
      'title': 'Staff',
      'icon': Icons.badge_outlined,
      'color': Color(0xFF9C27B0),
    },
    {
      'title': 'Billing',
      'icon': Icons.receipt_long_outlined,
      'color': Color(0xFF4CAF50),
    },
    {
      'title': 'Reports',
      'icon': Icons.bar_chart_outlined,
      'color': Color(0xFF00BCD4),
    },
  ];

  void openModule(BuildContext context, int index) {
    final screens = [
      const PatientsScreen(),
      const DoctorsScreen(),
      const AppointmentsScreen(),
      const DepartmentsScreen(),
      const StaffScreen(),
      const BillingScreen(),
      const ReportsScreen(),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screens[index],
      ),
    );
  }

  void openNotifications(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF080808),

      appBar: AppBar(
        title: const Text(
          'N Hospital',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF151515),

        actions: [
          // Notification Bell with Red Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              IconButton(
                tooltip: 'Notifications',
                icon: const Icon(
                  Icons.notifications_outlined,
                  size: 27,
                ),
                onPressed: () {
                  openNotifications(context);
                },
              ),

              Positioned(
                right: 8,
                top: 7,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE50914),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Logout Button
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/',
                (route) => false,
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to N Hospital',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Manage your hospital activities easily.',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 25),

              // Summary Cards
              Row(
                children: [
                  _buildSummaryCard(
                    'Patients',
                    '120',
                    Icons.people,
                    const Color(0xFF2979FF),
                  ),

                  const SizedBox(width: 12),

                  _buildSummaryCard(
                    'Doctors',
                    '18',
                    Icons.medical_services,
                    const Color(0xFFE50914),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  _buildSummaryCard(
                    'Appointments',
                    '35',
                    Icons.calendar_month,
                    const Color(0xFF00BFA5),
                  ),

                  const SizedBox(width: 12),

                  _buildSummaryCard(
                    'Departments',
                    '8',
                    Icons.apartment,
                    const Color(0xFFFF9800),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              const Text(
                'Hospital Management',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              // Management Modules
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: modules.length,

                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 1.3,
                ),

                itemBuilder: (context, index) {
                  final module = modules[index];

                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF151515),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: (module['color'] as Color)
                            .withValues(alpha: 0.5),
                      ),
                    ),

                    child: InkWell(
                      borderRadius: BorderRadius.circular(15),

                      onTap: () {
                        openModule(context, index);
                      },

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            module['icon'] as IconData,
                            color: module['color'] as Color,
                            size: 38,
                          ),

                          const SizedBox(height: 12),

                          Text(
                            module['title'] as String,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String count,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(14),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),

            const SizedBox(height: 12),

            Text(
              count,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
