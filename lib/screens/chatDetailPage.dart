import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare/controller/firebase_data.dart';
import 'package:medicare/models/chatMessageModel.dart';
import 'package:medicare/styles/colors.dart';
import 'package:intl/intl.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage(
      {Key? key,
      required this.documentId,
      required this.ConsultingId,
      this.chatName = "دكتور"})
      : super(key: key);
  final String ConsultingId;
  final String documentId;
  final String chatName;
  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  late String Useruid;
  late String Useremail;
  String rolename = "";

  String? messageContent;
  String? messageType;

  @override
  void initState() {
    super.initState();

    try {
      final user = _auth.currentUser;
      if (user != null) {
        Useruid = user.uid;
        Useremail = user.email!;
        print("Useruid $Useruid");
        print("Useremail $Useremail");
      }
    } catch (e) {
      print(e);
    }
    getRoleCurrentUser().then((rolename) {
      setState(() {
        rolename = rolename;
      });
      if (rolename == "doctor") {
        setState(() {
          messageType = 'receiver';
        });
      } else {
        setState(() {
          messageType = "sender";
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Color(MyColors.bg),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/person.jpg'),
                        ),
                      ),
                      Text(
                        widget.chatName,
                        style: TextStyle(
                            fontSize: 18, color: Color(MyColors.yellow02)),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "رجوع",
                          style: TextStyle(
                              fontSize: 14, color: Color(MyColors.purple01)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 75),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: _firestore
                                  .collection('doctors')
                                  .doc(widget.documentId)
                                  .collection('doctorConsulting')
                                  .doc(widget.ConsultingId)
                                  .collection('message')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                List<ChatMessage> messagesWidgets = [];

                                final messages = snapshot.data?.docs;
                                if (messages != null) {
                                  for (var message in messages) {
                                    final messageText = message.get('text');
                                    final messageType =
                                        message.get("messageType");

                                    DateTime now = message.get("time").toDate();
                                    DateFormat formatter =
                                        DateFormat.yMd().add_jm();
                                    String messageTime = formatter.format(now);

                                    messagesWidgets.add(
                                      ChatMessage(
                                        messageContent: messageText,
                                        messageType: messageType,
                                        messageTime: messageTime,
                                      ),
                                    );
                                  }
                                }

                                return Column(
                                  children: messagesWidgets.map((message) {
                                    return Align(
                                      alignment:
                                          (message.messageType == "sender"
                                              ? Alignment.topRight
                                              : Alignment.topLeft),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: (message.messageType ==
                                                      "sender"
                                                  ? Colors.grey.shade200
                                                  : Color(MyColors.bg01)),
                                            ),
                                            padding: EdgeInsets.all(16),
                                            child: Text(
                                              message.messageContent,
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              message.messageTime,
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 60,
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Color(MyColors.bg01),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            controller: messageTextController,
                            onChanged: (value) {
                              messageContent = value;
                            },
                            textAlign: TextAlign.end,
                            decoration: InputDecoration(
                              hintText: "  ... أكتب رسالتك",
                              hintStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            messageTextController.clear();
                            Future doctorAppointmentschat() async {
                              CollectionReference mainCollectionRef =
                                  FirebaseFirestore.instance
                                      .collection('doctors')
                                      .doc(widget.documentId)
                                      .collection('doctorConsulting')
                                      .doc(widget.ConsultingId)
                                      .collection("message");
                              DateTime now = DateTime.now();
                              Timestamp currentTimestamp =
                                  Timestamp.fromDate(now);
                              mainCollectionRef.add({
                                'messageType': messageType,
                                'text': messageContent,
                                'time': currentTimestamp,
                              });
                            }

                            doctorAppointmentschat();
                          },
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 30,
                          ),
                          backgroundColor: Color(MyColors.bg01),
                          elevation: 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
