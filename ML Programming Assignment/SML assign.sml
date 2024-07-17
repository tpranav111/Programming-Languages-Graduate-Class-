Control.Print.printDepth := 100;
Control.Print.printLength := 100;
(*Q1*)

fun merge [] L2 = L2
|	merge L1 []  = L1
|	merge (x::xs) (y::ys) =
	if x < y then
		x::merge (xs) (y::ys)
	else
		y::merge (x::xs) (ys);

merge [1,3,5,7,9] [2,4,6,8,10] ;

(*Q2*)

fun split [] = ([],[])
|	split [a] = ([a],[])
|	split (a::b::cs) = 
		let val (M,N) =
			split cs in (a::M, b::N)
end;

split [1,4,2,6,8,3,9,5,4];

(*Q3*)

fun mergeSort [] = []
|	mergeSort [a] = [a]
|   mergeSort [a,b] =	if a <= b then [a,b] else [b,a]
|   mergeSort L =
        let val (M,N) = split L
        in
merge (mergeSort M) (mergeSort N)
end;

mergeSort [1,7,2,6,8,3,9,5,4];

(*Q4*)
fun sort (op <) nil = nil
  | sort (op <) (p::nil) = [p]
  | sort (op <) L =
let fun split L = 
  let fun aseq nil = nil
      | aseq (p::nil) = [p]
      | aseq (p1::p2::p3) = p1::(aseq p3)
    and
    aseq1 nil = nil
      | aseq1 (p::nil) = nil
      | aseq1 (p1::p2::p3) = p2::(aseq1 p3) in ((aseq L),(aseq1 L))
  end
 fun merge (op <) L nil = L
    | merge (op <) nil L = L
    | merge (op <) (p1::q1) (p2::q2) = if (op <)(p2,p1) then merge (op <) (p2::p1::q1) q2
  else p1::(merge (op <) q1 (p2::q2))
val (L1,L2) = split L
in merge (op <) (sort (op <) L1) (sort (op <) L2)
end;

sort (op <) [1,9, 3, 6, 7];
sort (fn(a,b) => length a < length b) [[1, 9, 3, 6], [1], [2,4,6], [5,5]];


(*Q5*)

datatype 'a tree = empty | leaf of 'a | node of 'a * 'a tree * 'a tree ;

val tree1 = node (5, node (4, leaf 3, empty),
node (8, node (7, leaf 6, empty),
node (9, empty, leaf 10)))

(*Q6*)

fun labels empty = []
  | labels (leaf x) = [x]
  | labels (node(key,left, right)) = labels left @ [key] @ labels right;

labels tree1;

(*Q7*)


(*Q8*)
fun replaceEmpty y empty = y
  | replaceEmpty y (leaf x) = (leaf x)
  | replaceEmpty y (node(key,left, right)) = 
    (node (key, (replaceEmpty y left), (replaceEmpty y right)));

val tree4 = replaceEmpty (node (12, leaf 11, leaf 13)) tree1 ;

labels tree4;

(*Q9*)

fun increment empty = leaf 0
| increment (leaf a) = leaf (a+1)
| increment (node (a, L, R)) = node (a+1, L, R);

fun mapTree f empty = f empty
  | mapTree f (leaf x) = f (leaf x)
  | mapTree f (node (a, L, R)) = f (node (a, mapTree f L, mapTree f R));

val tree5 = mapTree increment tree1;

labels tree5;

(*10*)

fun sortTree (op <) T =
mapTree (fn empty => empty
  | leaf l => leaf (sort (op <) l)
  | node (l, left, right) => node (sort (op <) l, left, right)) T;

val tree6 = node ([1,5,6,8],leaf [1,2,3,4], node ([12,4,16,13], empty, leaf [0,2,5,7])) ;

labels tree6;

val tree7 = sortTree (op <) tree6 ;

labels tree7;
