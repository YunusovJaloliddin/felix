import 'dart:async';

import 'package:felix/common/blocs/create_map/create_map_bloc.dart';
import 'package:felix/common/utils/context_util/context_util.dart';
import 'package:felix/common/utils/text_field/custom_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

import '../../l10n/app_localizations.dart';

class ClubsAdsAddScreen extends StatefulWidget {
  const ClubsAdsAddScreen({super.key});

  @override
  State<ClubsAdsAddScreen> createState() => _ClubsAdsAddScreenState();
}

class _ClubsAdsAddScreenState extends State<ClubsAdsAddScreen> {
  final Completer<YandexMapController> _completer = Completer();
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descriptionEditingController = TextEditingController();
  TextEditingController addressEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ValueNotifier<List<MapObject>> mapObjects = ValueNotifier([]);

  double late=0;
  double long=0;

  @override
  void dispose() {
    titleEditingController.dispose();
    descriptionEditingController.dispose();
    addressEditingController.dispose();
    super.dispose();
  }

  void listener(context, state, l10n) {
    if (state is CreatePostSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.created),
          backgroundColor: Colors.green,
        ),
      );
      titleEditingController.text = "";
      descriptionEditingController.text = "";
    }
    if (state is CreatePostFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.noCreated),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void save () {
    if (formKey.currentState!.validate()) {
      context.read<CreatePostBloc>().add(
        CreatePost(
          titleEditingController.text,
          descriptionEditingController.text,
          late,
          long,
        ),
      );
    }
  }

  void onTap(argument) {
    PlacemarkMapObject point = PlacemarkMapObject(
      mapId: const MapObjectId("user"),
      point: argument,
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            "assets/icons/marker.png",
          ),
          scale: 1 / 8,
        ),
      ),
    );
    late=argument.latitude;
    long=argument.longitude;
    mapObjects.value = [point];
  }

  void onMapCreated(controller) async {
    _completer.complete(controller);
    await controller.toggleUserLayer(visible: true);
    await controller.getUserCameraPosition();
    Position position =
    await Geolocator.getCurrentPosition();
    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: position.latitude,
            longitude: position.longitude,
          ),
        ),
      ),
    );
    late=position.latitude;
    long=position.longitude;
    mapObjects.value = [
      PlacemarkMapObject(
        mapId: const MapObjectId("user"),
        point: Point(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
              image: BitmapDescriptor.fromAssetImage(
                "assets/images/marker.png",
              ),
              scale: 1 / 8),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = MediaQuery.sizeOf(context);
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "X ${l10n.newAds}",
            style: context.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            BlocListener<CreatePostBloc, CreatePostState>(
              listener: (context, state) => listener(context, state, l10n),
              child: IconButton(
                onPressed: save,
                icon: const Icon(Icons.arrow_forward, color: Colors.blue),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomTextField(
                  mainText: l10n.title,
                  hintText: l10n.enterProductTitle,
                  controller: titleEditingController,
                  address: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  mainText: l10n.description,
                  hintText: l10n.enterDescription,
                  controller: descriptionEditingController,
                  maxLines: 8,
                  address: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width * 0.18,
                      height: 1,
                      child: const ColoredBox(
                        color: Colors.black,
                      ),
                    ),
                    Text(l10n.changeLocation),
                    SizedBox(
                      width: size.width * 0.18,
                      height: 1,
                      child: const ColoredBox(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextField(
                  mainText: l10n.addressByLocation,
                  hintText: l10n.enterAddress,
                  controller: addressEditingController,
                  address: true,
                ),
              ),
              SizedBox.square(
                dimension: size.width,
                child: ValueListenableBuilder(
                    valueListenable: mapObjects,
                    builder: (context, value, child) {
                      return YandexMap(
                        onMapTap: onTap,
                        gestureRecognizers: {
                          Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                          ),
                        },
                        mapObjects: mapObjects.value,
                        onMapCreated: onMapCreated,
                        rotateGesturesEnabled: false,
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
