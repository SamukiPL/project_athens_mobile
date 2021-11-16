import 'package:flutter/cupertino.dart';
import 'package:project_athens/athens_core/ads/native_ad/native_ad_bloc.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdWidget extends StatefulWidget {
  final NativeAdBloc bloc;

  const NativeAdWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoadedNativeAdState(bloc);
  }
}

class LoadedNativeAdState extends State<NativeAdWidget> {
  final NativeAdBloc bloc;

  LoadedNativeAdState(this.bloc);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NativeAdBloc>.value(
      value: bloc,
      child: Consumer<NativeAdBloc>(
        builder: (context, bloc, _) {
          bloc.visibilityChanged(true);
          return Container(
            child: AdWidget(ad: bloc.ad),
            height: 72,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    bloc.visibilityChanged(false);
    super.dispose();
  }

}


