import 'package:flutter/material.dart';
import 'package:untitled/utis/extentions.dart';

import '../../utis/title_text.dart';
import '../../utis/app_theme.dart';
import '../../utis/color_config.dart';
import '../models/product_category.dart';

class ProductIcon extends StatelessWidget {
  // final String imagePath;
  // final String text;
  final ValueChanged<ProductCategoryModel> onSelected;
  final ProductCategoryModel model;

  const ProductIcon({Key? key, required this.model, required this.onSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: model.isSelected! ? Colors.cyan : Colors.transparent,
          border: Border.all(
            color: model.isSelected! ? Colors.cyan : grey,
            width: model.isSelected! ? 2 : 1,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: model.isSelected! ? Color(0xfffbf2ef) : Colors.white,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(5, 5),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            model.name == null
                ? Container()
                : Container(
                    child: TitleText(
                      text: model.name,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  )
          ],
        ),
      ).ripple(
        () {
          onSelected(model);
        },
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
