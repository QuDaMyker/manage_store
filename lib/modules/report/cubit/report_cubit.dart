import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  ReportCubit() : super(ReportInitial());
}
