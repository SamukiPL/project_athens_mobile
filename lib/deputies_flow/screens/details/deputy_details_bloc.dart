import 'package:project_athens/athens_core/presentation/base_blocs/base_bloc.dart';
import 'package:project_athens/deputies_utils/domain/subscribed_deputy_model.dart';

class DeputyDetailsBloc extends BaseBloc {

  final SubscribedDeputyModel _deputyModel;

  DeputyDetailsBloc(this._deputyModel);

  SubscribedDeputyModel get deputyModel => _deputyModel;
}
