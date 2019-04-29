
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:partnership/model/StreamWrapper.dart';
import 'package:partnership/model/AModelFactory.dart';
import 'package:partnership/utils/PayloadsFactory.dart';

abstract class AModel implements AModelFactory{
  AModel(){
  }
}