import 'package:connection_gap/navigation.dart';
import 'package:connection_gap/presentation/bloc/connection/connection_bloc.dart';
import 'package:connection_gap/presentation/bloc/connection/connection_state.dart';
import 'package:connection_gap/presentation/screens/first_screen.dart';
import 'package:connection_gap/presentation/screens/fourth_screen.dart';
import 'package:connection_gap/presentation/screens/no_internet_connection_screen.dart';
import 'package:connection_gap/presentation/screens/second_screen.dart';
import 'package:connection_gap/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainTabbedScreen extends StatefulWidget {
  const MainTabbedScreen({Key? key}) : super(key: key);

  @override
  State<MainTabbedScreen> createState() => _MainTabbedScreenState();
}

class _MainTabbedScreenState extends State<MainTabbedScreen> {
  bool _isNoInternetConnectionDlgShown = false;
  int _selectedItemIndex = 0;
  List<dynamic> pages = [
    const FirstScreen(),
    const SecondScreen(),
    const ThirdScreen(),
    const FourthScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionBloc, InternetConnectionState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is ConnectionSuccess) {
          if (_isNoInternetConnectionDlgShown) {
            _isNoInternetConnectionDlgShown = false;
            NavigationActions.instance.returnToPreviousPage();
          }
        } else if (state is ConnectionError) {
          _isNoInternetConnectionDlgShown = true;
          checkInternetConnectionDlg(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: pages[_selectedItemIndex],
          bottomNavigationBar: BottomNavigationBar(
            selectedIconTheme: const IconThemeData(color: Colors.red),
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedItemIndex,
            elevation: 0,
            onTap: (int index) {
              setState(() {
                _selectedItemIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Page1',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sell_outlined),
                label: 'Page2',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm_outlined),
                label: 'Page3',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'Page4',
              ),
            ],
          ),
        );
      },
    );
  }
}
