part of 'reservation_service.dart';

class ReservationServiceModel {
  final openItems = Rxn<List<ReservableItem>>();
  final recordItems = Rxn<List<RecordItem>>();
  BuildContext? nestedNavigatorContext;
}
