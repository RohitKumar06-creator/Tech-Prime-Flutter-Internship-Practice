import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.directions_bike_outlined,
                    color: const Color(0xFFFF5A5F),
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Delivery Address',
                    style: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF202020),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'Change',
                  style: GoogleFonts.montserrat(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFFF5A5F),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '742 Evergreen Terrace',
            style: GoogleFonts.montserrat(
              fontSize: 13.sp,
              color: const Color(0xFF666666),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Springfield, USA • 15–25 mins',
            style: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: const Color(0xFF888888),
            ),
          ),
        ],
      ),
    );
  }
}
