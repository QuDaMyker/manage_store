import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:manage_store/modules/sell/models/product_model.dart';
import 'package:permission_handler/permission_handler.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit(super.initialState);
  ProductModel productModel =
      ProductModel(id: 'id', barcode: 'barcode', title: 'title', img: 'img');

  void onContinueOtherCode() {
    emit(
        state.copyWith(isNotFound: false, isLoading: false, isStartScan: true));
  }

  void onStartScan() {
    if (state.isStartScan) {
      emit(state.copyWith(isStartScan: false));
    } else {
      emit(state.copyWith(isStartScan: true));
    }
  }

  void onReloading() async {
    emit(state.copyWith(isLoading: true));
    Future.delayed(const Duration(seconds: 1), () {
      emit(state.copyWith(isLoading: false));
    });
  }

  void onDetected(String code) async {
    debugPrint(code);
    final dio = Dio();

    var response = await dio.post(
      '${dotenv.get('URL_NGROK')}/getinfo/id=$code',
    );

    if (response.statusCode == 200) {
      switch (response.data['status']) {
        case 401:
          {
            // productModel = ProductModel(
            //   id: response.data['message'],
            //   barcode: code,
            //   title: response.data['message'],
            //   img: response.data['message'],
            // );

            emit(state.copyWith(isNotFound: true, isStartScan: false));

            break;
          }
        case 201:
          {
            productModel = ProductModel(
              id: response.data['message'],
              barcode: code,
              title: response.data['message'],
              img: response.data['message'],
            );
            emit(state.copyWith(isNotFound: false));
            break;
          }
        case 200:
          {
            productModel = ProductModel(
              id: 'id',
              barcode: code,
              title: response.data['title'],
              img: response.data['img'],
            );
            emit(state.copyWith(isNotFound: false));

            break;
          }

        default:
      }

      debugPrint('thanh cong');
      debugPrint(code);
      debugPrint(response.toString());

      emit(
        state.copyWith(
          isLoading: false,
          isStartScan: false,
        ),
      );

      //emit(state.copyWith(isStartScan: true));
    }

    // emit(state.copyWith(isStartScan: false));
    // Future.delayed(const Duration(seconds: 1), () {
    //   emit(state.copyWith(isStartScan: true));
    // });
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
