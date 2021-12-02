import 'package:flutter_wan/data/response_wan.dart';
import 'package:flutter_wan/data/tree.dart';
import 'package:get/get.dart';

class TreeState{

  var trees = Rxn<ResponseWan<List<Tree>>>();
  var selectedTree = Rxn<Tree>();

  TreeState();
}