// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hotels_app/config/app_asset.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAsset.iconComingSoon,
            fit: BoxFit.cover,
            height: 129,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            'Coming Soon',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            'We are developing this page\nfor new great features',
            style: TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
