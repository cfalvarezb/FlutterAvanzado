import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:stripe_app/models/credit_card_custom.dart';

part 'pay_event.dart';
part 'pay_state.dart';

class PayBloc extends Bloc<PayEvent, PayState> {
  PayBloc() : super( const PayState()){
    on<OnSelectCard>((event, emit) => emit( state.copyWith( activeCard: true, card: event.card ) ));
    on<OnDesactivateCard>((event, emit) => emit( state.copyWith( activeCard: false )));
  }
}