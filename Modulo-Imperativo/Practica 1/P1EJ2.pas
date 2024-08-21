program clase1ej2;
const maxOfi = 300;

type datos = record
		codigo:integer;
		dniProp:integer;
		valor:real;
	 end;
	 vector = array[1..maxOfi] of datos;
		
procedure leerDatos (var d:datos);
begin
	writeln('Ingrese el codigo de identificacion de la oficina, -1 para finalizar');
	readln(d.codigo);
	if d.codigo<>-1 then
	begin
		writeln('Ingrese DNI del propietario');
		d.dniProp:=random(10000);
		writeln(d.dniProp);
		writeln('Ingrese el valor de las expensas');
		d.valor:=random(15000);
		writeln(d.valor:2:2);
	end;
end;

procedure crearVector (var v:vector; var dimL:integer);
var
	d:datos;
begin
	dimL:=0;
	leerDatos(d);
	while d.codigo <> -1 do
	begin
		dimL:=dimL+1;
		v[dimL]:=d;
		leerDatos(d);
	end;
end;

procedure imprimirVector (v:vector; dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
	begin
		writeln('Codigo de oficina:',v[i].codigo);
		writeln('DNI del propietario:',v[i].dniProp);
		writeln('Valor expensas :',v[i].valor:2:2);
	end;
end;

Procedure ordenarInsercion ( var v:vector; dimL:integer );
Var
 i, j, actual: integer;	
		
begin
 for i:= 2 to dimL do begin 
     actual:= v[i].codigo;
     j:= i-1; 
     while ((j > 0) and (v[j].codigo > actual)) do      
       begin
         v[j+1].codigo:= v[j].codigo;
         j:=j-1;                
       end;  
     v[j+1].codigo:= actual; 
 end;
end;

procedure ordenarSeleccion (var v:vector;dimL:integer);
var
	i,j,p:integer;
	d:datos;
begin
	for i:=1 to dimL-1 do begin
		p:=i;
		for j:=i+1 to diml do
			if v[j].codigo<v[p].codigo then 
				p:=j;
		d:=v[p];
		v[p]:=v[i];
		v[i]:=d;
	end;
end;

			

var v:vector;
	dimL:integer;

begin
	randomize;
	crearVector(v,dimL);
	imprimirVector(v,dimL);
	ordenarInsercion(v,dimL);
	ordenarSeleccion(v,dimL);
	imprimirVector(v,dimL);
end.
