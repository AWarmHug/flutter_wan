import 'package:flutter/material.dart';

class Node<E> {
  E item;
  Node<E>? next;

  Node(this.item) : next = null;
}

void main(){
  Node<int>? head=Node(0);
  Node<int>? tail=head;

  tail.next=Node(1);
  tail=tail.next;


}