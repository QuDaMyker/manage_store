import 'package:bloc/bloc.dart';
import 'package:dropdown_model_list/drop_down/model.dart';
import 'package:equatable/equatable.dart';
import 'package:manage_store/modules/sell/models/product_model.dart';
import 'package:manage_store/modules/sell/services/supbabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sell_state.dart';

class SellCubit extends Cubit<SellState> {
  SellCubit(super.initialState);

  DropListModel dropListModel = DropListModel([
    OptionItem(id: "1", title: "Tất cả mặt hàng"),
    OptionItem(id: "2", title: "Mặc định"),
    OptionItem(id: "3", title: "Yêu thích"),
  ]);

  Future<void> init() async {
    await getProducts();
  }

  void onSelectDropDown(OptionItem value) {
    emit(state.copyWith(optionItem: value));
  }

  Future<void> getProducts() async {
    List<ProductModel> products = await SupabaseService.instance.getProducts();
    emit(state.copyWith(products: products));
  }
}
