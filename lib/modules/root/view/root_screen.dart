import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_store/core/values/app_colors.dart';
import 'package:manage_store/modules/bill/views/bill_screen.dart';
import 'package:manage_store/modules/more/views/more_screen.dart';
import 'package:manage_store/modules/report/views/report_screen.dart';
import 'package:manage_store/modules/root/cubit/root_cubit.dart';
import 'package:manage_store/modules/sell/views/sell_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final screens = [
    const SellScreen(),
    const ReportScreen(),
    const BillScreen(),
    const MoreScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildBody(),
        bottomNavigationBar: _buildBottomNavigateBar(context),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<RootCubit, RootState>(
      // buildWhen: (previous, current) =>
      //     previous.currentPage != current.currentPage,
      builder: (context, state) {
        return PageView(
          onPageChanged: (value) {
            state.currentPage = value;
          },
          controller: state.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        );
      },
    );
  }

  Widget _buildBottomNavigateBar(BuildContext context) {
    return BlocBuilder<RootCubit, RootState>(
      // buildWhen: (previous, current) =>
      //     previous.currentPage != previous.currentPage,
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.currentPage,
          onTap: (value) {
            context.read<RootCubit>().onChangePageView(value);
          },
          selectedItemColor: AppColors.blue80,
          unselectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.money,
              ),
              label: 'Bán hàng',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.bike_scooter,
              ),
              label: 'Hóa đơn',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.report,
              ),
              label: 'Báo cáo',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: 'Thêm',
            ),
          ],
        );
      },
    );
  }
}
