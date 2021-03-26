import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';         
import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hellotori/configs/configs.dart';
import 'package:hellotori/configs/hello_tori_icons.dart';
import 'package:hellotori/model/model.dart';
import 'package:hellotori/providers/providers.dart';
import 'package:hellotori/widgets/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:image_picker/image_picker.dart';

part "authentication/auth_widget.dart";
part "authentication/auth_page.dart";
part "authentication/onboarding_pages.dart";
part "homepage/event_page.dart";
part "homepage/detailed_event_page.dart";
part "homepage/school_page.dart";
part "homepage/osis_page.dart";
part "homepage/public_chat_page.dart";
part "homepage/live_event_page.dart";
part "homepage/profile_page.dart";
part "template/splash_content.dart";
part "template/header_page.dart";
part "template/image_previewer.dart";
part "adminer/admin_add_event.dart";
