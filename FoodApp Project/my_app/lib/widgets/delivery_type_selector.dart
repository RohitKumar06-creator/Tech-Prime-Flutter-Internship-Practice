import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryTypeSelector extends StatelessWidget {
  final bool isDelivery;
  final ValueChanged<bool> onTypeChanged;

  const DeliveryTypeSelector({
    super.key,
    required this.isDelivery,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTypeChanged(true),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: isDelivery
                      ? const Color(0xFFFF5A5F)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Center(
                  child: Text(
                    'Door Delivery',
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: isDelivery
                          ? Colors.white
                          : const Color(0xFF666666),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTypeChanged(false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: !isDelivery
                      ? const Color(0xFFFF5A5F)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Center(
                  child: Text(
                    'Self Pickup',
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: !isDelivery
                          ? Colors.white
                          : const Color(0xFF666666),
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
}
