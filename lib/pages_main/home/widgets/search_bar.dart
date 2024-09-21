// import 'package:ecommerce_mobile_app/constants.dart';
import 'package:flutter/material.dart';

class MySearchBAR extends StatelessWidget {
  const MySearchBAR({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 400,
      decoration: BoxDecoration(
        color:  const Color.fromARGB(255, 255, 181, 181),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(width: 10),
          Flexible(
            flex: 4,
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search...", border: InputBorder.none),
            ),
          ),
          // Container(
          //   height: 25,
          //   width: 1.5,
          //   color: Colors.grey,
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(
          //     Icons.tune,
          //     color: Colors.grey,
          //   ),
          // ),
        ],
      ),
    );
  }
}