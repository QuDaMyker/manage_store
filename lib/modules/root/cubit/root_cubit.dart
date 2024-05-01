import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit(super.initialState);

  void onChangePageView(int currentPage) {
    state.pageController.animateToPage(currentPage,
        duration: const Duration(milliseconds: 1), curve: Curves.ease);
    //state.pageController.jumpToPage(currentPage);
    emit(state.copyWith(currentPage: currentPage));
  }

  void signout() async {
    emit(state.copyWith(isAuth: false));
  }
}
