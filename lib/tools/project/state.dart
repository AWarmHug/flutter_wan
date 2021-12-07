import 'package:flutter_wan/data/tree.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../status.dart';

class ProjectPageState{
  Rx<List<Tree>> _trees = Rx([]);
  List<Tree> get trees => _trees.value;
  set trees(List<Tree> value) => _trees.value = value;
}