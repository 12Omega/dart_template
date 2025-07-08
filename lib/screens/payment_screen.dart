// lib/screens/payment_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking_app/models/booking.dart';
import 'package:smart_parking_app/screens/home_screen.dart';
import 'package:smart_parking_app/services/booking_service.dart';
import 'package:smart_parking_app/utils/constants.dart';
import 'package:smart_parking_app/presentation/widgets/custom_button.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  final Booking booking;

  const PaymentScreen({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _isLoading = false;
  String _selectedPaymentMethod = 'card'; // Default to card payment
  final List<String> _paymentMethods = ['card', 'esewa', 'khalti'];

  Future<void> _processPayment() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate payment processing

      final bookingService = Provider.of<BookingService>(context, listen: false);
      await bookingService.updateBookingStatus(
          widget.booking.id,
          BookingStatus.confirmed
      );

      if (mounted) {
        _showPaymentSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment failed: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Payment Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                size: 50,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Your parking spot has been reserved successfully!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Booking ID: ${widget.booking.id.substring(0, 8).toUpperCase()}',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
              );
            },
            child: const Text('Return to Home'),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodCard(String method) {
    IconData icon;
    String title;

    switch (method) {
      case 'card':
        icon = Icons.credit_card;
        title = 'Credit/Debit Card';
        break;
      case 'esewa':
        icon = Icons.account_balance_wallet;
        title = 'eSewa';
        break;
      case 'khalti':
        icon = Icons.wallet;
        title = 'Khalti';
        break;
      default:
        icon = Icons.money;
        title = 'Unknown Method';
    }

    return InkWell(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = method;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: _selectedPaymentMethod == method
              ? kPrimaryColor.withAlpha((255 * 0.1).round()) // Replaced withOpacity
              : Colors.white,
          border: Border.all(
            color: _selectedPaymentMethod == method
                ? kPrimaryColor
                : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _selectedPaymentMethod == method
                    ? kPrimaryColor.withAlpha((255 * 0.2).round()) // Replaced withOpacity
                    : Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: _selectedPaymentMethod == method
                    ? kPrimaryColor
                    : Colors.grey[600],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _selectedPaymentMethod == method
                      ? kPrimaryColor
                      : Colors.black,
                ),
              ),
            ),
            if (_selectedPaymentMethod == method)
              const Icon(
                Icons.check_circle,
                color: kPrimaryColor,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha((255 * 0.1).round()), // Replaced withOpacity
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Booking Summary',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSummaryItem(
                    'Parking Location',
                    widget.booking.parkingSpotName,
                  ),
                  _buildSummaryItem(
                    'Date',
                    DateFormat('EEE, d MMM yyyy').format(widget.booking.startTime),
                  ),
                  _buildSummaryItem(
                    'Time',
                    '${DateFormat('h:mm a').format(widget.booking.startTime)} - ${DateFormat('h:mm a').format(widget.booking.endTime)}',
                  ),
                  _buildSummaryItem(
                    'Duration',
                    '${widget.booking.endTime.difference(widget.booking.startTime).inMinutes / 60} hours',
                  ),
                  _buildSummaryItem(
                    'Vehicle Type',
                    widget.booking.vehicleType,
                  ),
                  _buildSummaryItem(
                    'Vehicle Plate',
                    widget.booking.vehiclePlate,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payment Amount
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kPrimaryColor.withAlpha((255 * 0.05).round()), // Replaced withOpacity
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Amount:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Rs. ${widget.booking.amount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payment Methods
            const Text(
              'Payment Method',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              _paymentMethods.length,
                  (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildPaymentMethodCard(_paymentMethods[index]),
              ),
            ),

            // Card Details (only show if card payment is selected)
            if (_selectedPaymentMethod == 'card')
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Card Details',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Card Number',
                      hintText: 'XXXX XXXX XXXX XXXX',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.credit_card),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Expiry Date',
                            hintText: 'MM/YY',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'CVV',
                            hintText: 'XXX',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Name on Card',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 32),

            // Payment Button
            CustomButton(
              label: 'Pay Rs. ${widget.booking.amount.toStringAsFixed(2)}',
              isLoading: _isLoading,
              onPressed: _processPayment,
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Your payment information is secure and encrypted',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}