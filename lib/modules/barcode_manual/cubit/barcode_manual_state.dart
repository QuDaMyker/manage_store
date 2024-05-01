part of 'barcode_manual_cubit.dart';

final class BarcodeManualState extends Equatable {
  const BarcodeManualState({
    required this.barcode,
    required this.nameProduct,
    this.image,
  });
  final String barcode;
  final String nameProduct;
  final XFile? image;

  BarcodeManualState copyWith({
    String? barcode,
    String? nameProduct,
    XFile? image,
  }) {
    return BarcodeManualState(
      barcode: barcode ?? this.barcode,
      nameProduct: nameProduct ?? this.nameProduct,
      image: image ?? this.image,
    );
  }

  @override
  List<Object> get props => [barcode, nameProduct, image!];
}
