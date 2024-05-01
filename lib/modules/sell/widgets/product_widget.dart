import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manage_store/core/values/app_colors.dart';
import 'package:manage_store/modules/sell/models/product_model.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(width: 1, color: AppColors.grey80),
          bottom: BorderSide(width: 1, color: AppColors.grey80),
          right: BorderSide(width: 1, color: AppColors.grey80),
          left: BorderSide(width: 1, color: AppColors.grey80),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.network(productModel.img),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  productModel.title,
                  style: const TextStyle(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('Code: ${productModel.barcode}'),
              Text('Số lượng: '),
            ],
          )
        ],
      ),
    );
  }
}
