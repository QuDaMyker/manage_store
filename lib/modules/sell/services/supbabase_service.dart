import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:manage_store/core/values/db_table.dart';
import 'package:manage_store/modules/sell/models/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._internal();
  factory SupabaseService() => instance;
  static final SupabaseService instance = SupabaseService._internal();
  late SupabaseClient supabaseClient;

  Future<void> init() async {
    await Supabase.initialize(
      url: dotenv.get('SUPABASE_URL'),
      anonKey: dotenv.get('SUPABASE_ANON_KEY'),
    );
    supabaseClient = Supabase.instance.client;
  }

  Future<List<ProductModel>> getProducts() async {
    try {
      List<ProductModel> products = [];
      List<Map<String, dynamic>> query = await supabaseClient
          .from(DBTable.productName)
          .select('id, barcode, title, img');

      for (int i = 0; i < query.length; i++) {
        products.add(ProductModel.fromMap(query[i]));
      }
      return products;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
