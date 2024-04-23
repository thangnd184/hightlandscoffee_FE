import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:highlandcoffeeapp/widgets/choose_login_type_page%20.dart';
import 'package:highlandcoffeeapp/components/pages/bill_page.dart';
import 'package:highlandcoffeeapp/components/pages/favorite_product_page.dart';
import 'package:highlandcoffeeapp/components/pages/list_product_page.dart';
import 'package:highlandcoffeeapp/components/pages/product_popular_page.dart';
import 'package:highlandcoffeeapp/firebase_options.dart';
import 'package:highlandcoffeeapp/pages/admin/admin_page.dart';
import 'package:highlandcoffeeapp/pages/auth/auth_user_page.dart';
import 'package:highlandcoffeeapp/pages/cart/cart_page.dart';
import 'package:highlandcoffeeapp/pages/home/home_page.dart';
import 'package:highlandcoffeeapp/pages/introduce/introduce_page1.dart';
import 'package:highlandcoffeeapp/pages/introduce/introduce_page2.dart';
import 'package:highlandcoffeeapp/pages/user/page/my_order_page.dart';
import 'package:highlandcoffeeapp/pages/user/page/update_user_profille.dart';
import 'package:highlandcoffeeapp/pages/welcome/welcome_page.dart';
import 'package:highlandcoffeeapp/themes/theme.dart';
import 'package:highlandcoffeeapp/utils/bill/payment/payment_qr_code.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.ios
  );
  runApp(
    DevicePreview(
      builder: (context) => MyApp(),
    ),
  );
}

// void main()  => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => const MyApp(), // Wrap your app
//       ),
//     );

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.ios
//   );
//   runApp(
//     const MyApp()
//     );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      home: WelcomePage(),
      getPages: [
        GetPage(name: '/welcome_page', page: () => const WelcomePage()),
        GetPage(name: '/introduce_page1', page: () => const IntroducePage1()),
        GetPage(name: '/introduce_page2', page: () => const IntroducePage2()),
        GetPage(name: '/choose_login_type_page', page: () => ChooseLoginTypePage()),
        GetPage(name: '/auth_page', page: () => const AuthUserPage()),
        GetPage(name: '/home_page', page: () => const HomePage()),
        GetPage(name: '/list_product_page', page:() => const ListProductPage()),
        GetPage(name: '/product_popular_page', page:() => const ProductPopularPage()),
        GetPage(name: '/favorite_product_page', page:() => const FavoriteProductPage()),
        GetPage(name: '/cart_page', page:() => const CartPage()),
        GetPage(name: '/bill_page', page:() => const BillPage()),
        GetPage(name: '/admin_page', page:() => const AdminPage()),
        GetPage(name: '/update_user_profile_page', page:() => const UpdateUserProfilePage()),
        GetPage(name: '/my_order_page', page:() => const MyOrderPage()),
      ],
      theme: ThemeData(
        primaryColor: primaryColors,
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
