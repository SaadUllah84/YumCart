import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:food_delivery/widget/app_constant.dart';

class PaymentService {
  Map<String, dynamic>? paymentIntent;

  Future<bool> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'AED');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'SaadUllah'
          ));
      return await displayPaymentSheet();
    } catch (e) {
      print('exception: $e');
      return false;
    }
  }

  Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      paymentIntent = null;
      return true;
    } on StripeException catch (e) {
      print('Error is: ---> $e');
      return false;
    } catch (e) {
      print('$e');
      return false;
    }
  }

  /// WARN: This function uses the Stripe Secret Key on the client side.
  /// This is a SEVERE security vulnerability. In a production app,
  /// you must create the PaymentIntent on your backend server.
  /// Never expose your Secret Key in the app code.
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      print("Payment Intent Body => ${response.body}");
      return jsonDecode(response.body);
    }
    catch (err) {
      print('Error creating payment intent: $err');
    }
  }

  String calculateAmount(String amount) {
    final parsedAmount = int.tryParse(amount);
    if (parsedAmount == null || parsedAmount <= 0) {
      throw Exception("Invalid amount");
    }
    return (parsedAmount * 100).toString();
  }
}
