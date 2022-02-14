import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:get/get.dart';

class TreeState{

  var _trees = Rx<List<Tree>>([]);
  get trees => _trees.value;
  set trees(value) => _trees.value = value;

  var selectedTree = Rxn<Tree>();

  TreeState();
}