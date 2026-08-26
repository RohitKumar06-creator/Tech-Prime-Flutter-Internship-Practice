import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderSummaryCard extends StatelessWidget {
  final int totalItems;
  final double totalAmount;

  const OrderSummaryCard({
    super.key,
    required this.totalItems,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                color: const Color(0xFFFF5A5F),
                size: 24.sp,
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$totalItems Items in Order',
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF202020),
                    ),
                  ),
                  Text(
                    'Includes all taxes & fees',
                    style: GoogleFonts.montserrat(
                      fontSize: 11.sp,
                      color: const Color(0xFF888888),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '\$${totalAmount.toStringAsFixed(2)}',
            style: GoogleFonts.montserrat(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFF5A5F),
            ),
          ),
        ],
      ),
    );
  }
}
