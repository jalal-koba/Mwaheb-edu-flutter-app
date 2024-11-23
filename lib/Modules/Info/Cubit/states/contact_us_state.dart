abstract class InfoState {}

final class InfoInitialState extends InfoState {}

final class InfoLoadingState extends InfoState {}

final class InfoSuccessState extends InfoState {}

final class InfoErrorState extends InfoState {
  InfoErrorState({required this.message});
  String message;
}
