with Text_Io;
use Text_Io;

package body MatrixMult is

    package Int_Io is new Integer_Io(Integer);
    use Int_Io;
    
    task body TT is
    begin
        accept Start (i1 : Integer; j1 : Integer; M1 : in Mt1;    M2 : in Mt2;     R : in out Rt) do
            for k in 1..SIZE loop
		        R(i1,j1) := R(i1,j1) + (M1(i1,k) * M2(k,j1)) ;
            end loop;
        end Start;
    end TT;

    TaskArr : array (1..SIZE*SIZE) of TT;
    TaskCtr : Integer;


    procedure MatMult (M1 : in Mt1;    M2 : in Mt2;     R : in out Rt) is
    begin
        New_Line;    

        TaskCtr := 1;
        for i in 1..SIZE loop
	        for j in 1..SIZE loop
	            R(i,j) := 0;
                TaskArr(TaskCtr).Start(i, j, M1, M2, R);
                TaskCtr := TaskCtr + 1;
                
            end loop;
        end loop;

    end MatMult;
end MatrixMult;