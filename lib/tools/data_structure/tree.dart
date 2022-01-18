void main() {
  List<int> nums = [4, 2, 1, 3, 5, 7, 6, 8];

  Node first = Node(nums[0]);

  nums.forEach((num) {
    first.add(Node(num));
  });

  print(first);

  print("!!!!${first.search(8)}");
}

class Node {
  final int data;

  Node? left;

  Node? right;

  Node(this.data);

  void add(Node child) {
    if (child.data >= data) {
      if (right == null) {
        right = child;
      } else {
        right?.add(child);
      }
    } else {
      if (left == null) {
        left = child;
      } else {
        left?.add(child);
      }
    }
  }

  Node? search(int num) {
    print("查找中-----${this}");
    if (data == num) {
      return this;
    }

    Node? node = null;
    if (data > num) {
      node = left?.search(num);
    } else if (data < num) {
      return right?.search(num);
    }
    return node;
  }

  @override
  String toString() {
    return 'Node{data: $data, left: $left, right: $right}';
  }
}
