import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/card_model.dart';
import '../../../models/doctor_model.dart';

class BookingViewModel extends ChangeNotifier {
  int currentStep = 0;

  DoctorModel? selectedDoctor;
  String selectedDay = 'Thu';
  dynamic selectedDateNum = 11;
  String selectedTime = '08:00 AM';
  String selectedReason = 'Backache';
  PaymentCardModel? selectedCard;

  String doctorSearchQuery = '';
  String reasonSearchQuery = '';
  bool isProcessingPayment = false;

  // Initial list of doctors (also populated from Firestore)
  List<DoctorModel> allDoctors = [
    DoctorModel(
      id: '1',
      name: 'dr. Nirmala Azalea',
      specialization: 'Orthopedic',
      experience: '50+',
      imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?q=80&w=400',
    ),
    DoctorModel(
      id: '2',
      name: 'dr. Agus Subandono',
      specialization: 'Pediatric',
      experience: '30+',
      imageUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?q=80&w=400',
    ),
    DoctorModel(
      id: '3',
      name: 'dr. Bambang Sucat Pelat',
      specialization: 'Neurosurgeon',
      experience: '20+',
      imageUrl: 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?q=80&w=400',
    ),
    DoctorModel(
      id: '4',
      name: 'dr. Desi Sulawesi',
      specialization: 'Obstetrician',
      experience: '50+',
      imageUrl: 'https://images.unsplash.com/photo-1594824813566-78a933773322?q=80&w=400',
    ),
  ];

  final List<String> allReasons = [
    'Appendicitis',
    'Backache',
    'Bone fracture',
    'Cold',
    'Constipation',
    'Cough',
    'Diarrhea',
    'Dizzy',
  ];

  List<DoctorModel> get filteredDoctors {
    if (doctorSearchQuery.isEmpty) return allDoctors;
    return allDoctors
        .where(
          (d) =>
              d.name.toLowerCase().contains(doctorSearchQuery.toLowerCase()) ||
              d.specialization.toLowerCase().contains(
                doctorSearchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  List<String> get filteredReasons {
    if (reasonSearchQuery.isEmpty) return allReasons;
    return allReasons
        .where((r) => r.toLowerCase().contains(reasonSearchQuery.toLowerCase()))
        .toList();
  }

  // Returns a map representing the booking summary for BookingSummaryStep
  Map<String, dynamic> get booking {
    return {
      'doctor': selectedDoctor,
      'date': '$selectedDay, $selectedDateNum Jun 2026',
      'time': selectedTime,
      'reason': selectedReason,
      'card': selectedCard,
      'price': 12,
    };
  }

  void setDoctorQuery(String q) {
    doctorSearchQuery = q;
    notifyListeners();
  }

  void setReasonQuery(String q) {
    reasonSearchQuery = q;
    notifyListeners();
  }

  void selectDoctor(DoctorModel doctor) {
    selectedDoctor = doctor;
    notifyListeners();
  }

  void selectSchedule(String day, dynamic dateNum) {
    selectedDay = day;
    selectedDateNum = dateNum;
    notifyListeners();
  }

  void selectTime(String time) {
    selectedTime = time;
    notifyListeners();
  }

  void selectReason(String reason) {
    selectedReason = reason;
    notifyListeners();
  }

  void selectPaymentCard(PaymentCardModel card) {
    selectedCard = card;
    notifyListeners();
  }

  void nextStep() {
    if (currentStep < 5) {
      currentStep++;
      notifyListeners();
    }
  }

  void prevStep(BuildContext context) {
    if (currentStep > 0) {
      currentStep--;
      notifyListeners();
    } else {
      Navigator.pop(context);
    }
  }

  Future<bool> confirmBookingAndSave() async {
    try {
      isProcessingPayment = true;
      notifyListeners();

      final user = FirebaseAuth.instance.currentUser;
      final firestore = FirebaseFirestore.instance;

      final appointmentData = {
        'userId': user?.uid ?? 'guest_user',
        'doctorName': selectedDoctor?.name ?? 'dr. Nirmala Azalea',
        'doctorSpecialty': selectedDoctor?.specialization ?? 'Orthopedic',
        'doctorImage': selectedDoctor?.imageUrl ?? '',
        'date': '$selectedDay, $selectedDateNum Jun 2026',
        'time': selectedTime,
        'reason': selectedReason,
        'paymentCardLast4': selectedCard?.last4 ?? '9812',
        'status': 'Upcoming',
        'createdAt': FieldValue.serverTimestamp(),
      };

      await firestore.collection('appointments').add(appointmentData);

      isProcessingPayment = false;
      notifyListeners();
      return true;
    } catch (e) {
      isProcessingPayment = false;
      notifyListeners();
      return false;
    }
  }
}
