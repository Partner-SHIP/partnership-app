import 'package:partnership/model/FBCollections.dart';
import 'package:partnership/model/FBStreamWrapper.dart';
import 'package:partnership/model/AModelFactory.dart';

abstract class AModel implements AModelFactory{
  FBStreamWrapper _streamWrapper;
  String          _collection;
}

