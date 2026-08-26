import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onDecrement,
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.remove,
                size: 16.sp,
                color: const Color(0xFF202020),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              '$quantity',
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: onIncrement,
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: const BoxDecoration(
                color: Color(0xFFFF5A5F),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, size: 16.sp, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
