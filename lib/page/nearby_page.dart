// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels_app/config/app_asset.dart';
import 'package:hotels_app/config/app_color.dart';
import 'package:hotels_app/config/app_format.dart';
import 'package:hotels_app/controller/c_nearby.dart';
import 'package:hotels_app/core.dart';

class NearbyPage extends StatelessWidget {
  final cNearby = Get.put(CNearby());

  NearbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 24),
        header(context),
        SizedBox(height: 20),
        searchField(),
        SizedBox(height: 30),
        categories(),
        SizedBox(height: 30),
        GetBuilder<CNearby>(
          builder: (_) {
            List<Hotel> list = _.category == 'All Place'
                ? _.listHotel
                : _.listHotel
                    .where((e) => e.category == cNearby.category)
                    .toList();
            if (list.isEmpty)
              return Center(
                child: Text('Empty'),
              );
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: list.length,
              itemBuilder: (context, index) {
                Hotel hotel = list[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          hotel.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                hotel.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Start from ',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  Text(
                                    AppFormat.currency(
                                      hotel.rate.toDouble(),
                                    ),
                                    style: TextStyle(
                                      color: AppColor.secondary,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '/night',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }

  GetBuilder<CNearby> categories() {
    return GetBuilder<CNearby>(
      builder: (_) {
        return SizedBox(
          height: 45,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _.categories.length,
            itemBuilder: (context, index) {
              String category = _.categories[index];
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  index == 0 ? 16 : 8,
                  0,
                  index == cNearby.categories.length - 1 ? 16 : 8,
                  0,
                ),
                child: Material(
                  color:
                      category == _.category ? AppColor.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      cNearby.category = category;
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child: Text(
                          category,
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget searchField() {
    return Container(
      height: 45,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search by name or city',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Material(
              color: AppColor.secondary,
              borderRadius: BorderRadius.circular(45),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(45),
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: Center(
                    child: ImageIcon(
                      AssetImage(
                        AppAsset.iconSearch,
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              AppAsset.profile,
              width: 50,
              height: 50,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Near Me',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              Text(
                '189 hotels',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
