import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:java_ijen_mobile/screen/Auth/login_screen.dart';
import 'package:java_ijen_mobile/utils/auth.dart';

import '../../../const.dart';

class ProfilePage extends StatefulWidget {
  User? user;
  UserData userData;
  void Function() reload;

  ProfilePage(
      {Key? key,
      required this.userData,
      required this.user,
      required this.reload})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  final ImagePicker _picker = ImagePicker();
  String filePath = "";

  @override
  Widget build(BuildContext context) {
    TextEditingController namaController =
        TextEditingController(text: widget.userData.name);
    TextEditingController emailController =
        TextEditingController(text: widget.userData.email);
    TextEditingController phoneNumController =
        TextEditingController(text: widget.userData.phoneNumber);

    return SingleChildScrollView(
      child: SafeArea(child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      height: 110,
                      width: double.infinity,
                      color: darkGrey,
                      alignment: Alignment.topCenter,
                      child: Container(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Text(
                            "PROFILE",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ))),
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                  )
                ],
              ),
              Positioned(
                  right: defaultPadding,
                  left: defaultPadding,
                  top: 60,
                  child: Container(
                    padding: EdgeInsets.all(defaultPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: shadow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 24),
                        (isEditing)
                            ? GestureDetector(
                                onTap: () async {
                                  try {
                                    final XFile? pickedFile = await _picker
                                        .pickImage(source: ImageSource.gallery);
                                    setState(() {
                                      filePath = pickedFile!.path;
                                    });
                                  } catch (e) {
                                    setState(() {
                                      filePath = "";
                                    });
                                  }
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(9999),
                                        image: (filePath == null ||
                                                filePath == "")
                                            ? (widget.userData.img == null ||
                                                    widget.userData.img == "")
                                                ? DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        "https://www.interskill.id/empty-photo.png"))
                                                : DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        widget.userData.img))
                                            : DecorationImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    FileImage(File(filePath))),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      bottom: 0,
                                      right: 0,
                                      left: 0,
                                      child: Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo,
                                            color: Colors.white,
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "Change photo",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                    )
                                  ],
                                ))
                            : Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: (widget.userData.img == null ||
                                              widget.userData.img == "")
                                          ? NetworkImage(
                                              "https://www.interskill.id/empty-photo.png")
                                          : NetworkImage(widget.userData.img)),
                                  color: Color.fromARGB(255, 210, 210, 210),
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                              ),
                        SizedBox(height: 24),
                        (isEditing)
                            ? SizedBox()
                            : TextButton(
                                onPressed: () {
                                  setState(() {
                                    isEditing = true;
                                  });
                                },
                                child: Text("Edit Profile")),
                        SizedBox(height: 24),
                        DisTextField(
                          enable: isEditing,
                          label: "Nama Lengkap",
                          controller: namaController,
                        ),
                        SizedBox(height: defaultPadding),
                        DisTextField(
                          enable: false,
                          label: "Email",
                          controller: emailController,
                        ),
                        SizedBox(height: defaultPadding),
                        DisTextField(
                          enable: isEditing,
                          label: "No. Handphone",
                          controller: phoneNumController,
                        ),
                        SizedBox(height: defaultPadding),
                        (isEditing)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          isEditing = false;
                                        });
                                        widget.reload();
                                      },
                                      child: Text("Batal")),
                                  SizedBox(width: 12),
                                  ElevatedButton(
                                      onPressed: () {
                                        FireAuth.addUserImg(
                                            widget.user!.uid, filePath);
                                        FireAuth.updateUserData(
                                            widget.user!.uid, {
                                          "name": namaController.text,
                                          "phoneNumber": phoneNumController.text
                                        }).then((value) {
                                          setState(() {
                                            isEditing = false;
                                          });
                                          widget.reload();
                                        });
                                      },
                                      child: Text("Simpan"))
                                ],
                              )
                            : ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 8),
                                    Text("Log Out")
                                  ],
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Yakin ingin logout dari aplikasi ?"),
                                          actions: [
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.grey)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Batal")),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.red)),
                                                onPressed: () {
                                                  FireAuth.logOut().then(
                                                      (value) => Navigator
                                                          .pushNamedAndRemoveUntil(
                                                              context,
                                                              LoginScreen
                                                                  .routeName,
                                                              (route) =>
                                                                  false));
                                                },
                                                child: Text("Logout"))
                                          ],
                                        );
                                      });
                                },
                              )
                      ],
                    ),
                  ))
            ],
          );
        },
      )),
    );
  }
}

class DisTextField extends StatefulWidget {
  String label;
  TextEditingController controller;
  bool enable;

  DisTextField(
      {Key? key,
      required this.label,
      required this.controller,
      required this.enable})
      : super(key: key);

  @override
  State<DisTextField> createState() => _DisTextFieldState();
}

class _DisTextFieldState extends State<DisTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: widget.enable,
      controller: widget.controller,
      decoration: InputDecoration(
          label: Text(widget.label),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
    );
  }
}
