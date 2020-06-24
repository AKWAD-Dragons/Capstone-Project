import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sercl/resources/res.dart';
import 'package:sercl/PODO/Invitation.dart';
import 'package:sercl/PODO/Album.dart';
import 'package:photo_view/photo_view.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_player/video_player.dart';
import 'package:sercl/bloc/orders/bloc.dart';
import 'package:get_it/get_it.dart';

class InvitationDetails extends StatefulWidget {
  @override
  _InvitationDetailsState createState() => _InvitationDetailsState();
}

class _InvitationDetailsState extends State<InvitationDetails> {
  VideoPlayerController controller;
  bool isPlaying = false;
  bool isPaused = false;
  bool _isCompleted = true;
  double seekValue = 0;
  AudioPlayer _audioPlayer = AudioPlayer();
  Duration _totalDuration;
  Duration _currentPosition;
  String _currentTime = "";
  Invitation invitation;
  OrdersBloc _ordersBloc = GetIt.instance<OrdersBloc>();

  @override
  void initState() {

    _ordersBloc.ordersStateSubject.listen((receivedState) {
      if (receivedState is SelectedInvitationIs) {
        if (mounted){
          setState(() {
            this.invitation = receivedState.invitation;
          });
        }
      }
    });
    _audioPlayer.onPlayerStateChanged.listen((AudioPlayerState state) {
      if (state == AudioPlayerState.PLAYING) {
        if (mounted) {
          setState(() {
            isPlaying = true;
            _isCompleted = false;
          });
        }
      }

      if (state == AudioPlayerState.PAUSED) {
        if (mounted) {
          setState(() {
            isPlaying = false;
            isPaused = true;
            _isCompleted = false;
          });
        }
      }
    });

    _audioPlayer.onPlayerCompletion.listen((_) {
      setState(() {
        isPlaying = false;
        isPaused = true;
        _isCompleted = true;
        _currentTime = "";
      });
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    _audioPlayer.onAudioPositionChanged.listen((duration) {
      _currentPosition = duration;
      setState(() {
        if (duration != null && _totalDuration != null)
          seekValue = duration.inMilliseconds / _totalDuration.inMilliseconds;

        /// This is an intentional delay to sync the animation
        /// Removing it will cause height overflow
        if (_currentTime.isEmpty) {
          Future.delayed(Duration(milliseconds: 200));
        }

        _currentTime = Duration(milliseconds: duration.inMilliseconds)
                .toString()
                .substring(2, 7) +
            "/" +
            Duration(milliseconds: _totalDuration.inMilliseconds)
                .toString()
                .substring(2, 7);
      });
    });
    //_ordersBloc.dispatch(DetailsScreenLaunched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (invitation == null)return Container();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.accentColor,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppDimens.screenContainerRadius),
            topRight: Radius.circular(AppDimens.screenContainerRadius),
          ),
        ),
        padding: EdgeInsets.only(
            right: AppDimens.screenPadding,
            left: AppDimens.screenPadding,
            top: AppDimens.screenPadding),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              titleRow(),
              SizedBox(
                height: 10,
              ),
              customerDetails(),
              SizedBox(
                height: 5,
              ),
              problemDetails(),
              SizedBox(
                height: 5,
              ),
              Visibility(
                visible: invitation.request.albums.isNotEmpty ||
                    invitation.request.videos.isNotEmpty,
                child: attachments(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget problemDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppDimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppStrings.problemDetails,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: invitation.request.record != null,
              child: player(),
            ),
            SizedBox(
              height: 10,
            ),
            Visibility(
              visible: invitation.request.description != null,
              child: Text(
                invitation.request.description != null
                    ? invitation.request.description
                    : "",
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.darkTextColor,
                    height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget player() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: isPlaying || !_isCompleted ? 85.0 : 60.0,
      color: AppColors.lightBackground,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (isPlaying) {
                    _audioPlayer.pause();
                    return;
                  }

                  if (isPaused) {
                    _audioPlayer.resume();
                    return;
                  }
                  _audioPlayer.play(invitation.request.record);
                },
                child: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  color: AppColors.accentColor,
                  size: 40,
                ),
              ),
              Center(
                child:
                    _currentTime.isNotEmpty ? Text(_currentTime) : Container(),
              )
            ],
          )),
    );
  }

  Widget customerDetails() {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: AppDimens.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppDimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppStrings.customerDetails,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Image.asset(
                  "assets/images/user.png",
                  width: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(invitation.request.customer.name)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "assets/images/pin.png",
                  width: 15,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(invitation.request.address.street_name +
                      " " +
                      invitation.request.address.street_number +
                      " ," +
                      invitation.request.address.postal_code),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget attachments() {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: AppDimens.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppDimens.cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppStrings.attachments,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Wrap(children: imageChildren()),
            Wrap(children: videoChildren())
          ],
        ),
      ),
    );
  }

  List<Widget> imageChildren() {
    List<Widget> children = List();
    for (int i = 0; i < invitation.request.albums.length; i++) {
      children.add(InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Slider(
              invitation.request.albums,
              i,
            );
          }));
        },
        child: singleImage(
            invitation.request.albums.elementAt(i).image_link),
      ));
    }
    return children;
  }

  List<Widget> videoChildren() {
    List<Widget> children = List();
    for (int i = 0; i < invitation.request.videos.length; i++) {
      children.add(InkWell(
        child: videoWidget(
            invitation.request.videos.elementAt(i).video_link),
      ));
    }
    return children;
  }

  Widget singleImage(image) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Image.network(
        image,
        fit: BoxFit.cover,
        height: 60,
        width: 60,
      ),
    );
  }

  Widget titleRow() {
    return Row(children: <Widget>[
      Expanded(
        child: Text(invitation.request.service.name ?? "",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      SizedBox(
          width: 50,
          height: 50,
          child: Image.network(invitation.request.category.icon))
    ]);
  }

  void videoPlayerDialog(String video) async {
    controller = VideoPlayerController.network(video);
    await controller.initialize();
    controller.play();
    controller.setLooping(true);
    if (mounted) {
      await showDialog(
          barrierDismissible: true,
          useRootNavigator: false,
          context: context,
          builder: (BuildContext bContext) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: InkWell(
                      radius: 0,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: controller.value.initialized
                        ? AspectRatio(
                            aspectRatio: controller.value.aspectRatio,
                            child: VideoPlayer(controller),
                          )
                        : CircularProgressIndicator(),
                  ),
                  Positioned(
                    child: BackButton(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            );
          });
    }
    await controller.setLooping(false);
    await controller.pause();
  }

  Widget videoWidget(String video) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: InkWell(
        onTap: () {
          videoPlayerDialog(video);
        },
        child: Image.asset(
          "assets/images/thumbnail.png",
          fit: BoxFit.cover,
          height: 60,
          width: 60,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (controller != null) controller.pause();

    if (isPlaying) _audioPlayer.stop();
    super.dispose();
  }
}

class Slider extends StatelessWidget {
  Slider(this.albums, this.current);

  final List<Album> albums;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: AppDimens.screenPadding, top: 40),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: AppColors.white,
                ),
                color: AppColors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Expanded(
              child: CarouselSlider.builder(
                aspectRatio: 1,
                itemCount: albums.length,
                initialPage: current,
                autoPlay: false,
                enableInfiniteScroll: false,
                enlargeCenterPage: false,
                height: double.infinity,
                viewportFraction: 1.0,
                itemBuilder: (BuildContext context, int itemIndex) => Center(
                  child: Container(
                      child: PhotoView(
                          imageProvider:
                              NetworkImage(albums[itemIndex].image_link))),
                ),
              ),
            )
          ],
        ));
  }
}
