import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartBillSummary extends StatelessWidget {
  final double subtotal;
  final double deliveryFee;
  final double serviceFee;

  const CartBillSummary({
    super.key,
    required this.subtotal,
    required this.deliveryFee,
    required this.serviceFee,
  });

  double get total => subtotal + deliveryFee + serviceFee;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildPriceRow('Subtotal', subtotal),
          SizedBox(height: 8.h),
          _buildPriceRow('Delivery Fee', deliveryFee),
          SizedBox(height: 8.h),
          _buildPriceRow('Service Fee', serviceFee),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Divider(height: 1.h),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF202020),
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: GoogleFonts.montserrat(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF202020),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 13.sp,
            color: const Color(0xFF666666),
          ),
        ),
        Text(
          '\$${amount.toStringAsFixed(2)}',
          style: GoogleFonts.montserrat(
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF202020),
          ),
        ),
      ],
    );
  }
}
