

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pix_revive/core/App/SharedPreferences/shared_preferences.dart';
import 'package:pix_revive/core/api/dio_client.dart';
import 'package:pix_revive/core/router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';



class PaymobWebViewScreen extends StatefulWidget {
  final String? url;
  final String? transactionId;
  const PaymobWebViewScreen({super.key,  this.url,  this.transactionId});

  @override
  State<PaymobWebViewScreen> createState() => _PaymobWebViewScreenState();
}

class _PaymobWebViewScreenState extends State<PaymobWebViewScreen> {
  late final WebViewController _controller;

  // ✅ separate async function
  static Future<bool> verifyPayment(String transactionId) async {
  try {
    var response = await Api.post(
      "https://project-3-production-0259.up.railway.app/api/subscriptions/verify-payment/",
      data: {
        "transaction_id": transactionId,
      },
      options: Options(headers: {
        "Authorization": "Bearer ${SharedPreferencesHelper.getString(KSharedPreferencesKeys.accsesstoken)}",
      }),
    );
    log("✅ Verify Payment response: ${response.statusCode}");
    log("✅ Verify Payment body: ${response.data}");
    return true;
  } catch (e) {
    log("❌ Verify Payment error: $e");
    return false;
  }
}

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains("success=true")) {
              log("✅ Success URL");
          verifyPayment(widget.transactionId!).then((_) => pop(context)); // ✅ call then 
        // pop(context);
              return NavigationDecision.prevent;
            } else if (request.url.contains("success=false")) {
              log("❌ Failed URL");
              pop(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Secure Payment")),
      body: WebViewWidget(controller: _controller),
    );
  }
}