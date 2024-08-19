program programaVectores;

const max = 5;

type vector = array [1..max] of integer;

procedure cargarVector (var v:vector; var pos:integer);
var
	num,max,min:integer;
	
begin
	writeln('ingrese min y max');
	readln(min);
	readln(max);
	num:=random(max-min+1)+min;
	while ((num<>0) and (pos<=50)) do
	begin
		pos:=pos+1;
		v[pos]:=num;
		num:=random(max-min+1)+min;
	end;
end;

procedure imprimirVector (v:vector; pos:integer);
var
	i:integer;
begin
	for i:=1 to pos do
		writeln(v[i]);
end;

procedure imprimirVectorInverso (v:vector; pos:integer);
var
	i:integer;
begin
	for i:= pos downto 1 do
		writeln(v[i]);
end;

var
	v:vector;
	pos:integer;
begin
	randomize;
	pos:=0;
	cargarVector(v,pos);
	imprimirVector(v,pos);
	imprimirVectorInverso(v,pos);
end.
