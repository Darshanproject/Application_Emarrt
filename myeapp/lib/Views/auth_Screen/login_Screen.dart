import 'package:myeapp/Views/auth_Screen/signup.dart';
import 'package:myeapp/WidgetsCommon/applogo_widget.dart';
import 'package:myeapp/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myeapp/HomeScreen/home.dart';
import '../../WidgetsCommon/bg_widget.dart';
import '../../WidgetsCommon/custom_textfiel.dart';
import '../../WidgetsCommon/our_button.dart';
import '../../consts/lists.dart';

class Login_Screen extends StatelessWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        children: [
          (context.screenHeight * 0.1).heightBox,
          applogoWidget(),
          10.heightBox,
          "login in to $appname".text.white.fontFamily(bold).size(24).make(),
          15.heightBox,
          Column(
            children: [
              cunstomTextField(hint: emailHint, title: email),
              cunstomTextField(hint: passwordHint, title: password),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {}, child: forgetpassword.text.make()),
              ),
              5.heightBox,
              //ourbuttom().box.width(context.screenWidth - 50).make(),
              ourbuttom(
                  color: redColor,
                  title: login,
                  textcolor: whiteColor,
                  onPress: () {
                    Get.to(() => Home());
                  }).box.white.width(context.screenWidth - 50).make(),

              5.heightBox,
              createnewaccount.text.color(fontGrey).make(),

              5.heightBox,
              ourbuttom(
                  color: lightGolden,
                  title: signup,
                  textcolor: redColor,
                  onPress: () {
                    Get.to(() => SignupScreen());
                  }).box.white.width(context.screenWidth - 50).make(),
              10.heightBox,
              loginwith.text.color(fontGrey).make(),
              5.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: lightGrey,
                            child: Image.asset(
                              socialIconList[index],
                              width: 30,
                            ),
                          ),
                        )),
              )
            ],
          )
              .box
              .white
              .rounded
              .shadowSm
              .padding(EdgeInsets.all(16))
              .width(context.screenWidth - 70)
              .make()
        ],
      )),
    ));
  }
}
