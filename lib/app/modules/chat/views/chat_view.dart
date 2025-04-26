import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/app_color/app_colors.dart';
import '../../../../common/app_images/app_images.dart';
import '../../../../common/app_text_style/styles.dart';
import '../../../../common/size_box/custom_sizebox.dart';
import '../../../../common/widgets/custom_circular_container.dart';
import '../../../../common/widgets/custom_textfield.dart';
import 'message_view.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool showChats = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomCircularContainer(
            imagePath: AppImages.back,
            onTap: () {
              Get.back();
            },
            padding: 4,
          ),
        ),
        title: Text('Chat'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sh16,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              preIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  AppImages.search,
                  scale: 4,
                ),
              ),
              hintText: 'Search here..',
              borderRadius: 30,
            ),
          ),
          Expanded(
            child: ChatList(),
          ),
        ],
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.to(() => MessageView());
            log('message index is $index');
          },
          child: Container(
            margin: EdgeInsets.only(
              left: 20,
              bottom: 8,
              right: 20,
              top: index == 0 ? 16 : 0,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.bottomNavbar,
                border: Border.all(color: AppColors.silver)),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(AppImages.carImageThree),
              ),
              title: Text(
                'Nissan R35 GTR',
                style: h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.black100,
                ),
              ),
              subtitle: Text(
                'Good morning! Thank you for reaching out. I see your application in our system. We’re currently reviewing candidates, and you should hear back from us by the end of the week.',
                style: h6.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Container(
                padding: EdgeInsets.all(8),
                decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  color: AppColors.darkRed,
                ),
                child: Text(
                  '1',
                  style: h6.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class OrderList extends StatelessWidget {
//   const OrderList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 4,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               sh16,
//               Row(
//                 children: [
//                   Image.asset(
//                     AppImages.orderTwo,
//                     scale: 4,
//                   ),
//                   sw10,
//                   Text(
//                     'Your order is just a click away!',
//                     style:
//                     h2.copyWith(fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                   Spacer(),
//                   Text(
//                     '25/12/2025',
//                     style: h2.copyWith(fontSize: 12),
//                   ),
//                 ],
//               ),
//               sh10,
//               Container(
//                 padding: EdgeInsets.only(right: 8),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   color: AppColors.bottomNavbar,
//                 ),
//                 child: Row(
//                   children: [
//                     SizedBox(
//                       height: 70,
//                       width: 70,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.asset(
//                           AppImages.productImage,
//                           scale: 4,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                     sw12,
//                     Expanded(
//                       child: Text(
//                         'Complete your payment within the next 30 minutes to avoid cancellation of your order',
//                         style: h2.copyWith(
//                             color: AppColors.grey,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
