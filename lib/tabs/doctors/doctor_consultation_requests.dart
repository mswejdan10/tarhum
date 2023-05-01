import 'package:flutter/material.dart';
import 'package:medicare/screens/chatDetailPage.dart';
import 'package:medicare/styles/colors.dart';

class DoctorConsultationRequests extends StatefulWidget {
  const DoctorConsultationRequests({Key? key}) : super(key: key);

  @override
  State<DoctorConsultationRequests> createState() =>
      _DoctorConsultationRequestsState();
}

enum FilterStatus {
  Upcoming,
}

List<Map> schedules = [
  {
    'img': 'assets/doctors/doctor03.jpeg',
    'doctorName': 'د. فهد العتيبي',
    'doctorTitle': 'أسنان',
    'reservedDate': 'الاحد, مارس 29',
    'masseage':
        'معنى فن العلاج؛ هو العلم الذي يجمع الخبرات الإنسانية في الإهتمام بالإنسان، وما يعتريه من اعتلال وأمراض وإصابات تنال',
  },
  {
    'img': 'assets/doctors/doctor02.png',
    'doctorName': 'د. على مرزوق',
    'doctorTitle': 'أسنان',
    'reservedDate': 'الاحد, مارس 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming,
    'masseage':
        'معنى فن العلاج؛ هو العلم الذي يجمع الخبرات الإنسانية في الإهتمام بالإنسان، وما يعتريه من اعتلال وأمراض وإصابات تنال',
  },
  {
    'img': 'assets/doctors/doctor04.jpeg',
    'doctorName': 'د. سحر ماجد',
    'doctorTitle': 'عظام',
    'reservedDate': 'الاحد, مارس 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming,
    'masseage':
        'معنى فن العلاج؛ هو العلم الذي يجمع الخبرات الإنسانية في الإهتمام بالإنسان، وما يعتريه من اعتلال وأمراض وإصابات تنال',
  },
  {
    'img': 'assets/doctors/doctor04.jpeg',
    'doctorName': 'د. أحلام المطيري',
    'doctorTitle': 'أمراض القلب',
    'reservedDate': 'الاحد, مارس 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming,
    'masseage':
        'معنى فن العلاج؛ هو العلم الذي يجمع الخبرات الإنسانية في الإهتمام بالإنسان، وما يعتريه من اعتلال وأمراض وإصابات تنال',
  },
  {
    'img': 'assets/doctors/doctor01.jpeg',
    'doctorName': 'د. سعيد عبدالله',
    'doctorTitle': 'عيون',
    'reservedDate': 'الاحد, مارس 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming,
    'masseage':
        'معنى فن العلاج؛ هو العلم الذي يجمع الخبرات الإنسانية في الإهتمام بالإنسان، وما يعتريه من اعتلال وأمراض وإصابات تنال',
  },
  {
    'img': 'assets/doctors/doctor05.jpeg',
    'doctorName': 'Dr. Sam Smithh',
    'doctorTitle': 'Other Specialist',
    'reservedDate': 'الاحد, مارس 29',
    'reservedTime': '11:00 - 12:00',
    'status': FilterStatus.Upcoming,
    'masseage':
        'معنى فن العلاج؛ هو العلم الذي يجمع الخبرات الإنسانية في الإهتمام بالإنسان، وما يعتريه من اعتلال وأمراض وإصابات تنال',
  },
];

class _DoctorConsultationRequestsState
    extends State<DoctorConsultationRequests> {
  FilterStatus status = FilterStatus.Upcoming;
  Alignment _alignment = Alignment.centerLeft;

  @override
  Widget build(BuildContext context) {
    List<Map> filteredSchedules = schedules.where((var schedule) {
      return schedule['status'] == status;
    }).toList();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Scaffold(
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
                          for (FilterStatus filterStatus in FilterStatus.values)
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (filterStatus == FilterStatus.Upcoming) {
                                      status = FilterStatus.Upcoming;
                                      _alignment = Alignment.centerLeft;
                                    }
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        child: CircleAvatar(
                                          backgroundImage:
                                              AssetImage('assets/person.jpg'),
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "طلبات الاستشارة",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Color(MyColors.yellow02)),
                                      ),
                                    ],
                                  ),
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
                                        _schedule['doctorName'],
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
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  _schedule['masseage'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      child: Text('رد'),
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return ChatDetailPage();
                                        }));
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                      child: Text('مسح'),
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Color.fromARGB(255, 243, 33, 33),
                                          shadowColor: Colors.black),
                                      onPressed: () => {},
                                    ),
                                  )
                                ],
                              )
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
