import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductOptionTile extends StatelessWidget {
  final String title;
  final String price;
  final bool isAdd;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const ProductOptionTile({
    super.key,
    required this.title,
    required this.price,
    required this.isAdd,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFFEBEE)),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: CheckboxListTile(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFFFF5A5F),
        controlAffinity: ListTileControlAffinity.trailing,
        title: Row(
          children: [
            Icon(
              isAdd ? Icons.add_circle_outline : Icons.remove_circle_outline,
              color: const Color(0xFFFF5A5F),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF202020),
              ),
            ),
            const Spacer(),
            if (price.isNotEmpty)
              Text(
                price,
                style: GoogleFonts.montserrat(
                  fontSize: 13.sp,
                  color: const Color(0xFF888888),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
