program p2ej4;

procedure binario(num:integer);
begin
    if num>0 then begin
        binario(num div 2);
        writeln(num mod 2);
    end;
end;

procedure solicitarNumeros();
var
    num:integer;
begin
    writeln('Ingrese numero en sistema decimal: ');
    readln(num);
    while(num<>0) do begin
        binario(num);
        writeln('Ingrese numero en sistema decimal: ');
        readln(num);
    end;
end;

begin
    solicitarNumeros();
end.
