
import 'package:dirve_society/common/widgets/custom_size_button.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget {
  final VoidCallback yesOntap;
  final VoidCallback noOntap;
  final IconData iconData;
  final String title;
  final String subtitle;
  final String noText;
  final String yesText;

  const CustomDialog({
    super.key,
    required this.iconData,
    required this.title,
    required this.yesOntap,
    required this.noOntap,
    required this.subtitle,
    required this.noText,
    required this.yesText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            subtitle == ''
                ? const SizedBox()
                : Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomSizeButton(
                  height: 40,
                  width: 100,
                  title: yesText,
                  icon: null,
                  ontap: yesOntap,
                  color: Colors.red,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                ),
                CustomSizeButton(
                  height: 40,
                  width: 100,
                  title: noText,
                  icon: null,
                  ontap: noOntap,
                  color: Colors.grey.shade200,
                  textColor: Colors.black,
                  iconColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
