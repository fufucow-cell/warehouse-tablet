import 'package:engo_terminal_app3/wh/feature/reservation/model/reservation_item_model.dart';

class ReservationMainPageModel {
  bool isLoading = false;
  String? errorMessage;
  List<ReservationItemModel> items = <ReservationItemModel>[];
  String? selectedItemId;
  int selectedInfoTabIndex = 0;

  String selectedDateOption = '';
  String selectedStartTime = '';
  String selectedEndTime = '';
  String selectedPeople = '2位成人 / 0位孩童';
}