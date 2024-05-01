import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:manage_store/core/values/app_colors.dart';
import 'package:manage_store/modules/scan/cubit/scan_cubit.dart';
import 'package:manage_store/utils/default_widget/loading_widget.dart';

import 'package:native_barcode_scanner/barcode_scanner.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScanCubit(
        const ScanState(
          barcode: '',
          isLoading: true,
          isStartScan: true,
        ),
      )..checkGrant(),
      lazy: false,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            'Scan',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Đặt phần mã sản phẩm vào trong Camera',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<ScanCubit, ScanState>(
          buildWhen: (previous, current) =>
              previous.isStartScan != current.isStartScan,
          builder: (context, state) {
            if (!state.isStartScan) {
              return const Text(
                'Tính năng đang tạm tắt, hãy bật để bắt đầu Scan',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              );
            }
            return const Text(
              'Đang Scan mã...',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: Get.width * 0.7,
          height: Get.height * 0.4,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: const Border(
              top: BorderSide(width: 2, color: AppColors.blue80),
              bottom: BorderSide(width: 2, color: AppColors.blue80),
              right: BorderSide(width: 2, color: AppColors.blue80),
              left: BorderSide(width: 2, color: AppColors.blue80),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BlocBuilder<ScanCubit, ScanState>(
              buildWhen: (previous, current) =>
                  previous.isStartScan != current.isStartScan ||
                  previous.isLoading != current.isLoading,
              builder: (context, state) {
                if (state.isLoading || !state.isStartScan) {
                  return const LoadingWidget();
                }
                return BarcodeScannerWidget(
                  startScanning: state.isStartScan,
                  orientation: CameraOrientation.portrait,
                  cameraSelector: CameraSelector.back,
                  scannerType: ScannerType.barcode,
                  onError: (error) {
                    Get.snackbar('Thông báo', 'Lỗi Scan, hãy scan lại');
                  },
                  onBarcodeDetected: (barcode) {
                    context
                        .read<ScanCubit>()
                        .onDetected(barcode.value.toString());
                  },
                );
              },
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BlocBuilder<ScanCubit, ScanState>(
          builder: (context, state) {
            return Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      context.read<ScanCubit>().onStartScan();
                    },
                    icon: const Icon(
                      Icons.play_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<ScanCubit>().onReloading();
                    },
                    icon: const Icon(
                      Icons.replay,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        BlocBuilder<ScanCubit, ScanState>(
          buildWhen: (previous, current) =>
              previous.isStartScan != current.isStartScan ||
              previous.isNotFound != current.isNotFound,
          builder: (context, state) {
            if (state.isStartScan) {
              return Container();
            } else if (state.isNotFound) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Không tìm thấy sản phẩm',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text(
                          'Thêm thủ công',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<ScanCubit>().onContinueOtherCode();
                        },
                        child: const Text(
                          'Tiếp tục với mã khác',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return SingleChildScrollView(
              child: Container(
                width: Get.width * 0.8,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: const Border(
                    top: BorderSide(width: 1, color: Colors.black),
                    bottom: BorderSide(width: 1, color: Colors.black),
                    right: BorderSide(width: 1, color: Colors.black),
                    left: BorderSide(width: 1, color: Colors.black),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'BarCode: ${context.read<ScanCubit>().productModel.barcode}'),
                    Text(
                        'Tên Sản Phẩm: ${context.read<ScanCubit>().productModel.title}'),
                    Text(
                        'Hình ảnh: ${context.read<ScanCubit>().productModel.img}'),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Text(
            'Dev by BuiltLab',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
