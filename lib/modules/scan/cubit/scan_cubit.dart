import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit(super.initialState);
  bool startScan = false;

  void onStartScan() {
    startScan = !startScan;
  }

  void onDetected(String code) async {
    final dio = Dio();

    var response = await dio.post(
      '${dotenv.get('URL_NGROK')}/getinfo/id=$code',
    );

    if (response.statusCode == 200) {
      //Get.snackbar('title', 'luu thanh cong id $code');
      Get.snackbar('Thong Bao', response.toString());
      debugPrint('thanh cong');
      debugPrint(code);
      debugPrint(response.toString());
    }

    emit(state.copyWith(isStartScan: false));
    Future.delayed(const Duration(milliseconds: 100), () {
      emit(state.copyWith(isStartScan: true));
    });
  }

  Future<void> checkGrant() async {
    var status = await Permission.camera.status;

    if (status.isDenied) {
      if (await Permission.camera.request().isGranted) {
        debugPrint('log-data: da cap quyen');
        emit(state.copyWith(isLoading: false));
      } else {
        emit(state.copyWith(isLoading: true));
        debugPrint('log-data: chua cap quyen');
      }
    } else {
      //await connectOneDrive(context);
      emit(state.copyWith(isLoading: false));
      debugPrint('log-data: da cap quyen');
    }
  }
}
