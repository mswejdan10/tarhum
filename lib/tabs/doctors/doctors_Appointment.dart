import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicare/controller/firebase_data.dart';
import 'package:medicare/styles/colors.dart';

class ScheduleTabDoctors extends StatefulWidget {
  const ScheduleTabDoctors({Key? key}) : super(key: key);

  @override
  State<ScheduleTabDoctors> createState() => _ScheduleTabDoctorsState();
}

class _ScheduleTabDoctorsState extends State<ScheduleTabDoctors> {
  Stream<QuerySnapshot> stream = FirebaseFirestore.instance
      .collection('doctors')
      .where('doctors_acceptance', isEqualTo: true)
      .snapshots();

  String _name = '';
  @override
  void initState() {
    super.initState();
    getCurrentUseData().then((name) {
      setState(() {
        _name = name;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 41,
                  decoration: BoxDecoration(
                    color: Color(MyColors.bg),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              Text("طلب إستشارة",
                                  style: TextStyle(
                                      color: Color(MyColors.header01),
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
              child: StreamBuilder<QuerySnapshot>(
                stream: stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        Map<String, dynamic> data = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        String doctorId = snapshot.data!.docs[index].id;

                        String name = data['name'];
                        String address = data['address'];
                        // String image = data['image'];

                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    // CircleAvatar(
                                    //   child: ClipOval(
                                    //       child: Image.network(
                                    //     image,
                                    //     fit: BoxFit.cover,
                                    //   )),
                                    // ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          name,
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
                                  padding: const EdgeInsets.only(right: 30),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'عنوان الطبيب : $address',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Color(MyColors.yellow02),
                                            size: 18,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '50 - 4.0 تقييم',
                                            style: TextStyle(
                                                color: Color(MyColors.grey02)),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color(MyColors.kprimaryButtonsColor),
                                  ),
                                  child: Text('طلب استشارة'),
                                  onPressed: () {
                                    DateTime now = DateTime.now();
                                    DateTime date =
                                        DateTime(now.year, now.month, now.day);
                                    Future doctorAppointmentschat() async {
                                      CollectionReference mainCollectionRef =
                                          FirebaseFirestore.instance
                                              .collection('doctors')
                                              .doc(doctorId)
                                              .collection('doctorConsulting');

                                      mainCollectionRef.add({
                                        'acceptedChat': false,
                                        'customerName': _name,
                                        'date': date,
                                        'content': "من فضلك أريد إستشارة",
                                        'ClientId': currentUser.uid,
                                        'doctorName': name,
                                      });
                                    }

                                    doctorAppointmentschat();
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    Center(child: Text('لا يوجد عيادات'));
                  }
                  return Center(
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator()),
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
