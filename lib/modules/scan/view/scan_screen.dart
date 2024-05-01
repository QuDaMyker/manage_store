import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_store/modules/scan/cubit/scan_cubit.dart';

import 'package:native_barcode_scanner/barcode_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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
        appBar: AppBar(
          title: const Text('Scan'),
        ),
        body: BlocBuilder<ScanCubit, ScanState>(
          buildWhen: (previous, current) =>
              previous.barcode != current.barcode ||
              previous.isLoading != current.isLoading ||
              previous.isStartScan != current.isStartScan,
          builder: (context, state) {
            if (state.isLoading || state.isStartScan == false) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: BarcodeScannerWidget(
                startScanning: true,
                orientation: CameraOrientation.portrait,
                cameraSelector: CameraSelector.back,
                scannerType: ScannerType.barcode,
                onError: (error) {
                  print(error.toString());
                },
                onBarcodeDetected: (barcode) {
                  print(
                      'Barcode detected: ${barcode.value} (format: ${barcode.format.name})');

                  context
                      .read<ScanCubit>()
                      .onDetected(barcode.value.toString());
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
