
with Text_Io;
use Text_Io;
with Ada.Directories,
Ada.Direct_IO,
Ada.Text_IO;
use Ada.Directories;
with Ada.Text_IO;
with MatrixMult; use MatrixMult;


procedure AssignmentMain is

    ------------------------ Protected OBJ used to halt execution in main proc. while the tasks read matrices input values

    protected Obj is
        procedure Set;
        entry Get;
    private
        Is_Set : Boolean := False;
   end Obj;

    protected body Obj is
        procedure Set is
        begin
            Is_Set := True;
        end Set;

        entry Get
            when Is_Set is
        begin
            Is_Set := False;
        end Get;
   end Obj;


    package Int_Io is new Integer_Io(Integer);
    use Int_Io;

    SIZE : constant Integer := 10;
 
    x : Integer :=0;
--    y : Integer;
--    i : Integer; j : Integer;

    Mat1 : Mt1; 
    Mat2 : Mt2;     
    R : Rt;

    task Reader1 is
        entry startReader1;
    end Reader1;
    task Reader2 is
        entry startReader2;
    end Reader2;
    task Printer is
        entry startPrinter;
    end Printer;

    task body Reader1 is
    begin
        accept startReader1;

        for i in 1..SIZE loop
            for j in 1..SIZE loop
                get(Mat1(i,j));
            end loop;
        end loop;

        Reader2.startReader2;
    end Reader1;

    task body Reader2 is
    begin
        accept startReader2;
        for i in 1..SIZE loop
            for j in 1..SIZE loop
                get(Mat2(i,j));
            end loop;
        end loop;

        Obj.Set;

    end Reader2;

    task body Printer is
    begin
        accept startPrinter;
        Text_Io.Put("Result = "); New_Line;
        for i in 1..SIZE loop
            for j in 1..SIZE loop
                Int_Io.Put(R(i,j));
            end loop;
            New_Line;
        end loop;
    end Printer;

    begin
        Reader1.startReader1;

        Obj.Get;      --The calling task ('assignmentmain' proc.) sleeps until the barrier is released
        MatMult(Mat1, Mat2, R);
        Printer.startPrinter;

end AssignmentMain;