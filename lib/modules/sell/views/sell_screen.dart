import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:manage_store/core/values/app_colors.dart';
import 'package:manage_store/modules/barcode_manual/view/barcode_manual_screen.dart';
import 'package:manage_store/modules/scan/view/scan_screen.dart';

import 'package:manage_store/modules/sell/cubit/sell_cubit.dart';
import 'package:manage_store/modules/sell/models/product_model.dart';
import 'package:manage_store/modules/sell/widgets/product_widget.dart';
import 'package:manage_store/utils/default_widget/loading_widget.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SellCubit(
        SellState(
          products: const [],
          optionItem: OptionItem(title: "Bộ lọc"),
        ),
      )..init(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: _buildSearchField(
                    title: 'Tìm kiếm sản phẩm', context: context),
              ),
              Expanded(
                flex: 1,
                child: _buildFilter(),
              ),
              Expanded(
                flex: 10,
                child: _buildListView(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return BlocBuilder<SellCubit, SellState>(
      buildWhen: (previous, current) =>
          previous.isLoading != current.isLoading ||
          previous.products != current.products,
      builder: (context, state) {
        if (state.isLoading!) {
          return const LoadingWidget();
        }
        return ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            ProductModel productModel = state.products[index];
            return ProductWidget(
              productModel: productModel,
            );
          },
        );
      },
    );
  }

  Widget _buildFilter() {
    return BlocBuilder<SellCubit, SellState>(
      buildWhen: (previous, current) =>
          previous.optionItem != current.optionItem,
      builder: (context, state) {
        return Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.layers_outlined,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.layers_outlined,
              ),
            ),
            IconButton(
              onPressed: () {
                context.read<SellCubit>().getProducts();
              },
              icon: const Icon(
                Icons.replay_outlined,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchField({
    required String title,
    required BuildContext context,
  }) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1, color: AppColors.blue40),
          bottom: BorderSide(width: 1, color: AppColors.blue40),
          left: BorderSide(width: 1, color: AppColors.blue40),
          right: BorderSide(width: 1, color: AppColors.blue40),
        ),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: TextFormField(
        onFieldSubmitted: (value) {},
        onChanged: (value) {},
        cursorColor: AppColors.blue40,
        decoration: InputDecoration(
          hintText: title,
          hintStyle: const TextStyle(
            color: AppColors.blue40,
          ),
          contentPadding: const EdgeInsets.all(0),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: Colors.transparent),
          ),
          prefixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: AppColors.blue40,
            ),
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close),
              ),
              IconButton(
                onPressed: () {
                  showOptions(context);
                },
                icon: const Icon(Icons.qr_code),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildOption('Quét mã', () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ScanScreen(),
                ),
              );
            }),
            const SizedBox(
              height: 10,
            ),
            _buildOption('Nhập thủ công', () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BarcodeManualScreen(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(String title, Function onPressed) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: const BoxDecoration(
                color: AppColors.blue80,
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Bán hàng',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.shopping_cart_outlined,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert_outlined,
          ),
        ),
      ],
    );
  }
}
