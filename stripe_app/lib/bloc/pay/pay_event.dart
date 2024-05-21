part of 'pay_bloc.dart';

@immutable
sealed class PayEvent {}

class OnSelectCard extends PayEvent {

  final CreditCardCustom card;
  OnSelectCard(this.card);

}

class OnDesactivateCard extends PayEvent {
  final CreditCardCustom card;
  OnDesactivateCard(this.card);
}
