
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:partnership/model/StreamWrapper.dart';
import 'package:partnership/model/AModelFactory.dart';
import 'package:partnership/utils/PayloadsFactory.dart';

abstract class AModel implements AModelFactory{
  AModel(){
  }
}