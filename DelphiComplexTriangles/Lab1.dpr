program Lab1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Types,     //Used for type TStringDynArray
  System.StrUtils,  //Used for function SplitString
  Math;             //Used for function ArcCos

type
  Vertice = Record
    realCoord, imaginaryCoord : Double;
  End;

var
  vertices                  : Array[1..3] of Vertice;
  i                         : Integer;
  input                     : String;
  a, b, side1, side2, side3 : Double;
  values                    : TStringDynArray;

procedure getInput;
  begin
    for i := 1 to 3 do
    begin
      Write('Enter vertice #', i, ': ');
      Readln(input);
      values := SplitString(input, 'i+'); //delimits input into values, as split by i, ' ' or +
      vertices[i].realCoord := strtofloat(values[0]);
      vertices[i].imaginaryCoord := strtofloat(values[1]);
    end;

  end;

function getLength(v1, v2 : Vertice) : double;
  begin
    //using a^2 + b^2 = c^2
    a := v1.realCoord - v2.realCoord;
    b := v1.imaginaryCoord - v2.imaginaryCoord;
    Result := sqrt(sqr(a) + sqr(b));
  end;

function getAngle(l1, l2, l3 : double) : double;
begin
    //using cos(A) = (b^2 + c^2 - a^2) / 2bc
    Result := arccos((sqr(l2) + sqr(l3) - sqr(l1))/(2 * l2 * l3))
end;


begin
  try
    getInput;

    side1 := getLength(vertices[1], vertices[2]);
    side2 := getLength(vertices[2], vertices[3]);
    side3 := getLength(vertices[1], vertices[3]);

    //#13#10 is a newline character
    Writeln(#13#10'The side between vertice #1 & vertice #2 is ', side1 , ' in length.');
    Writeln('The side between vertice #2 & vertice #3 is ', side2, ' in length.');
    Writeln('The side between vertice #1 & vertice #3 is ', side3, ' in length.');

    Writeln(#13#10'The angle at vertice #1 is ', getAngle(side1, side2, side3), ' radians.');
    Writeln('The angle at vertice #2 is ', getAngle(side2, side1, side3), ' radians.');
    Writeln('The angle at vertice #3 is ', getAngle(side3, side1, side2), ' radians.');
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;


end.


