import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:track_your_bus/screens/user/user_map.dart';
import 'package:track_your_bus/screens/driver/driver_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UIScreen extends StatefulWidget {

  const UIScreen({Key? key, required this.userUID}) : super(key: key);
  final Future<String?> userUID;

  @override
  State<StatefulWidget> createState() {
    return UIScreenState();
  }
}

class UIScreenState extends State<UIScreen> {

  late String bus;
  late String institute;
  String? type;
  late String name;
  late String userID;
  late String uid;

  final List<LatLng> points = <LatLng>[];

  getUserProfile() {
    UserModel theUser;
    User user = FirebaseAuth.instance.currentUser!;
    FirebaseFirestore.instance
          .collection('users')
          .where('user_id', isEqualTo: user.uid)
          .snapshots()
          .listen((data) {
        print('getting data');
        print('data--------->>>   ${data}');
        print('data--------->>>   ${data.docs}');
        print("data---------->>>>  ${user.uid}");
        print('data--------->>>   ${data.docs[0]['bus']}');
        theUser = UserModel(bus:data.docs[0]['bus'],institute: data.docs[0]['institute'],name: data.docs[0]['name'],type: data.docs[0]['type'],uid: user.uid,user_id: FirebaseAuth.instance.currentUser!.uid,);
        print('got data');
        print("{$theUser._type}");
        setState(() {
          this.name = theUser.name;
          this.userID = theUser.user_id;
          this.bus = theUser.bus;
          this.institute = theUser.institute;
          this.bus = theUser.bus;
          this.type = theUser.type;
          this.uid = theUser.uid;
        });
      });

  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    if(this.type != null) {
      if(type == "Users") {
        print("Users");
        return UserMap(institute, bus, name, userID, uid);
      } else {
        print("Driver");
        return DriverMap(institute, bus, name, userID);
      }
    }
    return Scaffold(body: CircularProgressIndicator(),);
  }
}

class UserModel {
  String bus, institute, name, type, uid, user_id;
  UserModel({required this.bus,required this.institute,required this.name,required this.type,required this.uid,required this.user_id});
}
