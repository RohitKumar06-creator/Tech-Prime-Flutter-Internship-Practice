import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/payment_method.dart';

class PaymentMethodCard extends StatelessWidget {
  final PaymentMethod method;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentMethodCard({
    super.key,
    required this.method,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? const Color(0xFFFF5A5F) : Colors.transparent,
            width: 2.w,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFFFF5A5F).withOpacity(0.1)
                    : const Color(0xFFF5F5F5),
                shape: BoxShape.circle,
              ),
              child: Icon(
                method.icon,
                color: isSelected
                    ? const Color(0xFFFF5A5F)
                    : const Color(0xFF666666),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    method.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF202020),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    method.subtitle,
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ),
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onTap(),
              activeColor: const Color(0xFFFF5A5F),
            ),
          ],
        ),
      ),
    );
  }
}
