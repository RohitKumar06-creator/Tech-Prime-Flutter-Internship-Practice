import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../models/doctor_model.dart';
import 'steps/booking_success_step.dart';
import 'steps/booking_summary_step.dart';
import 'steps/choose_doctor_step.dart';
import 'steps/payment_method_step.dart';
import 'steps/select_reason_step.dart';
import 'steps/select_schedule_step.dart';
import 'viewmodels/booking_viewmodel.dart';

class BookingFlowScreen extends StatefulWidget {
  final DoctorModel? doctor;

  const BookingFlowScreen({super.key, this.doctor});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        final vm = BookingViewModel();
        if (widget.doctor != null) {
          vm.selectDoctor(widget.doctor!);
          if (vm.currentStep == 0) {
            vm.nextStep();
          }
        }
        return vm;
      },
      child: Consumer<BookingViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: viewModel.currentStep == 5
                ? null
                : AppBar(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.textDark,
                        size: 20,
                      ),
                      onPressed: () => viewModel.prevStep(context),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    title: Text(
                      viewModel.currentStep == 4
                          ? 'Summary'
                          : 'Booking Appointment',
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12.0,
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: IndexedStack(
                        index: viewModel.currentStep,
                        children: [
                          ChooseDoctorStep(
                            selectedDoctor: viewModel.selectedDoctor,
                            doctors: viewModel.filteredDoctors,
                            onSearch: viewModel.setDoctorQuery,
                            onDoctorSelected: viewModel.selectDoctor,
                          ),
                          SelectScheduleStep(
                            selectedDay: viewModel.selectedDay,
                            selectedDateNum: viewModel.selectedDateNum,
                            selectedTime: viewModel.selectedTime,
                            onDateSelected: (day, dateNum) =>
                                viewModel.selectSchedule(day, dateNum),
                            onTimeSelected: (time) =>
                                viewModel.selectTime(time),
                          ),
                          SelectReasonStep(
                            selectedReason: viewModel.selectedReason,
                            reasons: viewModel.filteredReasons,
                            onSearch: viewModel.setReasonQuery,
                            onReasonSelected: viewModel.selectReason,
                          ),
                          PaymentMethodStep(
                            onCardSelected: (card) =>
                                viewModel.selectPaymentCard(card),
                          ),
                          BookingSummaryStep(viewModel: viewModel),
                          const BookingSuccessStep(),
                        ],
                      ),
                    ),
                    if (viewModel.currentStep > 0 &&
                        viewModel.currentStep < 5) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: viewModel.isProcessingPayment
                              ? null
                              : () async {
                                  if (viewModel.currentStep == 4) {
                                    final success = await viewModel
                                        .confirmBookingAndSave();
                                    if (success) {
                                      viewModel.nextStep();
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Payment failed. Please try again.',
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  } else {
                                    viewModel.nextStep();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4FC3F7),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: viewModel.isProcessingPayment
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  viewModel.currentStep == 4
                                      ? 'Pay Now'
                                      : 'Continue',
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
        },
      ),
    );
  }
}
