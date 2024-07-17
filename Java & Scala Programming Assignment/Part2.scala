abstract class Tree[+T];

case class Node[T](label:T, LT:Tree[T], RT:Tree[T]) extends Tree[T];

case class Leaf[T](label:T) extends Tree[T];


trait Addable[T]{
	def +(x:T) : T;
}

class A(x: Int) extends Addable[A] {
  val value = x;
  def +(y: A) = new A(x + y.value);
  override def toString(): String = "A(" + x + ")";
}
/*
class A(var i : Int) extends Addable[A]{
  def +(x:A):A=return new A (this.i + x.i);
  override def toString() : String = return this.getClass.getSimpleName + "(" + i + ")";
}
*/

class B(var p: Int) extends A (p) {
     override def toString() : String = return this.getClass.getSimpleName + "(" + p + ")";
}

class C (var q:Int) extends B(q){
  override def toString() : String = return this.getClass.getSimpleName + "(" + q + ")";
}


object Part2 {
  def test():Unit = {

     def faa(a:A):A = new A(a.value+10)
    def fab(a:A):B = new B(a.value+20)
    def fba(b:B):A = new A(b.value+30)
    def fbb(b:B):B = new B(b.value+40)
    def fbc(b:B):C = new C(b.value+50)
    def fcb(c:C):B = new B(c.value+60)
    def fcc(c:C):C = new C(c.value+70)
    def fac(a:A):C = new C(a.value+80)
    def fca(c:C):A = new A(c.value+90)

    val myBTree: Tree[B] = Node(new B(4),Node(new B(2),Leaf(new B(1)),Leaf(new B(3))), 
		               Node(new B(6), Leaf(new B(5)), Leaf(new B(7))))

    val myATree: Tree[A] = myBTree

    println("inOrder = " + inOrder(myATree))
    println("Sum = " + treeSum(myATree))

    //println(BTreeMap(faa,myBTree))
    println(BTreeMap(fab,myBTree))
    //println(BTreeMap(fba,myBTree))
    println(BTreeMap(fbb,myBTree))
    println(BTreeMap(fbc,myBTree))
    //println(BTreeMap(fcb,myBTree))
    //println(BTreeMap(fcc,myBTree))
    println(BTreeMap(fac,myBTree))
    //println(BTreeMap(fca,myBTree))
    

    println(treeMap(faa,myATree))
    println(treeMap(fab,myATree))
    //println(treeMap(fba,myATree))
    //println(treeMap(fbb,myATree))
    //println(treeMap(fbc,myATree))
    //println(treeMap(fcb,myATree))
    //println(treeMap(fcc,myATree))
    println(treeMap(fac,myATree))
    //println(treeMap(fca,myATree))



  }
  


 def inOrder[T](t:Tree[T]) : List[T] = {
t match {
case Node(v,l,r) =>
inOrder(l):::List(v):::inOrder(r);
case Leaf(v) => List(v);

  
}
}
  def treeSum[T <: Addable[T]](tree: Tree[T]): T = {
    tree match {
      case Leaf(v) => v;
      case Node(v, l, r) =>
        treeSum(l) + v + treeSum(r);
    }
  }
  def treeMap[T, V](func: T => V, t: Tree[T]): Tree[V] = {
    t match {
      case Node(v, l, r) =>
        Node(func(v), treeMap(func, l), treeMap(func, r));
        case Leaf(v) => Leaf(func(v));
    }
  }
  def BTreeMap(func: B => B, t: Tree[B]): Tree[B] = {
    t match {
      case Leaf(v) => Leaf(func(v))
      case Node(v, l, r) =>
        Node(func(v), BTreeMap(func, l), BTreeMap(func, r))
    }
  }

  def main(args: Array[String]) =  { 
    //print(inOrder(myTree));
    test();
    //println("Sum = " + treeSum(myATree))
    
    //println()
  }
}
