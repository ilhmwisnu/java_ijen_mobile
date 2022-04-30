import 'package:flutter/material.dart';
import 'package:java_ijen_mobile/utils/auth.dart';

class ProfilePage extends StatefulWidget {
  UserData userData;
  ProfilePage({Key? key, required this.userData}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profile Page"),
    );
  }
}
