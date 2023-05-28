import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicare/components/defaultTextField.dart';
import 'package:medicare/controller/firebase_data.dart';
import 'package:medicare/screens/home.dart';
import 'package:medicare/styles/colors.dart';

class RequestToCreateDoctor extends StatefulWidget {
  const RequestToCreateDoctor({Key? key}) : super(key: key);

  @override
  State<RequestToCreateDoctor> createState() => _RequestToCreateDoctorState();
}

class _RequestToCreateDoctorState extends State<RequestToCreateDoctor> {
  final name = TextEditingController();
  final numberPhone = TextEditingController();
  final address = TextEditingController();

  Future createClinic() async {
    CollectionReference userref =
        FirebaseFirestore.instance.collection('doctors');
    userref.add({
      "userId": currentUser.uid,
      'name': name.text,
      'number_phone': numberPhone.text,
      'address': numberPhone.text,
      'doctors_acceptance': false,
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  var _image;
  var imagepicker;

  @override
  void initState() {
    imagepicker = ImagePicker();
    super.initState();
  }

  @override
  void dispose() {
    name.dispose();
    numberPhone.dispose();
    address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size ksize = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50.sp,
              ),
              Text(
                "طلب التقديم كطبيب",
                style: TextStyle(
                    fontSize: 18.sp,
                    color: Color(MyColors.text01),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.sp,
              ),
              defaultFormField(
                borderradius: 50,
                hintText: "الإسم ثلاثي",
                controller: name,
                fontsize: 18,
                type: TextInputType.name,
                contentPaddinghorizontal: 20,
                contentPaddingvertical: 10,
                onSaved: (newValue) => newValue!,
              ),
              SizedBox(
                height: 15.sp,
              ),
              defaultFormField(
                borderradius: 8,
                hintText: "العنوان",
                controller: address,
                fontsize: 18,
                type: TextInputType.name,
                contentPaddinghorizontal: 20,
                contentPaddingvertical: 10,
                onSaved: (newValue) => newValue!,
              ),
              SizedBox(
                height: 15.sp,
              ),
              defaultFormField(
                borderradius: 8,
                hintText: "رقم الهاتف",
                controller: numberPhone,
                fontsize: 18,
                type: TextInputType.name,
                contentPaddinghorizontal: 20,
                contentPaddingvertical: 10,
                onSaved: (newValue) => newValue!,
              ),
              SizedBox(
                height: 15.sp,
              ),
              SizedBox(
                width: ksize.width * 0.9,
                child: IconButton(
                  onPressed: () async {
                    XFile? image = await imagepicker.pickImage(
                        source: ImageSource.gallery);
                    setState(
                      () {
                        if (image != null) {
                          _image = File(image.path);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("No Image Selected")));
                        }
                      },
                    );
                  },
                  icon: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.camera_alt_outlined),
                      SizedBox(
                        width: 15,
                      ),
                      Text("إدخل صورتك الشخصية")
                    ],
                  ),
                ),
              ),
              _image != null
                  ? Image.file(
                      _image,
                      width: 100,
                      height: 100,
                    )
                  : SizedBox(
                      width: 0,
                    ),
              SizedBox(
                height: 50.sp,
              ),
              GestureDetector(
                onTap: createClinic,
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
                      "تقديم الطلب",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
