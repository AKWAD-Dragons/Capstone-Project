import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sercl/PODO/Order.dart';
import 'package:sercl/PODO/Service.dart';
import 'package:sercl/bloc/orders/bloc.dart';
import 'package:sercl/resources/colors.dart';
import 'package:sercl/resources/dimens.dart';
import 'package:sercl/support/router.gr.dart';
import 'package:sercl/resources/res.dart';

class FiltersPage extends StatefulWidget {
  @override
  _FiltersPageState createState() => _FiltersPageState();
}

class _FiltersPageState extends State<FiltersPage> {
  List <String>selectedStatus = [];
  List <Service>selectedServices = [];
  List <String>selectedZips = [];
  TextEditingController zipController = TextEditingController();
  List<String> statusList = [
    AppStrings.s_pending,
    AppStrings.s_inProgress,
    AppStrings.s_complete,
    AppStrings.s_paid,
  ];
  Map statusMap = {
    AppStrings.s_pending: CodeStrings.c_pending,
    AppStrings.s_inProgress: CodeStrings.r_in_progress,
    AppStrings.s_complete: CodeStrings.r_complete,
    AppStrings.s_paid: CodeStrings.c_paid,
  };
  final OrdersBloc _ordersBloc = GetIt.instance<OrdersBloc>();
  List<Service> _services = [];
  List<Order> searchOrderList = [];

  @override
  void initState() {
    _ordersBloc.ordersStateSubject.listen((receivedState) {
      if (receivedState is FilterDataIs){
        if (mounted){
          setState(() {
            selectedServices = receivedState.oldFilterServices;
            selectedStatus = receivedState.status;
            _services = receivedState.allServices;
            selectedZips = receivedState.zipCodes;
            if (selectedZips.isNotEmpty){
              zipController.text = selectedZips.elementAt(0);
            }
            else{
              zipController.text = "";
            }
          });
        }
      }
    });
    _ordersBloc.dispatch(FiltersScreenLaunched());
    super.initState();
  }

  updateStatusMap(){
    statusMap = {
      AppStrings.s_pending: CodeStrings.c_pending,
      AppStrings.s_inProgress: CodeStrings.r_in_progress,
      AppStrings.s_complete: CodeStrings.r_complete,
      AppStrings.s_paid: CodeStrings.c_paid,
    };
  }

