import 'package:sercl/PODO/Order.dart';
import 'package:sercl/PODO/Service.dart';
import 'package:sercl/PODO/Invitation.dart';
import 'package:sercl/bloc/orders/bloc.dart';
import 'dart:io';

abstract class OrdersEvent {}

class OrdersRequested extends OrdersEvent {
  List<Order> orders;
  String name;

  OrdersRequested({this.orders, this.name});
}
class RejectInvitationRequested extends OrdersEvent{
  String invitationId;
  String spID;
  RejectInvitationRequested(this.invitationId, this.spID);
}

class ServicesRequested extends OrdersEvent {
  ServicesRequested();
}

class AvailableWorkersRequested extends OrdersEvent {
  DateTime date;
  DateTime time;

  AvailableWorkersRequested(this.date, this.time);
}

class FiltersScreenLaunched extends OrdersEvent {
  FiltersScreenLaunched();
}

class ClearFiltersRequested extends OrdersEvent {
  ClearFiltersRequested();
}

class FilterAdded extends OrdersEvent {
  String name;
  List<Service> services;
  List<String> status;
  List<String> zipCode;

  FilterAdded({this.name, this.services, this.status, this.zipCode});
}

class InvitationsTabClicked extends OrdersEvent {
  InvitationsTabClicked();
}

class AssignmentsTabClicked extends OrdersEvent {
  AssignmentsTabClicked();
}

class UploadReceiptRequested extends OrdersEvent {
  File file;
  String orderId;

  UploadReceiptRequested({this.file, this.orderId});
}

class SetPaidRequested extends OrdersEvent {
  String orderId;

  SetPaidRequested(this.orderId);
}

class UpdateInvitationRequested extends OrdersEvent {
  String spID;
  Invitation invitation;
  bool accept;

  UpdateInvitationRequested(this.spID, this.invitation, this.accept);
}

class PriceAdded extends OrdersEvent {
  String spID;
  String price;
  String invitationId;

  PriceAdded(this.spID, {this.price, this.invitationId});
}

class GetInvitation extends OrdersEvent {
  String id;
  bool update = false;

  GetInvitation(this.id, {this.update = false});
}

class InvitationSelected extends OrdersEvent {
  Invitation invitation;

  InvitationSelected(this.invitation);
}

class DetailsScreenLaunched extends OrdersEvent {
  bool isOrder;

  DetailsScreenLaunched(this.isOrder);
}

class OrderRequestedById extends OrdersEvent {
  String id;

  OrderRequestedById(this.id);
}

class ComplainScreenLaunched extends OrdersEvent {
  ComplainScreenLaunched();
}

class ArchiveSelected extends OrdersEvent {}

class ComplainAdded extends OrdersEvent {
  String spID;
  String spEmail;
  String description;

  ComplainAdded(this.spID, this.spEmail, this.description);
}

class OrderSelected extends OrdersEvent {
  Order order;

  OrderSelected(this.order);
}
