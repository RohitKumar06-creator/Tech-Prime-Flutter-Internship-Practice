import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Imports
import '../models/cart_item.dart';
import '../widgets/delivery_address_card.dart';
import '../widgets/cart_item_tile.dart';
import '../widgets/cart_bill_summary.dart';
import '../widgets/cart_promo_banners.dart';
import 'checkout_screen.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final List<CartItem> cartItems = [
    CartItem(
      title: 'Gourmet Cheeseburger',
      description: 'Extra cheese, No pickles',
      price: 12.50,
      imagePath: 'assets/images/burger.jpg',
      quantity: 2,
    ),
    CartItem(
      title: 'Truffle Sea Salt Fries',
      description: 'Large Portion',
      price: 5.99,
      imagePath: 'assets/images/fries.jpg',
      quantity: 1,
    ),
    CartItem(
      title: 'Coke Zero',
      description: '500ml Bottle',
      price: 2.50,
      imagePath: 'assets/images/coke.jpg',
      quantity: 1,
    ),
  ];

  final double deliveryFee = 2.99;
  final double serviceFee = 1.50;

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),

                    // Top Bar Location Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: const Color(0xFFFF5A5F),
                              size: 22.sp,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              'Current Location',
                              style: GoogleFonts.montserrat(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFFFF5A5F),
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.search,
                          color: const Color(0xFF202020),
                          size: 24.sp,
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),
                    const DeliveryAddressCard(),
                    SizedBox(height: 24.h),

                    Text(
                      'Your Items',
                      style: GoogleFonts.montserrat(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF202020),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Items List
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return CartItemTile(
                          item: item,
                          onIncrement: () => setState(() => item.quantity++),
                          onDecrement: () {
                            setState(() {
                              if (item.quantity > 1) {
                                item.quantity--;
                              } else {
                                cartItems.removeAt(index);
                              }
                            });
                          },
                        );
                      },
                    ),

                    SizedBox(height: 16.h),
                    CartBillSummary(
                      subtotal: subtotal,
                      deliveryFee: deliveryFee,
                      serviceFee: serviceFee,
                    ),

                    SizedBox(height: 16.h),
                    const CartPromoBanners(),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Sticky Checkout Button
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10.r,
                    offset: Offset(0, -4.h),
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 54.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutScreen(
                          totalAmount: subtotal + deliveryFee + serviceFee,
                          itemCount: cartItems.length,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Checkout',
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
