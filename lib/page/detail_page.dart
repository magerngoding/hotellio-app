// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hotels_app/config/app_color.dart';
import 'package:hotels_app/core.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Hotel hotel = ModalRoute.of(context)!.settings.arguments as Hotel;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        title: Text(
          'Hotel Details',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 24.0),
            images(hotel),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          hotel.name,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          hotel.location,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.star,
                    color: AppColor.starActive,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    hotel.rate.toString(),
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox images(Hotel hotel) {
    return SizedBox(
      height: 180.0,
      child: ListView.builder(
        itemCount: hotel.images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0 ? 16 : 8,
              0,
              index == hotel.images.length - 1 ? 16 : 8,
              0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                hotel.images[index],
                fit: BoxFit.cover,
                height: 180,
                width: 240,
              ),
            ),
          );
        },
      ),
    );
  }
}
