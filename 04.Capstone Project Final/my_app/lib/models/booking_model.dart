import 'doctor_model.dart';

class BookingModel {
  DoctorModel? doctor;
  String? selectedDay;
  String? selectedDateNum;
  String? selectedTime;
  String? reason;
  String? paymentCardLast4;
  String? paymentCardHolder;

  BookingModel({
    this.doctor,
    this.selectedDay,
    this.selectedDateNum,
    this.selectedTime,
    this.reason,
    this.paymentCardLast4,
    this.paymentCardHolder,
  });
}
