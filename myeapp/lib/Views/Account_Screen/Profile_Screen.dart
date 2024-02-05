import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:myeapp/Controllers/Auth_Controller.dart';
import 'package:myeapp/Controllers/ProfileController.dart';
import 'package:myeapp/Services/FireStore_Services.dart';
import 'package:myeapp/Views/Account_Screen/Components/Details_Screenscard.dart';
import 'package:myeapp/Views/Account_Screen/Edit_Profile_Screen.dart';
import 'package:myeapp/Views/auth_Screen/login_Screen.dart';
import 'package:myeapp/WidgetsCommon/bg_widget.dart';
import 'package:myeapp/WidgetsCommon/our_button.dart';
import 'package:myeapp/consts/consts.dart';
import 'package:myeapp/consts/lists.dart';

class ProfileScreen extends StatelessWidget {
  final dynamic data;
  const ProfileScreen({Key? key, this.data}):super(key:key);

  @override
  Widget build(BuildContext context) {
    var controller =  Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(

      body: StreamBuilder(stream: FirestoreServices.getUser(currentuser!.uid),
       builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot)
       {
        if(!snapshot.hasData){
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        }else{
          var data=snapshot.data!.docs[0];
          return
          SafeArea(
          child: Column(
        children: [
          ///edit profile buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Align(
              alignment: Alignment.topRight,
              child: Icon(
                 Icons.edit,
                color: whiteColor,
               
              ),
            ).onTap(() {
              
              controller.namecontroller.text=data['name'];
              // controller.passcontroller.text=data['password'];
              Get.to(()=>EditProfileScreen(data: data,));}),
          ),

          ///user details section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               data['imageurl']==''?
               
                Image.asset(
                  imgProfile2,
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make():Image.network(
                  data['imageurl'],
                  width: 100,
                  fit: BoxFit.cover,
                ).box.roundedFull.clip(Clip.antiAlias).make(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "${data['name']}".text.white.make(),
                      20.widthBox,
                      "${data['email']}".text.white.size(8).make(),
                    ],
                  ).box.width(context.screenWidth * 0.3).make(),
                ),
                5.widthBox,
                OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide(color: whiteColor)),
                    onPressed: () async {
                        await Get.put(AuthController()).SignoutMethod(context: context);
                        Get.offAll(()=>Login_Screen());
                    },
                    child: "logout".text.white.make()),
              ],
            ),
          ),
          5.heightBox,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Details_screens_card(
                  Count: "${data['cart_count']}",
                  title: "In your Cart",
                  width: (context.screenWidth / 3.5)),
              Details_screens_card(
                Count: "${data['wishlist_count']}",
                title: "in your wishlist",
                width: (context.screenWidth / 3.5),
              ),
              Details_screens_card(
                Count: "${data['order_count']}",
                title: "in your Orders",
                width: (context.screenWidth / 3.5),
              ),
            ],
          ),

          ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      title: ProfileList[index]
                          .text
                          .fontFamily(bold)
                          .color(darkFontGrey)
                          .make(),
                      leading: Image.asset(
                        ProfileIcons[index],
                        height: 20,
                        width: 20,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: darkFontGrey,
                    );
                  },
                  itemCount: ProfileList.length)
              .box
              .color(lightGrey)
              .padding(EdgeInsets.symmetric(horizontal: 16))
              .rounded
              .margin(EdgeInsets.all(12))
              .shadowSm
              .make()
              .box
              .color(redColor)
              .make()
        ],
      ));
        }
       })
    ));
  }
}
