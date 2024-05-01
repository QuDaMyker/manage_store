part of 'root_cubit.dart';

// ignore: must_be_immutable
final class RootState extends Equatable {
  int currentPage;
  final PageController pageController;
  bool isAuth;

  RootState({
    this.currentPage = 0,
    required this.pageController,
    this.isAuth = true,
  });
  RootState copyWith({int? currentPage, bool? isAuth}) {
    return RootState(
      currentPage: currentPage ?? this.currentPage,
      pageController: pageController,
      isAuth: isAuth ?? this.isAuth,
    );
  }

  @override
  List<Object> get props => [currentPage, pageController, isAuth];
}
