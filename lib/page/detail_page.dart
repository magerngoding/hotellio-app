// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotels_app/config/app_asset.dart';
import 'package:hotels_app/config/app_color.dart';
import 'package:hotels_app/config/app_format.dart';
import 'package:hotels_app/config/app_route.dart';
import 'package:hotels_app/controller/c_user.dart';
import 'package:hotels_app/core.dart';
import 'package:hotels_app/source/booking_source.dart';
import 'package:hotels_app/widget/button_custome.dart';

class DetailPage extends StatelessWidget {
  final cUser = Get.put(CUser());

  final Rx<Booking> _bookedData = initBooking.obs;
  Booking get bookedData => _bookedData.value;
  set bookedData(Booking n) => _bookedData.value = n;

  final List facilites = [
    {
      'icon': AppAsset.iconCoffee,
      'label': 'Lounge',
    },
    {
      'icon': AppAsset.iconOffice,
      'label': 'Office',
    },
    {
      'icon': AppAsset.iconWifi,
      'label': 'Wi-fi',
    },
    {
      'icon': AppAsset.iconStore,
      'label': 'Store',
    },
  ];

  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    Hotel hotel = ModalRoute.of(context)!.settings.arguments as Hotel;
    BookingSource.checkIsBook(cUser.data.id!, hotel.id).then((bookingValue) {
      bookedData = bookingValue ?? initBooking;
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: Text(
          'Hotel Details',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      //bottomNavigationBar: bookingNow(hotel, context),
      bottomNavigationBar: Obx(() {
        if (bookedData.id == '') return bookingNow(hotel, context);
        return viewReceipt();
      }),
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
            name(hotel, context),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(hotel.description),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Facilities',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            gridFacilites(),
            const SizedBox(height: 16.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Activities',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SizedBox(height: 16.0),
            activities(hotel),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  Container viewReceipt() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[100]!,
            width: 1.5,
          ),
        ),
      ),
      height: 80,
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'You booked this ',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Material(
            color: AppColor.secondary,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 36,
                  vertical: 14,
                ),
                child: Text(
                  'View Receipt',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container bookingNow(Hotel hotel, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey[100]!,
            width: 1.5,
          ),
        ),
      ),
      height: 80,
      padding: EdgeInsets.fromLTRB(
        16,
        12,
        16,
        8,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppFormat.currency(
                    hotel.price.toDouble(),
                  ),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColor.secondary,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                Text(
                  'per night',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          ButtonCustome(
            label: 'Booking Now',
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoute.checkout,
                arguments: hotel,
              );
            },
          ),
        ],
      ),
    );
  }

  SizedBox activities(Hotel hotel) {
    return SizedBox(
      height: 105.0,
      child: ListView.builder(
        itemCount: hotel.activities.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          Map activity = hotel.activities[index];
          return Padding(
            padding: EdgeInsets.fromLTRB(
              index == 0 ? 16 : 8,
              0,
              index == hotel.activities.length - 1 ? 16 : 8,
              0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      activity['image'],
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 6.0,
                ),
                Text(
                  activity['name'],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  GridView gridFacilites() {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 0),
      shrinkWrap: true,
      itemCount: facilites.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(
                AssetImage(facilites[index]['icon']),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                facilites[index]['label'],
                style: TextStyle(fontSize: 13),
              )
            ],
          ),
        );
      },
    );
  }

  Padding name(Hotel hotel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
