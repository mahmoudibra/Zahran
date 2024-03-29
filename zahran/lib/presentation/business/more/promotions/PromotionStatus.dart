import 'package:flutter/material.dart';
import 'package:zahran/presentation/business/more/promotions/promotion_view_model.dart';
import 'package:zahran/presentation/commom/rounded_chip.dart';
import 'package:zahran/presentation/localization/tr.dart';

class PromotionStatusWidget extends StatelessWidget {
  final PromotionStatus promotionStatus;

  const PromotionStatusWidget({required this.promotionStatus});

  @override
  Widget build(BuildContext context) {
    print(" 🚀 🚀 Promotion status is:  ${promotionStatus.value}");
    print(" 🚀 🚀 Is active:  ${promotionStatus.isActive}");
    if (promotionStatus.isActive) {
      return RoundedChip(
          backgroundColor: Color(int.parse("0xFFC8E6C9")),
          chipTextColor: Theme.of(context).textTheme.headline6!.color!,
          chipText: TR.of(context).active);
    } else {
      return RoundedChip(
          backgroundColor: Color(int.parse("0xFFFFCDD2")),
          chipTextColor: Theme.of(context).textTheme.headline6!.color!,
          chipText: TR.of(context).expired);
    }
  }
}
