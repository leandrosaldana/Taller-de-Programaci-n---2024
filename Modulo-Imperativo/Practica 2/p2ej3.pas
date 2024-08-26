program ej3;
const
	max=20;
type
	indice = -1..max;
	vector = array [indice] of integer;

procedure cargarVector (var v:vector; var pos:indice);
var
	num:integer;
	
begin
	num:=random(1251)+300;
	if pos<max then
	begin
		writeln(num);
		pos:=pos+1;
		v[pos]:=num;
		cargarVector(v,pos);
	end;
end;

procedure insercion (var v:vector;max:indice);
var 
	i,j,actual:integer;
begin
	for i:=2 to max do begin 
		actual:=v[i];
		j:=i-1;
		while (j>0) and (v[j]>actual) do begin 
			v[j+1]:=v[j];
			j:=j-1;
		end;
		v[j+1]:=actual;
	end;
end;

procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
var
    medio:indice;
begin
    if (ini>fin) then
        pos:=-1
    else begin
        medio:= (ini + fin) div 2;
        if (v[medio]=dato) then
            pos:=medio
        else if (dato<v[medio]) then
            busquedaDicotomica(v,ini,medio-1,dato,pos)
        else
            busquedaDicotomica(v,medio+1,fin,dato,pos);
    end;
end;

procedure imprimirVector (v:vector);
var
	i:integer;
begin
	for i:=1 to max do
		writeln(v[i]);
end;


var
	v:vector;
	pos:indice;
	dato:integer;
begin
	randomize;
	pos:=0;
	cargarVector(v,pos);
	writeln('--------------');
	imprimirVector(v);
	insercion(v,max);
	writeln('--------------------------');
	imprimirVector(v);
	writeln('Ingrese num a buscar');
	readln(dato);
	busquedaDicotomica(v,1,max,dato,pos);
	writeln(pos);
end.
