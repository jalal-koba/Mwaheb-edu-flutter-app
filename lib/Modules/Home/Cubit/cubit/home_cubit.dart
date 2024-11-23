import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:talents/Apis/exception_handler.dart';
import 'package:talents/Apis/network.dart';
import 'package:talents/Apis/urls.dart';
import 'package:talents/Modules/Courses/Model/course.dart';
import 'package:talents/Modules/Home/Cubit/state/home_state.dart';
import 'package:talents/Modules/Home/Model/home_response.dart';
import 'package:talents/Modules/Offers/Models/offer.dart';
import 'package:talents/Modules/Payments_Orders/Model/section.dart';
import 'package:talents/Modules/Trainers/Model/trainer.dart'; 
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Offer> offers = [];
  List<Trainer> trainers = [];
  List<Section> sections = [];
  List<Course> latestCourses = [];

  static String ownerInfo = "";

  HomeResponse? homeResponse;
  final RefreshController refreshController = RefreshController();

  String? libraryDescription;
  String? libraryImage;

  Future<void> getHomeInfo() async {
    emit(HomeLoadingState());

    try {
      Response response = await Network.getData(
        url: Urls.home,
      );

      homeResponse = HomeResponse.fromJson(response.data);

      offers = homeResponse!.data.offers.data.take(8).toList();
      trainers = homeResponse!.data.instructors.data.take(8).toList();
      sections = homeResponse!.data.sections.data.take(8).toList();
      latestCourses = homeResponse!.data.courses.data.take(8).toList();

      libraryImage = homeResponse!.data.dataLibrary.image;

      libraryDescription = homeResponse!.data.dataLibrary.description;

      // Map<String, dynamic> description =
      //     jsonDecode(libraryDescription!) as Map<String, dynamic>;

      // libraryDescription = description['ar'];

      ownerInfo = homeResponse!.data.ownerInfo;
      // Map<String, dynamic> map = json.decode(ownerInfo) as Map<String, dynamic>;
      // ownerInfo = map['ar']!;

      emit(HomeSuccessState());
    } on DioException catch (error) {
      emit(HomeErrorState(message: exceptionsHandle(error: error)));
    } 
    catch (error) {
      emit(HomeErrorState(message: "حدث خطأ ما"));
    }
  }
}
