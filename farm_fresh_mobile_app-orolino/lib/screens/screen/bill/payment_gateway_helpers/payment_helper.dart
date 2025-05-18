import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shurjopay/models/config.dart';
import 'package:shurjopay/models/payment_verification_model.dart';
import 'package:shurjopay/models/shurjopay_request_model.dart';
import 'package:shurjopay/models/shurjopay_response_model.dart';
import 'package:shurjopay/shurjopay.dart';


void onButtonTap(String selected, BuildContext context) async {
  switch (selected) {
    case 'shurjopay':
      shurjoPay(context); // Pass context
      break;
    default:
      print('No gateway selected');
  }
}

double totalPrice = 1.00;





void shurjoPay(BuildContext context) async {
  final shurjoPay = ShurjoPay();

  final paymentResponse = await shurjoPay.makePayment(
    context: context, // Pass context instead of using Get.context!
    shurjopayRequestModel: ShurjopayRequestModel(
      configs: ShurjopayConfigs(
        prefix: 'NOK',
        userName: 'sp_sandbox',
        password: 'pyyk97hu&6u6',
        clientIP: '127.0.0.1',
      ),
      currency: 'BDT',
      amount: totalPrice,
      orderID: 'test00255588',
      customerName: 'Md Shirajul Islam',
      customerPhoneNumber: '+8801700000000',
      customerAddress: 'Dhaka, Bangladesh',
      customerCity: 'Dhaka',
      customerPostcode: '1000',
      returnURL: 'url',
      cancelURL: 'url',
    ),
  );


  if (paymentResponse.status == true) {
    try {
      final verifyResponse = await shurjoPay.verifyPayment(
          orderID: paymentResponse.shurjopayOrderID!);

      if (verifyResponse.spCode == '1000') {
        print(verifyResponse.bankTrxId);
      } else {
        print(verifyResponse.spMessage);
      }

      if (verifyResponse.bankTrxId == null || verifyResponse.bankTrxId!.isEmpty || verifyResponse.bankTrxId == '') {

        print('Something is wrong with your payment');

      }
      else {

        print(verifyResponse.bankTrxId);
        print(verifyResponse.message);

      }
    } catch (e) {
      print(e);
    }
  }
}


