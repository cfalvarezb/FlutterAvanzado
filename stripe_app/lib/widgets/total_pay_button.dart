import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stripe_app/bloc/pay/pay_bloc.dart';
import 'package:stripe_app/helpers/helpers.dart';
import 'package:stripe_app/services/stripe_service.dart';
import 'package:stripe_platform_interface/src/models/payment_methods.dart' as stpe;

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of( context ).size.width;
    final payBloc = context.read<PayBloc>().state;

    return Container(
      width: width,
      height: 100,
      padding: const EdgeInsets.symmetric( horizontal: 15 ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Total', style: TextStyle( fontSize: 20, fontWeight: FontWeight.bold ),),
              Text('${ payBloc.payAmount } ${ payBloc.currency }', style: const TextStyle( fontSize: 20 )),
            ],
          ),

          BlocBuilder<PayBloc, PayState>(
            builder: (context, state) {
              return _BtnPay( state );
            },
          )
          
        ],
      ),
    );
  }
}

class _BtnPay extends StatelessWidget {

  final PayState state;
  const _BtnPay(this.state);

  @override
  Widget build(BuildContext context) {
    return state.activeCard 
    ? buildCardButton( context )
    : buildAppleAndGooglePay( context );
  }

  Widget buildCardButton(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: const Row(
        children: [
          Icon( FontAwesomeIcons.solidCreditCard, color: Colors.white, ),
          Text(' Pay', style: TextStyle( color: Colors.white, fontSize: 22 ),),
        ],
      ),
      onPressed: () async {
        final stripeService = StripeService();
        final payBlocState = context.read<PayBloc>().state;
        final card = state.card;
        final monthYear = card?.expiracyDate.split('/');

        showLoading(context);
        
        final res = await stripeService.payWithExistCard(
          amount: payBlocState.amountPayString, 
          currency: payBlocState.currency ?? 'usd', 
          card: stpe.Card(
             last4: card!.cardNumber.substring(card.cardNumber.length - 4),
             expMonth: int.parse(monthYear![0]),
             expYear: int.parse(monthYear[1])
          )
        );

        if ( context.mounted ) {
          Navigator.pop(context);
        }

        if ( res.ok && context.mounted ) {
          showAlert( context, "Tarjeta OK", "Todo correcto");
        } else if ( context.mounted ) {
          showAlert( context, "Algo salio mal", res.msg ?? "Nada" );
        }

      }
    );
  }

  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: const StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        children: [
          Icon( 
            Platform.isAndroid
            ? FontAwesomeIcons.google
            : FontAwesomeIcons.apple, 
            color: Colors.white, ),
          Text(' Pay', style: TextStyle( color: Colors.white, fontSize: 22 ),),
        ],
      ),
      onPressed: () async {
        final stripeService = StripeService();
        final payBlocState = context.read<PayBloc>().state;

        final resp = await stripeService.payApplePayGooglePay(
          amount: payBlocState.amountPayString, 
          currency: payBlocState.currency ?? ''
        );
      }
    );
  }
}