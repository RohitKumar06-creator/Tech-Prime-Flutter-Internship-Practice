import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// Models & Widgets
import '../models/payment_method.dart';
import '../widgets/delivery_type_selector.dart';
import '../widgets/payment_method_card.dart';
import '../widgets/order_summary_card.dart';
import '../screens/food_catalogue.dart';

class CheckoutScreen extends StatefulWidget {
  final double totalAmount;
  final int itemCount;

  const CheckoutScreen({
    super.key,
    this.totalAmount = 37.48,
    this.itemCount = 4,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isDelivery = true;
  String selectedPaymentId = 'card';

  final List<PaymentMethod> paymentMethods = [
    PaymentMethod(
      id: 'card',
      title: 'Credit / Debit Card',
      subtitle: '•••• •••• •••• 4242',
      icon: Icons.credit_card,
    ),
    PaymentMethod(
      id: 'apple_pay',
      title: 'Apple Pay / Google Pay',
      subtitle: 'Fast 1-click checkout',
      icon: Icons.account_balance_wallet_outlined,
    ),
    PaymentMethod(
      id: 'cash',
      title: 'Cash on Delivery',
      subtitle: 'Pay directly to driver',
      icon: Icons.payments_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFF202020),
            size: 24.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Checkout',
          style: GoogleFonts.montserrat(
            color: const Color(0xFF202020),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),

                    // Toggle Option: Delivery or Pickup
                    DeliveryTypeSelector(
                      isDelivery: isDelivery,
                      onTypeChanged: (val) => setState(() => isDelivery = val),
                    ),

                    SizedBox(height: 24.h),

                    // Order Summary Banner
                    OrderSummaryCard(
                      totalItems: widget.itemCount,
                      totalAmount: widget.totalAmount,
                    ),

                    SizedBox(height: 24.h),

                    // Delivery Info Header
                    Text(
                      isDelivery ? 'Delivery Location' : 'Pickup Location',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF202020),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Location Card
                    Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: const Color(0xFFFF5A5F),
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isDelivery
                                      ? '742 Evergreen Terrace'
                                      : 'Central Gourmet Kitchen',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF202020),
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  isDelivery
                                      ? 'Apt 4B • Doorstep Dropoff'
                                      : 'Downtown Station • Ready in 15 mins',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF888888),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: const Color(0xFF888888),
                            size: 24.sp,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Payment Method Header
                    Text(
                      'Payment Method',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF202020),
                      ),
                    ),

                    SizedBox(height: 12.h),

                    // Payment Options List
                    ...paymentMethods.map(
                      (method) => PaymentMethodCard(
                        method: method,
                        isSelected: selectedPaymentId == method.id,
                        onTap: () =>
                            setState(() => selectedPaymentId = method.id),
                      ),
                    ),

                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),

            // Sticky Place Order Button
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
                    _showOrderSuccessDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF5A5F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Place Order — \$${widget.totalAmount.toStringAsFixed(2)}',
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
      ),
    );
  }

  void _showOrderSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Icon(
          Icons.check_circle,
          color: const Color(0xFFFF5A5F),
          size: 60.sp,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Order Placed!',
              style: GoogleFonts.montserrat(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your food is being prepared and will arrive soon.',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 13.sp,
                color: const Color(0xFF666666),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const FoodCatalogue()),
                (route) => false,
              );
            },
            child: Text(
              'Back to Menu',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFF5A5F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
