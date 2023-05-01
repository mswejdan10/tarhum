import 'package:flutter/material.dart';
import 'package:medicare/screens/NavBar.dart';
import 'package:medicare/styles/colors.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

List<Map> schedulesusers = [
  {
    'id': 1,
    'img': 'assets/doctors/doctor03.jpeg',
    'userName': ' فهد العتيبي',
    'numberPhone': '0521321543',
    'address': 'الطائف',
    'email': 'ffff@gmail.com',
  },
  {
    'id': 2,
    'img': 'assets/doctors/doctor02.png',
    'userName': ' على مرزوق',
    'numberPhone': '0512123231',
    'address': 'تابوك',
    'email': 'ffff@gmail.com',
  },
  {
    'id': 3,
    'img': 'assets/doctors/doctor04.jpeg',
    'userName': 'سحر ماجد',
    'numberPhone': '0520999983',
    'address': 'جدة',
    'email': 'ffff@gmail.com',
  },
  {
    'id': 4,
    'img': 'assets/doctors/doctor04.jpeg',
    'userName': ' أحلام المطيري',
    'numberPhone': '0521534233',
    'address': 'مكة',
    'email': 'ffff@gmail.com',
  },
  {
    'id': 5,
    'img': 'assets/doctors/doctor01.jpeg',
    'userName': 'سعيد عبدالله',
    'numberPhone': '0521321543',
    'address': 'الرياض',
    'email': 'ffff@gmail.com',
  },
];

class _UsersState extends State<Users> {
  final Alignment _alignment = Alignment.centerLeft;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Map> filteredSchedules = schedulesusers.where((var schedule) {
      return schedule['id'] != null;
    }).toList();

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          key: scaffoldKey,
          drawer: const NavBar(),
          body: Padding(
            padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(MyColors.bg),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      scaffoldKey.currentState!.openDrawer();
                                    },
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/person.jpg'),
                                    ),
                                  ),
                                  Spacer(),
                                  Text("كل المستخدمين",
                                      style: TextStyle(
                                          color: Color(
                                              MyColors.kprimaryButtonsColor),
                                          fontWeight: FontWeight.w800)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredSchedules.length,
                    itemBuilder: (context, index) {
                      var _schedule = filteredSchedules[index];
                      bool isLastElement =
                          filteredSchedules.length + 1 == index;
                      return Card(
                        margin: !isLastElement
                            ? EdgeInsets.only(bottom: 20)
                            : EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        AssetImage(_schedule['img']),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        _schedule['userName'],
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(MyColors.header01),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 50),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'رقم الهاتف : ${_schedule['numberPhone']}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Text(
                                      'العنوان :  ${_schedule['address']}',
                                      style: TextStyle(
                                          color: Color(MyColors.grey02)),
                                    ),
                                    Text(
                                      'البريد : ${_schedule['email']}',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  const DateTimeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                '11:00 ~ 12:10',
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.access_alarm,
                color: Color(MyColors.primary),
                size: 17,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'الاحد, مارس 29',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.calendar_today,
                color: Color(MyColors.primary),
                size: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
