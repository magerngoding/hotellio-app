// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels_app/controller/c_home.dart';

import '../config/app_asset.dart';
import '../config/app_color.dart';

class HomePage extends StatelessWidget {
  final cHome = Get.put(CHome());

  final List<Map> listNav = [
    {'icon': AppAsset.iconNearby, 'label': 'Nearby'},
    {'icon': AppAsset.iconHistory, 'label': 'History'},
    {'icon': AppAsset.iconPayment, 'label': 'Payment'},
    {'icon': AppAsset.iconReward, 'label': 'Reward'},
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (cHome.indexPage == 1) {
          return Center(child: Text('History'));
        }
        return Center(child: Text('Nearby'));
      }),
      bottomNavigationBar: Obx(
        () {
          return Material(
            elevation: 8,
            child: Container(
              padding: EdgeInsets.only(
                top: 8,
                bottom: 6,
              ),
              color: Colors.white,
              child: BottomNavigationBar(
                currentIndex: cHome.indexPage,
                onTap: (value) => cHome.indexPage = value,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.black,
                selectedIconTheme: IconThemeData(
                  color: AppColor.primary,
                ),
                selectedFontSize: 12,
                items: listNav.map(
                  (e) {
                    return BottomNavigationBarItem(
                      icon: ImageIcon(AssetImage(e['icon'])),
                      label: e['label'],
                    );
                  },
                ).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
