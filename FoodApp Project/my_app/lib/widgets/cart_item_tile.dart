import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/cart_item.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(
              item.imagePath,
              width: 70.w,
              height: 70.h,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  Container(width: 70.w, height: 70.h, color: Colors.grey[200]),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: GoogleFonts.montserrat(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF202020),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.description,
                  style: GoogleFonts.montserrat(
                    fontSize: 11.sp,
                    color: const Color(0xFF888888),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF202020),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: onDecrement,
                  child: Icon(
                    Icons.remove,
                    size: 16.sp,
                    color: const Color(0xFFFF5A5F),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    '${item.quantity}',
                    style: GoogleFonts.montserrat(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onIncrement,
                  child: Icon(
                    Icons.add,
                    size: 16.sp,
                    color: const Color(0xFFFF5A5F),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
