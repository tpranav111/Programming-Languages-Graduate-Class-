import java.util.*;

class SortedList<T extends Comparable<T>> extends ArrayList<T> implements Comparable<SortedList<T>> {

  @Override
  public int compareTo(SortedList<T> oSL) {
    final int n;
    if(this.size() <= oSL.size())
    {
        n = this.size();
    }
    else
    {
        n = oSL.size();
    }

    for (int i = 0; i < n; ++i) {
      if (this.get(i).compareTo(oSL.get(i)) < 0) {
        return -1;
      }
    }

    if (this.size() == oSL.size())
    {
      return 0;
    }
    else if (this.size() < oSL.size())
    {
        return -1;
    }
    else
    {
        return 1;
    }
  }
    @Override
  public boolean add(T element) {
    if (this.isEmpty()) {
      return super.add(element);
    }

    for (int i = 0; i < this.size(); ++i) 
    {
      if (this.get(i).compareTo(element) > 0) 
      {
        this.add(i, element);
        return true;
      }
    }

    return super.add(element);
  }
}

class A implements Comparable<A> {
  Integer x;

  public A(Integer x) {
    this.x = x;
  }

  Integer getVal() {
    return x;
  }

  @Override
  public int compareTo(A obj) {
    return getVal().compareTo(obj.getVal());
  }

  @Override
  public String toString() {
    return "A<" + x + ">";
  }
}

class B extends A {
  Integer y;

  public B(Integer x, Integer y) {
    super(x);
    this.y = y;
  }

  @Override
  Integer getVal() {
    return x + y;
  }

  @Override
  public String toString() {
    return "B<" + x + "," + y + ">";
  }
}

class Part1 {
  static <T> void addToSortedList(SortedList<? super T> L, T z) 
  {
    L.add(z);
  }

  static void test() {
	SortedList<A> c1 = new SortedList<A>();
	SortedList<A> c2 = new SortedList<A>();
	for(int i = 35; i >= 0; i-=5) {
	    addToSortedList(c1, new A(i));
	    addToSortedList(c2, new B(i+2,i+3));
	}
	
	System.out.print("c1: ");
	System.out.println(c1);
	
	System.out.print("c2: ");
	System.out.println(c2);

	switch (c1.compareTo(c2)) {
	case -1: 
	    System.out.println("c1 < c2");
	    break;
	case 0:
	    System.out.println("c1 = c2");
	    break;
	case 1:
	    System.out.println("c1 > c2");
	    break;
	default:
	    System.out.println("Uh Oh");
	    break;
	}
   }

  public static void main(String[] args) {
    test();
  }
}