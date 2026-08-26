import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Models & Screens
import '../models/food_item.dart';
import 'shopping_cart_screen.dart';

import '../widgets/product_option_tile.dart';
import '../widgets/quantity_selector.dart';

class ProductDetailScreen extends StatefulWidget {
  final FoodItem foodItem;

  const ProductDetailScreen({super.key, required this.foodItem});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1;
  bool isFavorite = false;

  // Customization state
  bool extraCheese = false;
  bool noOnions = false;
  bool crispyBacon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFFFF5A5F),
            size: 24.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Details',
          style: GoogleFonts.montserrat(
            color: const Color(0xFF202020),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: const Color(0xFFFF5A5F),
              size: 24.sp,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Hero Image
                  SizedBox(
                    height: 250.h,
                    width: double.infinity,
                    child: Image.asset(
                      widget.foodItem.imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.fastfood,
                          size: 80.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title & Price Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.foodItem.title,
                                style: GoogleFonts.montserrat(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF202020),
                                ),
                              ),
                            ),
                            Text(
                              widget.foodItem.price,
                              style: GoogleFonts.montserrat(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFF5A5F),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 8.h),

                        // Rating Row
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: const Color(0xFFFFC107),
                              size: 20.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              widget.foodItem.rating,
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF202020),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              '(1.2k+ Reviews)',
                              style: GoogleFonts.montserrat(
                                fontSize: 13.sp,
                                color: const Color(0xFF888888),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // Description Section
                        Text(
                          'Description',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF202020),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Our signature flame-grilled beef patty topped with double melted cheddar, vine-ripened tomatoes, crisp iceberg lettuce, and our secret house sauce on a buttery toasted brioche bun. Served hot and fresh.',
                          style: GoogleFonts.montserrat(
                            fontSize: 13.sp,
                            height: 1.5,
                            color: const Color(0xFF666666),
                          ),
                        ),

                        SizedBox(height: 24.h),

                        // Customization Options
                        Text(
                          'Customize Your Order',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF202020),
                          ),
                        ),
                        SizedBox(height: 12.h),

                        ProductOptionTile(
                          title: 'Extra Cheese',
                          price: '+\$1.50',
                          isAdd: true,
                          value: extraCheese,
                          onChanged: (val) =>
                              setState(() => extraCheese = val!),
                        ),
                        ProductOptionTile(
                          title: 'No Onions',
                          price: '',
                          isAdd: false,
                          value: noOnions,
                          onChanged: (val) => setState(() => noOnions = val!),
                        ),
                        ProductOptionTile(
                          title: 'Crispy Bacon',
                          price: '+\$2.00',
                          isAdd: true,
                          value: crispyBacon,
                          onChanged: (val) =>
                              setState(() => crispyBacon = val!),
                        ),

                        SizedBox(height: 24.h),

                        // Quantity Selector Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quantity',
                              style: GoogleFonts.montserrat(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF202020),
                              ),
                            ),
                            QuantitySelector(
                              quantity: quantity,
                              onIncrement: () => setState(() => quantity++),
                              onDecrement: () {
                                if (quantity > 1) {
                                  setState(() => quantity--);
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Sticky Bottom Button
          Padding(
            padding: EdgeInsets.all(20.r),
            child: SizedBox(
              width: double.infinity,
              height: 54.h,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShoppingCartScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5A5F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  elevation: 0,
                ),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                  size: 20.sp,
                ),
                label: Text(
                  'Add to Cart — ${widget.foodItem.price}',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
