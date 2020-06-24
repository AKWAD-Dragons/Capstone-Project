import 'package:sercl/PODO/Invitation.dart';
import 'package:sercl/PODO/Order.dart';
import 'package:sercl/PODO/Service.dart';

abstract class OrdersState {}

class OrdersAreFetched extends OrdersState {
  final List<Order> orders;
  OrdersAreFetched(this.orders);
}

class FilterDataIs extends OrdersState{
  List <Service> oldFilterServices;
  List <String> status;
  List <Service> allServices;
  List <String> zipCodes;
  FilterDataIs(this.oldFilterServices, this.status, this.allServices, this.zipCodes);
}

class FilterCleared extends OrdersState{

}

class InvitationsAreAfterRejection extends OrdersState{
  List<Invitation>invitations;
  InvitationsAreAfterRejection(this.invitations);
}

class ReceiptUploaded extends OrdersState{
  Order order;
  ReceiptUploaded(this.order);
}

class InvitationsAre extends OrdersState{
  List<Invitation> invitations;
  InvitationsAre(this.invitations);
}

class PriceUpdated extends OrdersState{
  Invitation invitation;
  PriceUpdated(this.invitation);
}

class InvitationIs extends OrdersState{
  Invitation invitation;
  InvitationIs(this.invitation);
}

class SelectedInvitationIs extends OrdersState{
  Invitation invitation;
  SelectedInvitationIs(this.invitation);
}

class OrderIs extends OrdersState{
  Order order;
  OrderIs(this.order);
}

class SelectedOrderIs extends OrdersState{
  Order order;
  SelectedOrderIs(this.order);
}

class ComplainIS extends OrdersState{
  ComplainIS();
}

class UpdatedInvitationIs extends OrdersState{
  Invitation invitation;
  bool accept;
  UpdatedInvitationIs(this.invitation,this.accept);
}