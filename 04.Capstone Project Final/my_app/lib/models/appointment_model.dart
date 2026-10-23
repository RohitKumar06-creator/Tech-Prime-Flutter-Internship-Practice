import 'doctor_model.dart';

class AppointmentModel {
  final String id;
  final DoctorModel doctor;
  final String date;
  final String time;

  AppointmentModel({
    required this.id,
    required this.doctor,
    required this.date,
    required this.time,
  });

  // Factory constructor to map Firestore document snapshots later
  factory AppointmentModel.fromMap(
    Map<String, dynamic> map,
    String documentId,
  ) {
    return AppointmentModel(
      id: documentId,
      doctor: DoctorModel.fromMap(map['doctor'] ?? {}, map['doctorId'] ?? ''),
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  // Map representation for storing in Firebase
  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctor.id,
      'doctor': doctor.toMap(),
      'date': date,
      'time': time,
    };
  }
}
