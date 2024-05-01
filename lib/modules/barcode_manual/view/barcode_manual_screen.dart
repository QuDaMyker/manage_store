import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manage_store/core/values/app_colors.dart';
import 'package:manage_store/modules/barcode_manual/cubit/barcode_manual_cubit.dart';

class BarcodeManualScreen extends StatefulWidget {
  const BarcodeManualScreen({super.key});

  @override
  State<BarcodeManualScreen> createState() => _BarcodeManualScreenState();
}

class _BarcodeManualScreenState extends State<BarcodeManualScreen> {
  final formStateKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BarcodeManualCubit(
        const BarcodeManualState(
          barcode: 'barcode',
          nameProduct: 'nameProduct',
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          appBar: _buildAppBar(),
          body: _buildBody(context),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Form(
        key: formStateKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Barcode',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            _buildBarcodeField(title: 'Nhập barcode'),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Sản phẩm',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            _buildTextFormField(title: 'Nhập tên sản phẩm'),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Hình ảnh',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            _buildImage(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext ct) {
    return BlocBuilder<BarcodeManualCubit, BarcodeManualState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            showOptions(ct);
          },
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.grey80.withOpacity(0.6),
              border: const Border(
                top: BorderSide(width: 1, color: AppColors.blue80),
                bottom: BorderSide(width: 1, color: AppColors.blue80),
                right: BorderSide(width: 1, color: AppColors.blue80),
                left: BorderSide(width: 1, color: AppColors.blue80),
              ),
            ),
            child: state.image == null
                ? const Center(
                    child: Text('Nhấn để chọn hình ảnh'),
                  )
                : Image.file(
                    File(
                      state.image.toString(),
                    ),
                  ),
          ),
        );
      },
    );
  }

  void showOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        child: BlocBuilder<BarcodeManualCubit, BarcodeManualState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOption(
                  'Chọn ảnh từ thư viện',
                  () async {
                    // Navigator.pop(context);
                    context.read<BarcodeManualCubit>().onPickGallery();
                    // final ImagePicker imagePicker = ImagePicker();
                    // final XFile? file = await imagePicker.pickImage(
                    //   source: ImageSource.gallery,
                    // );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildOption('Chọn ảnh từ máy ảnh', () {
                  Navigator.pop(context);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BarcodeManualScreen(),
                    ),
                  );
                }),
              ],
            );
          },
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

  Widget _buildTextFormField({
    required String title,
  }) {
    return TextFormField(
      onFieldSubmitted: (value) {},
      onChanged: (value) {},
      cursorColor: AppColors.blue40,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: const TextStyle(
          color: AppColors.blue40,
        ),
        contentPadding: const EdgeInsets.all(0),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: AppColors.blue98),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: AppColors.blue98),
        ),
      ),
    );
  }

  Widget _buildBarcodeField({
    required String title,
  }) {
    return TextFormField(
      onFieldSubmitted: (value) {},
      onChanged: (value) {},
      cursorColor: AppColors.blue40,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: const TextStyle(
          color: AppColors.blue40,
        ),
        contentPadding: const EdgeInsets.all(0),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: AppColors.blue98),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 0, color: AppColors.blue98),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Nhập hàng thủ công',
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
