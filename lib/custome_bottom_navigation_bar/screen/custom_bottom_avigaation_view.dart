import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/product/screen/product_listing_screen.dart';
import 'package:untitled/product/screen/product_listing_screen_mongodb.dart';

import '../../mongo_db_screen/screen/add_product_screen.dart';
import '../../profile/screen/profile_screen.dart';
import '../bloc/custom_navigation_bar_bloc.dart';

class CustomBottomNav extends StatefulWidget {
  const CustomBottomNav({super.key});

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  List<Widget> widgetOptions = <Widget>[
    const ProductListScreen(),
    const ProductListingScreen(),
    const AddProductScreen(),
    const ProfileScreen(),
    // AllTransactions(back: false),
    // // Center(child: Text('B')),
    // const WalletScreen(),
    // // Center(child: Text('C')),
    // const ProfileScreen(),
    // Center(child: Text('D')),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomNavigationBarBloc, CustomNavigationBarState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          body: widgetOptions.elementAt(state.tabIndex),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            color: Colors.transparent,
            elevation: 0,
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<CustomNavigationBarBloc>(context)
                        .add(TabChange(tabIndex: 0));
                    // btmCtrl.selectedIndex = 0;
                    // btmCtrl.update();
                    // print('object ${btmCtrl.selectedIndex}');
                  },
                  icon: const Icon(Icons.home, size: 24, color: Color(0xFF26CBC0)),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<CustomNavigationBarBloc>(context)
                        .add(TabChange(tabIndex: 1));
                    // btmCtrl.selectedIndex = 0;
                    // btmCtrl.update();
                    // print('object ${btmCtrl.selectedIndex}');
                  },
                  icon: const Icon(Icons.dashboard_customize_sharp, size: 24, color: Color(0xFF26CBC0)),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<CustomNavigationBarBloc>(context)
                        .add(TabChange(tabIndex: 2));
                    // btmCtrl.selectedIndex = 0;
                    // btmCtrl.update();
                    // print('object ${btmCtrl.selectedIndex}');
                  },
                  icon: const Icon(Icons.perm_data_setting, size: 24, color: Color(0xFF26CBC0)),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<CustomNavigationBarBloc>(context)
                        .add(TabChange(tabIndex: 3));
                  },
                  icon: const Icon(Icons.person, size: 24, color: Color(0xFF26CBC0)),
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      },
    );
  }
}
