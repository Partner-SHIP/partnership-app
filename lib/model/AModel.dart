import 'package:partnership/model/AModelFactory.dart';
import 'AREST.dart';

abstract class AModel implements AModelFactory{
  final IApiREST apiClient = ApiREST();
  AModel();
}