  @override
  Widget build(BuildContext context) {
    updateStatusMap();
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child:  Container(
          margin: EdgeInsets.only(left: AppDimens.screenPadding, top: 10, bottom: 20),
          child: applyButton(),
        ),
        elevation: 0,
      ),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.accentColor,
          ),
          onPressed: () => MainRouter.navigator.pop(context),
        ),
        actions: <Widget>[
          Center(
            child: Container(
              child: FlatButton(
                color: Colors.transparent,
                onPressed: () {
                  _ordersBloc.dispatch(
                    ClearFiltersRequested(),
                  );
                },
                child: Text(
                  AppStrings.clear,
                  style: TextStyle(
                      color: AppColors.errorColor,
                      fontSize: AppDimens.headerFontSize),
                ),
              ),
            ),
          )
        ],
        backgroundColor: AppColors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Screen Header
            Container(
              margin:
                  EdgeInsets.only(left: AppDimens.screenPadding, bottom: 40),
              child: Text(
                AppStrings.filters,
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            categoriesHeader(),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  top: AppDimens.screenPadding,
                  left: AppDimens.screenPadding,
                  right: AppDimens.screenPadding,
                ),
                child: Wrap(spacing: 10, children: _buildFiltersList())),

            Container(
              margin: EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                  left: AppDimens.screenPadding,
                  right: AppDimens.screenPadding),
              color: AppColors.border,
              height: 1,
            ),

            statusSection(),
            Container(
              margin: EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                  left: AppDimens.screenPadding,
                  right: AppDimens.screenPadding),
              color: AppColors.border,
              height: 1,
            ),

            zipCodeSection(),

          ],
        ),
      ),
    );
  }

  Widget zipCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: AppDimens.screenPadding),
          child: Row(
            children: <Widget>[
              Image.asset(
                "assets/images/location.png",
                width: 20,
              ),
              SizedBox(
                width: 15.0,
              ),
              Text(
                AppStrings.area,
                style: TextStyle(fontSize: AppDimens.headerFontSize),
              ),
            ],
          ),
        ),
        Container(
          width: 150,
          margin: EdgeInsets.only(
              top: 15.0,
              left: AppDimens.screenPadding,
              right: AppDimens.screenPadding),
          padding: EdgeInsets.only(left: 10.0),
          child: TextFormField(
            controller: zipController,
            keyboardType: TextInputType.number,
            maxLength: 5,
            decoration: InputDecoration(
              hintText: AppStrings.zip,
              hintStyle: TextStyle(color: AppColors.hint),
            ),
          ),
        ),
      ],
    );
  }

  Widget statusSection() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: AppDimens.screenPadding),
          child: Row(
            children: <Widget>[
              Image.asset(
                "assets/images/tag.png",
                width: 25,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                AppStrings.status,
                style: TextStyle(fontSize: AppDimens.headerFontSize),
              ),
            ],
          ),
        ),
        Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              top: AppDimens.screenPadding,
              left: AppDimens.screenPadding,
              right: AppDimens.screenPadding,
            ),
            child: Wrap(
              spacing: 10,
              children: _buildStatusList(),
            )),
      ],
    );
  }

  Widget categoriesHeader() {
    return Container(
      margin: EdgeInsets.only(left: AppDimens.screenPadding),
      child: Row(
        children: <Widget>[
          Image.asset(
            "assets/images/fix.png",
            width: 25,
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            AppStrings.categories,
            style: TextStyle(fontSize: AppDimens.headerFontSize),
          ),
        ],
      ),
    );
  }

  Widget applyButton() {
    return InkWell(
      onTap: () {
        if (zipController.text.isNotEmpty){
          selectedZips.add(zipController.text);
        }
        else{
          selectedZips = [];
        }
        _ordersBloc.dispatch(
          FilterAdded(status: selectedStatus, services: selectedServices, zipCode: selectedZips),
        );
        Navigator.pop(context);
      },
      child: Container(
          decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50))),
          width: double.infinity,
          height: 60,
          child: Container(
            padding: EdgeInsets.only(
                left: AppDimens.buttonPadding, right: AppDimens.buttonPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Text(
                    AppStrings.applyFilters,
                    style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Image.asset(
                  "assets/images/forward.png",
                  width: 20,
                  height: 20,
                )
              ],
            ),
          )),
    );
  }

  List<Widget> _buildFiltersList() {
    List<Widget> widgets = List();

    for (int i = 0; i < _services.length; i++) {
      widgets.add(Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                if (selectedServices.contains(_services[i])) {
                  selectedServices.remove(_services[i]);
                } else {
                  selectedServices.add(_services[i]);
                }
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: selectedServices.contains(_services[i])
                      ? AppColors.accentColor
                      : AppColors.lightBackground,
                  borderRadius:
                      BorderRadius.circular(AppDimens.statusCardRadius)),
              child: Text(
                _services[i].name,
                style: TextStyle(
                    fontSize: 14.0,
                    color: selectedServices.contains(_services[i])
                        ? AppColors.white
                        : AppColors.primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          )
        ],
      ));
    }

    return widgets;
  }

  List<Widget> _buildStatusList() {
    List<Widget> widgets = List();
    for (int i = 0; i < statusList.length; i++) {
      widgets.add(InkWell(
        onTap: () {
          setState(() {
            if (selectedStatus.contains(statusMap[statusList[i]])) {
              selectedStatus.remove(statusMap[statusList[i]]);
            } else {
              selectedStatus.add(statusMap[statusList[i]]);
            }
          });
        },
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: selectedStatus.contains(statusMap[statusList[i]])
                  ? AppColors.accentColor
                  : AppColors.lightBackground,
              borderRadius: BorderRadius.circular(AppDimens.statusCardRadius)),
          child: Text(
            statusList[i],
            style: TextStyle(
                fontSize: 14.0,
                color: selectedStatus.contains(statusMap[statusList[i]])
                    ? AppColors.white
                    : AppColors.primaryColor),
          ),
        ),
      ));
    }
    return widgets;
  }
}
