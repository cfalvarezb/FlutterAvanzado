import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';

import 'package:stripe_app/data/cards_custom.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/pages/card_page.dart';
import 'package:stripe_app/services/stripe_service.dart';
import 'package:stripe_app/widgets/total_pay_button.dart';

class HomePage extends StatelessWidget {

  final stripeService = StripeService();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of( context ).size;
    final payBloc = context.read<PayBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagar'),
        actions: [
          IconButton(
            icon: const Icon( Icons.add ),
            onPressed: () async {
              /*
              showLoading(context);
              await Future.delayed(const Duration(seconds: 1));
              if (context.mounted) {
                Navigator.pop(context);
              }
              */
              showLoading(context);

              final amount = payBloc.state.amountPayString;
              final currency = payBloc.state.currency ?? "USD";
              final resp = await stripeService.payWithNewCard(
                amount: amount, 
                currency: currency
              );

              if ( context.mounted ) {
                Navigator.pop(context);
              }

              if ( resp.ok && context.mounted ) {
                showAlert( context, "Tarjeta OK", "Todo correcto");
              } else if ( context.mounted ) {
                showAlert( context, "Algo salio mal", resp.msg ?? "Nada" );
              }
            }, 
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned (
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: 0.9
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: cards.length,
              itemBuilder: ( _, i ) {
            
                final card = cards[i];
            
                return GestureDetector(
                  onDoubleTap: () {
                    context.read<PayBloc>().add( OnSelectCard(card) );
                    Navigator.push(context, navegarFadeIn( context, const CardPage() ));
                  },
                  child: Hero(
                    tag: card.cardNumber,
                    child: CreditCardWidget(
                      cardNumber: card.cardNumberHidden, 
                      expiryDate: card.expiracyDate, 
                      cardHolderName: card.cardHolderName, 
                      cvvCode: card.cvv, 
                      showBackView: false, 
                      onCreditCardWidgetChange: (creditCardBrand ) {  },
                    ),
                  ),
                );
              }
            ),
          ),

          const Positioned(
            bottom: 0,
            child: TotalPayButton()
          )
        ],
      )
    );
  }
}