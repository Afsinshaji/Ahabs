import 'dart:developer';

import 'package:ahbas/data/profile/add_profile_pic_service.dart';
import 'package:ahbas/data/profile/current_user.dart';
import 'package:ahbas/data/profile/edit_profile_service.dart';
import 'package:ahbas/data/search/all_user_service.dart';
import 'package:ahbas/data/services/socket_io/socket_io.dart';
import 'package:ahbas/data/verify_phone/verify_phone_service.dart';
import 'package:ahbas/model/profile/edit_profile/edit_profile.dart';
import 'package:ahbas/provider/verify_email/verify_email_provider.dart';
import 'package:ahbas/view/register_page/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPhonePage extends StatefulWidget {
  const RegisterPhonePage({super.key, required this.registercurntIndex});
  final ValueNotifier<int> registercurntIndex;

  @override
  State<RegisterPhonePage> createState() => _RegisterPhonePageState();
}

class _RegisterPhonePageState extends State<RegisterPhonePage> {
  @override
  void initState() {
    log('heyyyyyy');
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController dobcontroller = TextEditingController();
    TextEditingController namecontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    TextEditingController conpasswordcontroller = TextEditingController();
    String gender = "male";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                widget.registercurntIndex.value = 0;
                print(widget.registercurntIndex.value);
              });
            },
            icon: const Icon(Icons.close)),
        TextFealdAndHeading(
            controller: emailcontroller,
            heading: 'Enter Active Mobile Number',
            hintText: '+91',
            icon: Icons.phone_android,
            inputType: TextInputType.phone,
            obscureText: false),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: Container(
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  shape: const MaterialStatePropertyAll(
                      ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)))),
                  backgroundColor:
                      const MaterialStatePropertyAll(Color(0xff449cc0)),
                  elevation: const MaterialStatePropertyAll(5),
                  foregroundColor: const MaterialStatePropertyAll(Colors.white),
                  textStyle: MaterialStatePropertyAll(GoogleFonts.poppins())),
              child: const Text("Verify"),
            ),
          ),
        ),
        TextFealdAndHeading(
            controller: dobcontroller,
            heading: 'Enter Your Birth Date',
            icon: Icons.calendar_month,
            hintText: "YYYY  MM  DD",
            inputType: TextInputType.datetime,
            obscureText: false),
        TextFealdAndHeading(
            controller: namecontroller,
            heading: 'Enter Profile Name',
            icon: Icons.person,
            hintText: "Name",
            inputType: TextInputType.name,
            obscureText: false),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: Text(
            'Enter Your Genders',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: const DropdownMenuExample(),
        ),
        TextFealdAndHeading(
            controller: passwordcontroller,
            heading: "Enter Your Password",
            icon: Icons.lock,
            hintText: "password",
            inputType: TextInputType.visiblePassword,
            obscureText: true),
        TextFealdAndHeading(
            controller: conpasswordcontroller,
            heading: "RE Enter Password",
            icon: Icons.lock,
            hintText: "RE Enter password",
            inputType: TextInputType.visiblePassword,
            obscureText: true),
        Padding(
          padding: EdgeInsets.only(left: 70.w, bottom: 10.h, top: 20.h),
          child: SizedBox(
            width: 200.w,
            height: 50.h,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: const MaterialStatePropertyAll(
                        ContinuousRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                    backgroundColor:
                        const MaterialStatePropertyAll(Color(0xff449cc0)),
                    elevation: const MaterialStatePropertyAll(5),
                    foregroundColor:
                        const MaterialStatePropertyAll(Colors.white),
                    textStyle: MaterialStatePropertyAll(GoogleFonts.poppins())),
                onPressed: () async {
                  final image = await getImageFileFromAssets('appstore.png');
                  log(image.toString());
                  await AddProfilePicService().addProfilePic(image);
                },
                child: const Text("Register")),
          ),
        )
      ],
    );
  }
}

class TextFealdAndHeading extends StatelessWidget {
  const TextFealdAndHeading({
    super.key,
    required this.heading,
    required this.icon,
    required this.hintText,
    required this.inputType,
    required this.obscureText,
    required this.controller,
  });
  final String heading;
  final IconData icon;
  final String hintText;
  final TextInputType inputType;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: Text(
            heading,
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18.sp),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30.w, bottom: 10.h),
          child: ComenFormFeild(
            controller: controller,
            hinttext: hintText,
            icon: icon,
            callback: () {},
            inputType: inputType,
            obscureText: obscureText,
          ),
        ),
      ],
    );
  }
}

class ComenFormFeild extends StatelessWidget {
  const ComenFormFeild({
    super.key,
    required this.hinttext,
    required this.icon,
    required this.callback,
    required this.inputType,
    required this.obscureText,
    required this.controller,
  });
  final String hinttext;
  final IconData icon;
  final Function() callback;
  final TextInputType inputType;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: 400.w,
      child: Stack(
        children: [
          Positioned(top: 15.h, left: 15.w, child: Icon(icon)),
          Positioned(
            child: SizedBox(
              height: 46.h,
              child: Image.asset(
                'assets/images/Group 75.png',
                height: 100.h,
              ),
            ),
          ),
          Positioned(
              left: 90.w,
              top: 15.h,
              child: SizedBox(
                height: 30,
                width: 200,
                child: TextFormField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: inputType,
                  decoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 15.sp),
                      hintText: hinttext,
                      border: InputBorder.none),
                ),
              )),
        ],
      ),
    );
  }
}
