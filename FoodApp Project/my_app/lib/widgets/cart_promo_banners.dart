import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CartPromoBanners extends StatelessWidget {
  const CartPromoBanners({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125.h,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: const Color(0xFFFF5A5F),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Got a Promo\nCode?',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFFFF5A5F),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Text(
                      'Add Code',
                      style: GoogleFonts.montserrat(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(14.r),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE0B2),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Join Premium for\nfree delivery!',
                    style: GoogleFonts.montserrat(
                      color: const Color(0xFF5D4037),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.auto_awesome,
                    color: const Color(0xFF5D4037),
                    size: 22.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
