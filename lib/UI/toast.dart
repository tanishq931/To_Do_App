import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:motion_toast/motion_toast.dart';

toastmsg(BuildContext context){
 MotionToast.success(description:const Text('Task has been added. Make sure you do it'),
 title: const Text('Task Added'),
 ).show(context);


}