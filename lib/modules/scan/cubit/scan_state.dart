part of 'scan_cubit.dart';

final class ScanState extends Equatable {
  const ScanState({
    required this.barcode,
    required this.isLoading,
    required this.isStartScan,
  });
  final String barcode;
  final bool isLoading;
  final bool isStartScan;

  ScanState copyWith({
    String? barcode,
    bool? isLoading,
    bool? isStartScan,
  }) {
    return ScanState(
      barcode: barcode ?? this.barcode,
      isLoading: isLoading ?? this.isLoading,
      isStartScan: isStartScan ?? this.isStartScan,
    );
  }

  @override
  List<Object> get props => [barcode, isLoading, isStartScan];
}
