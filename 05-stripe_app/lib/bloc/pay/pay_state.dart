part of 'pay_bloc.dart';

@immutable
class PayState {

  final double? payAmount;
  final String? currency;
  final bool activeCard;
  final CreditCardCustom? card;

  String get amountPayString => '${(payAmount ?? 0 * 100).floor()}';

  const PayState({
    this.payAmount = 375.55, 
    this.currency = 'USD', 
    this.activeCard = false, 
    this.card
  });

  PayState copyWith({
    double? payAmount,
    String? currency,
    bool? activeCard,
    CreditCardCustom? card
  }) => PayState(
    payAmount: payAmount ?? this.payAmount,
    currency: currency ?? this.currency,
    activeCard: activeCard ?? this.activeCard,
    card: card ?? this.card
  );

}
