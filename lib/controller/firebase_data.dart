import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final currentUser = FirebaseAuth.instance.currentUser!;
final FirebaseAuth _auth = FirebaseAuth.instance;

getCurrentUseData() async {
  final User user = _auth.currentUser!;
  final uid = user.uid;
  final CollectionReference documentReference =
      FirebaseFirestore.instance.collection("customUsers");

  final QuerySnapshot querySnapshot =
      await documentReference.where("uid", isEqualTo: uid).get();

// Get the first document from the query results
  final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

  final String name = documentSnapshot['name'];
  return name;
}

Future<String> getRoleCurrentUser() async {
  final User user = _auth.currentUser!;
  final uid = user.uid;
  final CollectionReference documentReference =
      FirebaseFirestore.instance.collection("customUsers");

  final QuerySnapshot querySnapshot =
      await documentReference.where("uid", isEqualTo: uid).get();

// Get the first document from the query results
  final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

  final String rolename = documentSnapshot['role'];
  return rolename;
}

Future<String> getCurrentUserNumberPhone() async {
  final User user = _auth.currentUser!;
  final uid = user.uid;
  final CollectionReference documentReference =
      FirebaseFirestore.instance.collection("customUsers");

  final QuerySnapshot querySnapshot =
      await documentReference.where("uid", isEqualTo: uid).get();

  // Get the first document from the query results
  final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

  final String number = documentSnapshot['number'];

  // Return a list containing the actual values of the variables
  return number;
}

Future<String> getclinicAppointmentsDocument() async {
  final User user = _auth.currentUser!;
  final uid = user.uid;
  final CollectionReference documentReference =
      FirebaseFirestore.instance.collection("clinics");

  final QuerySnapshot querySnapshot =
      await documentReference.where("userId", isEqualTo: uid).get();

  if (querySnapshot.docs.isEmpty) {
    throw Exception("No documents found for user $uid");
  }

  final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
  final String documentId = documentSnapshot.id;
  return documentId;
}

Future<String> getdoctorConsultingDocument() async {
  final User user = _auth.currentUser!;
  final uid = user.uid;
  final CollectionReference documentReference =
      FirebaseFirestore.instance.collection("doctors");

  final QuerySnapshot querySnapshot =
      await documentReference.where("userId", isEqualTo: uid).get();

  if (querySnapshot.docs.isEmpty) {
    throw Exception("No documents found for user $uid");
  }

  final DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
  final String documentId = documentSnapshot.id;
  return documentId;
}

getCurrentUserUid() async {
  final User user = _auth.currentUser!;
  final uid = user.uid;

  return uid;
}

getCurrentEmail() async {
  final User user = _auth.currentUser!;
  final uemail = user.email;
  return uemail;
}

void getclinicData() async {
  CollectionReference cliniclist =
      FirebaseFirestore.instance.collection("clinics");
  QuerySnapshot querySnapshot = await cliniclist.get();
  List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;

  for (var element in listDocs) {
    print(element.data());
    print("--------------");
  }
}

getcliniccurrentUserData() async {
  CollectionReference cliniclist =
      FirebaseFirestore.instance.collection("clinics");
  await cliniclist
      .where("userId", isEqualTo: currentUser.uid)
      .get()
      .then((value) {
    for (var element in value.docs) {
      return element.data();
    }
  });
}
