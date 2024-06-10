
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_app/models/payment_intent_response.dart';
import 'package:stripe_app/models/stripe_custom_response.dart';

class StripeService {
  // Singleton
  StripeService._privateConstructor();
  static final StripeService _instance = StripeService._privateConstructor();
  factory StripeService() => _instance;

  final String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  static const String _secretKey = 'sk_test_51PIyu8H2DnQCjK75COIU8v4kPcfnR9O7X6NQhq183UxfFewmhTRofR5R8l8HFoGFvOEfqS4M0P29iLt8Agc4JW4h00ZjLO9KxE';
  final String _apiKey = 'pk_test_51PIyu8H2DnQCjK75pZ94SfV4Q06MEQ1cb4sBVso6BWwNvt6Cu4WOtSM4phEPpQaj4XZhVbBQaujRbY5iJKsZhzx0007EeFGomq';
  
  final headerOptions = Options(
    contentType: Headers.formUrlEncodedContentType,
    headers: {
      'Authorization': 'Bearer $_secretKey'
    }
  );

  void init() {
    Stripe.publishableKey = _apiKey;
    Stripe.merchantIdentifier = 'com.example.stripeApp.RunnerTests';// required for Apple Pay
    Stripe.instance.applySettings();
  }

  Future<StripeCustomResponse> payWithExistCard({
    required String amount,
    required String currency,
    required Card card
  }) async {
    
     try {

      final dio = Dio();
      final data = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      final response = await dio.post(
        _paymentApiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_secretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          }
        ),
        data: data,
      );

      if (response.statusCode == 200) {

        final initPaymentResult = await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: response.data['client_secret'],
            merchantDisplayName: 'test',
            customerId: response.data['customer'],
            customerEphemeralKeySecret: response.data['ephemeralKey'],
            customFlow: true,
            //If the store the customer the billing details
            billingDetails: const BillingDetails()
          )
        );

        final paymentResult = await Stripe.instance.presentPaymentSheet().then((value) async {
          print('Payment successful');
          return await _makePayment(
            amount: amount, 
            currency: currency, 
            paymentMethod: value
          );
        }).onError((error, stackTrace) {
          print('Payment flow has been cancelled');
          return StripeCustomResponse(ok: false, msg: error.toString());
        });
        
      } else {
        return StripeCustomResponse(
          ok: false, 
          msg: 'Failed to fetch client secret'
        );
      }

      return StripeCustomResponse(
          ok: false, 
          msg: 'General error'
      );

    } catch (e) {
      return StripeCustomResponse(
        ok: false, 
        msg: e.toString()
      );
    }
    
  }

  Future<StripeCustomResponse> payWithNewCard({
    required String amount,
    required String currency
  }) async {

    try {

      final dio = Dio();
      final data = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      final response = await dio.post(
        _paymentApiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_secretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          }
        ),
        data: data,
      );

      if (response.statusCode == 200) {

        final initPaymentResult = await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: response.data['client_secret'],
            merchantDisplayName: 'test',
            customerId: response.data['customer'],
            customerEphemeralKeySecret: response.data['ephemeralKey'],
            customFlow: true,
            //If the store the customer the billing details
            billingDetails: const BillingDetails()
          )
        );

        final paymentResult = await Stripe.instance.presentPaymentSheet().then((value) async {
          print('Payment successful');
          return await _makePayment(
            amount: amount, 
            currency: currency, 
            paymentMethod: value
          );
        }).onError((error, stackTrace) {
          print('Payment flow has been cancelled');
          return StripeCustomResponse(ok: false, msg: error.toString());
        });
        
      } else {
        return StripeCustomResponse(
          ok: false, 
          msg: 'Failed to fetch client secret'
        );
      }

      return StripeCustomResponse(
          ok: false, 
          msg: 'General error'
      );

    } catch (e) {
      return StripeCustomResponse(
        ok: false, 
        msg: e.toString()
      );
    }
  }

  Future<StripeCustomResponse> payApplePayGooglePay({
    required String amount,
    required String currency
  }) async {
    try {

      final dio = Dio();
      final data = {
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      final response = await dio.post(
        _paymentApiUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_secretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          }
        ),
        data: data,
      );

      if (response.statusCode == 200) {

        final initPaymentResult = await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: response.data['client_secret'],
            merchantDisplayName: 'test',
            customerId: response.data['customer'],
            customerEphemeralKeySecret: response.data['ephemeralKey'],
            customFlow: true,
            //If the store the customer the billing details
            billingDetails: const BillingDetails()
          )
        );

        final paymentResult = await Stripe.instance.presentPaymentSheet().then((value) async {
          print('Payment successful');
          return await _makePayment(
            amount: amount, 
            currency: currency, 
            paymentMethod: value
          );
        }).onError((error, stackTrace) {
          print('Payment flow has been cancelled');
          return StripeCustomResponse(ok: false, msg: error.toString());
        });
        
      } else {
        return StripeCustomResponse(
          ok: false, 
          msg: 'Failed to fetch client secret'
        );
      }

      return StripeCustomResponse(
          ok: false, 
          msg: 'General error'
      );

    } catch (e) {
      return StripeCustomResponse(
        ok: false, 
        msg: e.toString()
      );
    }
  }

  Future<StripeCustomResponse> _makePayment({
    required String amount,
    required String currency,
    required PaymentSheetPaymentOption? paymentMethod
  }) async {
    try {
      await Stripe.instance.confirmPaymentSheetPayment();
      return StripeCustomResponse(ok: true);
    } catch (e) {
      print(e.toString());
      return StripeCustomResponse(
        ok: false,
        msg: e.toString()
      );
    }
  }
}