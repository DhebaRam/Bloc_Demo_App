

import 'package:untitled/auth/screen/register_screen.dart';

import '../auth/screen/login_screen.dart';
import '../check_out/screen/check_out_screen.dart';
import '../custome_bottom_navigation_bar/screen/custom_bottom_avigaation_view.dart';
import '../product/screen/add_new_product_screen.dart';
import '../product/screen/product_cart_screen.dart';
import '../product/screen/product_listing_screen_mongodb.dart';
import '../splash.dart';

class AppRoutes {

  static String initialRoute = '/splashScreen';
  static String customBottomNavRoute = '/customBottomNavRoute';
  static String loginRoute = '/loginRoute';
  static String registerRoute = '/registerScreen';
  static String bottomNavBar = '/bottomNavBar';
  static String productCartScreen = '/productCartScreen';
  static String checkOutScreen = '/checkOutScreen';
  static String addNewProductScreen = '/addNewProductScreen';
  static String productListingScreen = '/productListingScreen';

  static final getRoute = {
    // Splash
    customBottomNavRoute : (context) => const CustomBottomNav(),
    loginRoute : (context) => const LoginScreen(),
    registerRoute : (context) => const RegisterScreen(),
    initialRoute : (context) => const SplashScreen(),
    productCartScreen : (context) => const ProductCartScreen(),
    checkOutScreen : (context) => const CheckOutScreen(),
    addNewProductScreen : (context) => const AddNewProductScreen(),
    productListingScreen : (context) => const ProductListingScreen(),
  //   GetPage(
  //     name: AppRoutes.splashScreen,
  //     page: () => const SplashScreen(),
  //   ),
  };
}
