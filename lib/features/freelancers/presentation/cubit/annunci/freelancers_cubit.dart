import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'freelancers_state.dart';

class FreelancersCubit extends Cubit<FreelancersState> {
  FreelancersCubit() : super(FreelancersInitial());
}
