import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myeapp/Controllers/ProfileController.dart';
import 'package:myeapp/WidgetsCommon/bg_widget.dart';
import 'package:myeapp/WidgetsCommon/custom_textfiel.dart';
import 'package:myeapp/WidgetsCommon/our_button.dart';
import 'package:myeapp/consts/consts.dart';
import 'package:myeapp/consts/images.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({Key? key, this.data}): super (key:key);

  @override
  Widget build(BuildContext context) {
    
    var controller =  Get.find<ProfileController>();
    
    return  bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Obx(()=>
           Column(
            mainAxisSize: MainAxisSize.min,
           children: [
          data['imageurl']==''&& controller.profileImgPath.isEmpty ?  Image.asset(
                  imgProfile2,
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make():
                data['imageurl']!=''&&controller.profileImgPath.isEmpty?
                Image.network(data['imageurl'], width: 100,
                  fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make():
                Image.file(File(controller.profileImgPath.value),width: 100,).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                ourbuttom(
                  color: redColor,onPress: (){
                 controller.changeimage(context);
                  },textcolor: whiteColor,title: "Change"
                ),
                Divider(),
                20.heightBox,
                cunstomTextField(
                  controller: controller.namecontroller,
                  hint: nameHint,
                  isPass: false,
                  title: name,
                ),
                10.heightBox,
                cunstomTextField(
                  controller: controller.oldpasscontroller,
                  hint: passwordHint,
                  isPass: true,
                  title: oldpass,
                ),
                10.heightBox,
                 cunstomTextField(
                  controller: controller.newpasscontroller,
                  hint: passwordHint,
                  isPass: true,
                  title: newpass,
                ),
                20.heightBox,
                controller.isloading.value?CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ):  SizedBox(
                    width: context.screenWidth - 40,
                    child: ourbuttom(
                    color: redColor,onPress: () async {
                      controller.isloading(true);


                      if(controller.profileImgPath.value.isNotEmpty){
                        await controller.uploadProfileimage();
                      }else{
                        controller.profileimagelink=data['imageurl'];
                      }
                     if(data['password']==controller.oldpasscontroller.text){
                    await  controller.changeAuthPassword(
                      email: data['email'],
                      password: controller.oldpasscontroller.text,
                      newpassword: controller.newpasscontroller.text
                    );
                       await controller.updateProfile(
                      imgUrl: controller.profileimagelink,
                      name: controller.namecontroller.text,
                      password: controller.newpasscontroller.text
                     );
                      VxToast.show(context, msg: "Updated");
                     }else{
                      VxToast.show(context, msg: "Wrong Old Password Please try again");
                      controller.isloading(false);
                     }
                    
                    
                    },textcolor: whiteColor,title: "Save"
                                  ),
                  ),
           ],
          ).box.white.padding(EdgeInsets.all(16)).rounded.margin(EdgeInsets.only(top: 50,left: 12,right: 12)).shadowSm.make(),
        ),
      )
    );
  }
}