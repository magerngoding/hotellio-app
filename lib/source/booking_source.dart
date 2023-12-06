import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hotels_app/core.dart';

class BookingSource {
  static Future<Booking?> checkIsBook(String userId, String hotelId) async {
    var result = await FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('Booking')
        .where('id_hotel', isEqualTo: hotelId)
        .where('is_done', isEqualTo: false)
        .get();
    if (result.size > 0) {
      return Booking.fromJson(result.docs.first.data());
    }
    return null;
  }

  static Future<bool> addBooking(String userId, Booking booking) async {
    var ref = FirebaseFirestore.instance
        .collection('User')
        .doc(userId)
        .collection('Booking');
    var docRef = await ref.add(booking.toJson());
    docRef.update({'id': docRef.id});
    return true;
  }
}
