part of 'scan_cubit.dart';

final class ScanState extends Equatable {
  const ScanState({
    required this.barcode,
    required this.isLoading,
    required this.isStartScan,
    this.isNotFound = false,
  });
  final String barcode;
  final bool isLoading;
  final bool isStartScan;
  final bool isNotFound;

  ScanState copyWith({
    String? barcode,
    bool? isLoading,
    bool? isStartScan,
    bool? isNotFound,
  }) {
    return ScanState(
      barcode: barcode ?? this.barcode,
      isLoading: isLoading ?? this.isLoading,
      isStartScan: isStartScan ?? this.isStartScan,
      isNotFound: isNotFound ?? this.isNotFound,
    );
  }

  @override
  List<Object> get props => [barcode, isLoading, isStartScan, isNotFound];
}
