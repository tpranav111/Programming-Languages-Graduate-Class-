with Text_Io;
use Text_Io;

package MatrixMult is
    X : Integer;
    SIZE : constant Integer := 10;
    
    type Mt1 is array (1 .. SIZE, 1 .. SIZE) of Integer;
    type Mt2 is array (1 .. SIZE, 1 .. SIZE) of Integer;
    type Rt is array (1 .. SIZE, 1 .. SIZE) of Integer;

    task type TT is
        entry Start (i1 : Integer; j1 : Integer; M1 : in Mt1;    M2 : in Mt2;     R : in out Rt);
    end TT;

    procedure MatMult (M1 : in Mt1;    M2 : in Mt2;     R : in out Rt);
end MatrixMult;