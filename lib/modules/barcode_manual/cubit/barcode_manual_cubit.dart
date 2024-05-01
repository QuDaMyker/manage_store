import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'barcode_manual_state.dart';

class BarcodeManualCubit extends Cubit<BarcodeManualState> {
  BarcodeManualCubit(super.initialState);
  final ImagePicker imagePicker = ImagePicker();

  Future<void> onPickGallery() async {
    final XFile? file = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (file != null) {
      emit(state.copyWith(image: file.path));
    }
  }

  Future<void> onPickCamera() async {
    final XFile? file = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (file != null) {
      emit(state.copyWith(image: file.path));
    }
  }
}
