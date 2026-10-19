import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../models/booking_model.dart';
import 'steps/booking_success_step.dart';
import 'steps/booking_summary_step.dart';
import 'steps/choose_doctor_step.dart';
import 'steps/payment_method_step.dart';
import 'steps/select_reason_step.dart';
import 'steps/select_schedule_step.dart';

class BookingFlowScreen extends StatefulWidget {
  const BookingFlowScreen({super.key});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  int _currentStep = 0;
  final BookingModel _booking = BookingModel();

  void _nextStep() {
    if (_currentStep < 5) {
      setState(() => _currentStep++);
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _currentStep == 5
          ? null
          : AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.textDark,
                  size: 20,
                ),
                onPressed: _prevStep,
              ),
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                _currentStep == 4 ? 'Summary' : 'Booking Appointment',
                style: const TextStyle(
                  color: AppColors.textDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _currentStep,
                  children: [
                    ChooseDoctorStep(
                      selectedDoctor: _booking.doctor,
                      onDoctorSelected: (doc) {
                        setState(() => _booking.doctor = doc);
                        _nextStep();
                      },
                    ),
                    SelectScheduleStep(
                      selectedDay: _booking.selectedDay,
                      selectedDateNum: _booking.selectedDateNum,
                      selectedTime: _booking.selectedTime,
                      onDateSelected: (day, num) => setState(() {
                        _booking.selectedDay = day;
                        _booking.selectedDateNum = num;
                      }),
                      onTimeSelected: (time) =>
                          setState(() => _booking.selectedTime = time),
                    ),
                    SelectReasonStep(
                      selectedReason: _booking.reason,
                      onReasonSelected: (reason) =>
                          setState(() => _booking.reason = reason),
                    ),
                    PaymentMethodStep(
                      onCardSelected: (last4, name) => setState(() {
                        _booking.paymentCardLast4 = last4;
                        _booking.paymentCardHolder = name;
                      }),
                    ),
                    BookingSummaryStep(booking: _booking),
                    const BookingSuccessStep(),
                  ],
                ),
              ),

              if (_currentStep > 0 && _currentStep < 5) ...[
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _nextStep,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _currentStep == 4 ? 'Pay Now' : 'Continue',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
