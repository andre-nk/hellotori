import 'dart:core';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hellotori/model/model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

part "shared_preferences.dart";
part 'firestore_database.dart';
part "storage_service.dart";
part "transaction_service.dart";