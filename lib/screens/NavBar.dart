import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare/screens/home.dart';
import 'package:medicare/screens/loginScreen.dart';
import 'package:medicare/tabs/clinics/admin_clinics_requests.dart';
import 'package:medicare/tabs/doctors/admin_doctor_requests.dart';
import 'package:medicare/tabs/doctors/doctor_consultation_requests.dart';
import 'package:medicare/tabs/users.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Drawer(
          child: ListView(
            // Remove padding
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text(
                  'تراحم',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: const Text(
                  'trahum@gmail.com',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                currentAccountPicture: CircleAvatar(
                  child: ClipOval(
                    child: Image.asset(
                      'assets/trahum.jpg',
                    ),
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 151, 152, 153),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/person.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // ListTile(
              //   leading: Image.asset(
              //     'assets/massages.png',
              //     width: 30.0,
              //     fit: BoxFit.cover,
              //   ),
              //   title: const Text('رسائلي'),
              //   // onTap: () =>
              //   // Navigator.push(
              //   //   context,
              //   //   MaterialPageRoute(builder: (context) => const JobsQuestions()),
              //   // ),
              // ),
              const Divider(),
              ListTile(
                title: const Text(
                  'الأدمن',
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'assets/admin/admindoctors.png',
                  width: 30.0,
                  fit: BoxFit.cover,
                ),
                title: const Text(
                  'قبول الأطباء',
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Adminrequests()),
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'assets/admin/adminclinc.png',
                  width: 30.0,
                  fit: BoxFit.cover,
                ),
                title: const Text('قبول العيادات'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ClinicsRequests()),
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'assets/admin/adminusers.png',
                  width: 30.0,
                  fit: BoxFit.cover,
                ),
                title: const Text('إدارة المستخدمين'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Users()),
                ),
              ),
              const Divider(),
              ListTile(
                title: const Text(
                  'الطبيب',
                ),
              ),
              ListTile(
                leading: Image.asset(
                  'assets/doctors/consulting_doctor.png',
                  width: 30.0,
                  fit: BoxFit.cover,
                ),
                title: const Text(
                  'الإستشارات',
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DoctorConsultationRequests()),
                ),
              ),

              // const Divider(),
              // ListTile(
              //   leading: Image.asset(
              //     'assets/person.jpg',
              //     width: 30.0,
              //     fit: BoxFit.cover,
              //   ),
              //   title: const Text('الطبيب'),
              //   // onTap: () => Navigator.push(
              //   //   context,
              //   //   MaterialPageRoute(builder: (context) => const WelcomeChef()),
              //   // ),
              // ),
              const Divider(),
              ListTile(
                leading: Image.asset(
                  'assets/local_hospital.png',
                  width: 30.0,
                  fit: BoxFit.cover,
                ),
                title: const Text('الصفحة الرئيسية'),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                ),
              ),

              ListTile(
                  title: const Text('تسجيل الدخول'),
                  leading: Icon(
                    Icons.login_outlined,
                    size: 30.0,
                  ),
                  iconColor: Colors.green,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => loginScreen()),
                    );
                  }),
              ListTile(
                title: const Text('تسجيل الخروج'),
                leading: Icon(
                  Icons.exit_to_app,
                  size: 30.0,
                ),
                iconColor: Colors.red,
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
