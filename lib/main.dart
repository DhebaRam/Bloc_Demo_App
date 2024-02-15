// // main.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:untitled/product/product_bloc/product_bloc.dart';
// import 'package:untitled/product/product_details_bloc/product_details_bloc.dart';
// import 'package:untitled/product/screen/product_details_screen.dart';
// import 'package:untitled/product/screen/product_listing_screen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider(create: (context) => ProductBloc()),
//           BlocProvider(create: (context) => ProductDetailsBloc()),
//         ],
//         child: MaterialApp(
//           title: 'Product App',
//           initialRoute: '/productListing',
//           routes: {
//             '/productListing': (context) => const ProductListingScreen(),
//             '/productDetails': (context) => const ProductDetailsScreen(),
//           },
//         ));
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
//
// void main() {
//   return runApp(_ChartApp());
// }
//
// class _ChartApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: false),
//       home: _MyHomePage(),
//     );
//   }
// }
//
// class _MyHomePage extends StatefulWidget {
//   // ignore: prefer_const_constructors_in_immutables
//   _MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<_MyHomePage> {
//   late List<SaleData> chartData;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     chartData = getChartData();
//   }
//
//   getChartData(){
//     final List<SaleData> chartData = [
//       SaleData( 1999,  20),
//       SaleData( 2001,  23),
//       SaleData( 2002,  25),
//       SaleData( 2003,  28),
//       SaleData( 2004,  29),
//       SaleData( 2005,  19),
//       SaleData( 2006,  30),
//       SaleData( 2007,  0),
//       SaleData( 2008,  14),
//       SaleData( 2009,  30),
//       SaleData( 2010,  4),
//     ];
//     return chartData;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: SfCartesianChart(
//       enableSideBySideSeriesPlacement: true,
//       series: [
//         AreaSeries<SaleData, double>(
//           dataSource: chartData,
//             xValueMapper: (SaleData saleData, _)=> saleData.year, yValueMapper: (SaleData saleData, _)=> saleData.sale,)
//       ],
//       primaryXAxis: const NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift,labelFormat: '{value}-Year',),
//     ));
//   }
// }
//
// class SaleData {
//   final double year;
//   final double sale;
//
//   SaleData(this.year, this.sale);
// }

// class _MyHomePageState extends State<_MyHomePage> {
//   List<_SalesData> data = [
//     _SalesData('Jan', 35),
//     _SalesData('Feb', 28),
//     _SalesData('Mar', 34),
//     _SalesData('Apr', 32),
//     _SalesData('May', 40)
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Syncfusion Flutter chart'),
//         ),
//         body: Column(children: [
//           //Initialize the chart widget
//           SfCartesianChart(
//               primaryXAxis: const CategoryAxis(),
//               // Chart title
//               title: const ChartTitle(text: 'Half yearly sales analysis'),
//               // Enable legend
//               legend: const Legend(isVisible: true),
//               // Enable tooltip
//               tooltipBehavior: TooltipBehavior(enable: true),
//               series: <CartesianSeries<_SalesData, String>>[
//                 LineSeries<_SalesData, String>(
//                     dataSource: data,
//                     xValueMapper: (_SalesData sales, _) => sales.year,
//                     yValueMapper: (_SalesData sales, _) => sales.sales,
//                     name: 'Sales',
//                     // Enable data label
//                     dataLabelSettings: const DataLabelSettings(isVisible: true))
//               ]),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               //Initialize the spark charts widget
//               child: SfSparkLineChart.custom(
//                 //Enable the trackball
//                 trackball: const SparkChartTrackball(
//                     activationMode: SparkChartActivationMode.tap),
//                 //Enable marker
//                 marker: const SparkChartMarker(
//                     displayMode: SparkChartMarkerDisplayMode.all),
//                 //Enable data label
//                 labelDisplayMode: SparkChartLabelDisplayMode.all,
//                 xValueMapper: (int index) => data[index].year,
//                 yValueMapper: (int index) => data[index].sales,
//                 dataCount: 5,
//               ),
//             ),
//           )
//         ]));
//   }
// }
//
// class _SalesData {
//   _SalesData(this.year, this.sales);
//
//   final String year;
//   final double sales;
// }

// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay/pay.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled/mongo_db/dbHelper/mongo_db_connect.dart';
import 'package:untitled/product/product_bloc/product_bloc.dart';
import 'package:untitled/product/product_cart_bloc/product_cart_bloc.dart';
import 'package:untitled/product/product_category_bloc/product_category_bloc.dart';
import 'package:untitled/product/product_details_bloc/product_details_bloc.dart';
import 'package:untitled/product/product_filter_bloc/product_filter_bloc.dart';
import 'package:untitled/product/screen/product_listing_screen.dart';
import 'package:untitled/profile/profile_bloc/profile_bloc.dart';
import 'package:untitled/routers/app_routers.dart';
import 'package:sizer/sizer.dart';
import 'auth/bloc/login_bloc.dart';
import 'auth/ragister_bloc/register_bloc.dart';
import 'custome_bottom_navigation_bar/bloc/custom_navigation_bar_bloc.dart';
import 'design_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  mongodbConnect();
  firebaseConnect();
  runApp(const MyApp());
}

void mongodbConnect() async {
  try {
    await MongodbDataBase.connect();
  } catch (e) {
    log('InitializeApp -------> ${e.toString()}');
  }
}

void firebaseConnect() async {
  try {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyCAQuV9NxYB76UwM1J1UR0ND7DwSJq-6g0',
      appId: '1:455891089327:android:6493e5ab457edc3f37a15a',
      messagingSenderId: '455891089327',
      projectId: 'mystore-6d10c',
      storageBucket: "gs://mystore-6d10c.appspot.com",
    ));
  } catch (e) {
    log('Firebase Catch --- ${e.toString()}');
  }
}

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '99.99',
    status: PaymentItemStatus.final_price,
  )
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LoginBloc()),
          BlocProvider(create: (_) => CustomNavigationBarBloc()),
          BlocProvider(create: (_) => ProductBloc()),
          BlocProvider(create: (_) => ProductCartBloc()),
          BlocProvider(create: (_) => ProductCategoryBloc()),
          BlocProvider(create: (_) => ProductDetailsBloc()),
          BlocProvider(create: (_) => ProductFilterBloc()),
          BlocProvider(create: (_) => ProfileBloc()),
          BlocProvider(create: (_) => RegisterBloc()),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
            title: 'Payment App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
            // home: const ProductListScreen(),
            home: const DesignScreen(),
            // routes: AppRoutes.getRoute,
            // initialRoute: AppRoutes.initialRoute,
          );
        }));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final int _counter = 0;

  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  @override
  void initState() {
    super.initState();
    _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('default_google_pay_config.json');
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            )
                .animate() // this wraps the previous Animate in another Animate
                .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                .slide()
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 1200.ms, color: const Color(0xFF80DDFF)),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            GooglePayButton(
              paymentConfigurationAsset: 'default_google_pay_config.json',
              paymentItems: _paymentItems,
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onGooglePayResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            GooglePayButton(
              paymentConfigurationAsset: 'default_google_pay_config.json',
              paymentItems: paymentItems,
              onPaymentResult: (result) {},
              margin: const EdgeInsets.only(top: 15.0),
              width: double.maxFinite,
              type: GooglePayButtonType.buy,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),

            // Example pay button configured using an asset
            FutureBuilder<PaymentConfiguration>(
                future: _googlePayConfigFuture,
                builder: (context, snapshot) => snapshot.hasData
                    ? GooglePayButton(
                        paymentConfiguration: snapshot.data!,
                        paymentItems: _paymentItems,
                        type: GooglePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onGooglePayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.shrink()),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (Platform.isAndroid) {
            // onGooglePayResult();
          } else {}
        },
        child: Platform.isAndroid
            ? const Text(
                'Google Pay',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              )
            : const Text(
                'Apple Pay',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<PaymentItem> get paymentItems {
    const paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '1.99',
        status: PaymentItemStatus.final_price,
      ),
    ];

    return paymentItems;
  }
}
