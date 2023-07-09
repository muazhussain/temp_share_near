import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_near/firebase_options.dart';
import 'package:share_near/src/utils/size_config.dart';
import 'package:share_near/src/utils/themes.dart';
import 'package:share_near/src/views/rented-products/rented_products_view.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ShareNearApp());
}

class ShareNearApp extends StatelessWidget {
  const ShareNearApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: const RentedProductView(),
    );
  }
}
