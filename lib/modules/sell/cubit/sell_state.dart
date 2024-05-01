part of 'sell_cubit.dart';

final class SellState extends Equatable {
  const SellState({
    required this.products,
    required this.optionItem,
    this.isLoading = false,
  });
  final List<ProductModel> products;
  final OptionItem optionItem;
  final bool? isLoading;

  SellState copyWith({
    List<ProductModel>? products,
    OptionItem? optionItem,
    bool? isLoading,
  }) {
    return SellState(
      products: products ?? this.products,
      optionItem: optionItem ?? this.optionItem,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [products, optionItem, isLoading!];
}
