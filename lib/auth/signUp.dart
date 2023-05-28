import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicare/auth/loginScreen.dart';
import 'package:medicare/screens/home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late bool errorvisible = false;

  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _numberphoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future signUp() async {
    bool passwordConfirmed() {
      if (_passwordController.text.trim() ==
          _confirmPasswordController.text.trim()) {
        return true;
      } else {
        return false;
      }
    }

    final FirebaseAuth _auth = FirebaseAuth.instance;
    CollectionReference userref =
        FirebaseFirestore.instance.collection('customUsers');
    if (passwordConfirmed()) {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      userref.add({
        "uid": result.user?.uid,
        'name': _nameController.text,
        'number': _numberphoneController.text,
        'role': "user",
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      setState(() {
        errorvisible = true;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _numberphoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 60,
                        left: 20,
                        width: 100,
                        height: 200,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/cat.png'))),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 140,
                        width: 120,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/images/dog.png"))),
                        ),
                      ),
                      Positioned(
                        top: 18,
                        left: 140,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/dog_rotate.png"))),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        top: 120,
                        width: 80,
                        height: 150,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/cat.png'))),
                        ),
                      ),
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Text(
                              "إنشاء حساب",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromRGBO(143, 148, 251, .2),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 54,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: _emailController,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "ادخل البريد الاليكترونى",
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              height: 54,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: _nameController,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "الإسم ثلاثي",
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              height: 54,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: _numberphoneController,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "رقم الهاتف",
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              height: 54,
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(color: Colors.grey))),
                              child: TextField(
                                controller: _passwordController,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "الرقم السري",
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey[400])),
                              ),
                            ),
                            Container(
                              height: 54,
                              padding: EdgeInsets.all(8.0),
                              child: TextField(
                                controller: _confirmPasswordController,
                                textAlign: TextAlign.right,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "تأكيد الرقم السري",
                                    hintStyle: TextStyle(
                                        fontSize: 14, color: Colors.grey[400])),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: errorvisible,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "كلمة السر غير متطابقان",
                              style: TextStyle(
                                  color: Color.fromRGBO(209, 0, 0, 1)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: signUp,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: const [
                                Color.fromRGBO(23, 128, 4, 1),
                                Color.fromRGBO(51, 223, 0, .6),
                              ])),
                          child: Center(
                            child: Text(
                              "إنشاء",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginScreen()),
                          );
                        },
                        child: Text(
                          " لديك حساب ؟",
                          style:
                              TextStyle(color: Color.fromRGBO(23, 128, 4, 1)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
