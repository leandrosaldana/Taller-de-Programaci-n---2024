program ProgramaVectores;
const
	max = 5;
type
	vectorAle = array [1..max] of integer;

procedure cargarVector (var v:vectorAle);
var
	ale,a,b,pos:integer;
begin
	pos:=1;
	writeln('Ingrese el rango inicial');
	readln(a);
	writeln('Ingrese el rango final');
	readln(b);
	ale := random (b-a+1)+a;
	while ((pos<=max) and (ale<>0)) do
	begin
		writeln(ale);
		v[pos]:=ale;
		pos:=pos+1;
		ale := random (b-a+1)+a;
	end;
end;

procedure imprimirVector (v:vectorAle);
var
	i:integer;
begin
	for i:=1 to max do
	begin
		writeln(v[i]);
	end;
end;

procedure imprimirVectorOrdenInverso (v:vectorAle);
var
	i:integer;
begin
	for i:=max downto 0 do
	begin
		writeln(v[i]);
	end;
end;

var
	v:vectorAle;
begin
	randomize;
	cargarVector(v);
	imprimirVector(v);
	imprimirVectorOrdenInverso(v);
end.
		

