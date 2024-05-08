// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class user_detials extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onpressed;

  const user_detials({
    super.key,
    required this.text,
    required this.sectionName,
    required this.onpressed,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 340,
        left: 10,
        right: 6,
      ),
      child: Container(
        height: 80,
        width: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 1), // Changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.only(left: 15, bottom: 15),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sectionName,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: onpressed,
                    icon: Icon(
                      Icons.settings,
                      color: Colors.black,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
