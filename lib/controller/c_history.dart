import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hotels_app/core.dart';
import 'package:hotels_app/source/booking_source.dart';
import 'package:hotels_app/source/hotel_source.dart';

class CHistory extends GetxController {
  final _listBooking = <Booking>[].obs;
  List<Booking> get listBooking => _listBooking.value;

  getListHotel(String id) async {
    _listBooking.value = await BookingSource.getHistory(id);
    update();
  }
}