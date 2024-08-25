program p2ej1;
const
	max = 15;
type
	vector = array [1..max] of integer;
	
	
procedure cargarVectorRecursivo (var v:vector; var dimL:integer);
var
	num:integer;
begin
	num:=random(146)+10;
	writeln('numero random :',num);
	if ((num <> 20) and (dimL < 15)) then begin
		dimL:=dimL+1;
		v[dimL]:=num;
		cargarVectorRecursivo(v,dimL);
	end;
end;

procedure cargarVector(var v:vector; var dimL:integer);
begin
	dimL:=0;
	cargarVectorRecursivo(v,dimL);
end;

procedure imprimirVector(v:vector; dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
		writeln(v[i]);
end;

procedure imprimirVectorRecursivo(v:vector; dimL:integer);
begin
	if (dimL > 0) then
	begin
		imprimirVectorRecursivo(v,diml-1);
		writeln(v[dimL]);
	end;
end;

function sumarRecursivo (v: vector; pos, dimL: integer): integer;
begin
    if (pos <= dimL) then 
    begin
		if v[pos] mod 2 = 0 then
			sumarRecursivo:= sumarRecursivo (v, pos + 1, dimL) + v[pos]
		else 
			sumarRecursivo:=sumarRecursivo (v,pos +1,dimL);
	end
    else sumarRecursivo:=0;
end;	
   
function sumar (v: vector; dimL: integer): integer; 
var 
	pos: integer; 
begin
	pos:= 1;
	Sumar:= sumarRecursivo (v, pos, dimL);
end;

function obtenerMaximoRecursivo(v:vector; dimL:integer;aux:integer):integer;
begin
	if dimL > 0 then
	begin
		if v[dimL] > aux then
			aux:=v[dimL];
		obtenerMaximoRecursivo:=obtenerMaximoRecursivo(v,dimL-1,aux);
	end
	else obtenerMaximoRecursivo:=aux;
end;

function  obtenerMaximo (v: vector; dimL: integer): integer;
var
	aux:integer;
begin
	aux:=0;
	obtenerMaximo:=obtenerMaximoRecursivo(v,dimL,aux);
end;     
 
function buscarValorRecursivo(v:vector;dimL,valor:integer):boolean;
begin
	if (dimL = 0) then
		buscarValorRecursivo:=false
	else
	begin
		if (valor = v[dimL]) then
		begin
			buscarValorRecursivo:=true
		end
		else begin
			buscarValorRecursivo:=buscarValorRecursivo(v,dimL-1,valor);//sigue buscando
		end;
	end;
end;
		
     
function  buscarValor (v: vector; dimL:integer): boolean;
var
	valor:integer;
begin
	writeln('Ingrese valor a encontrar');
	readln(valor);
	if buscarValorRecursivo(v,dimL,valor) then
	begin
		writeln('El valor se encontro');
		buscarValor:=true;
	end
	else begin
		writeln('el valor no se encontro');
		buscarValor:=false;
	end;
end; 

procedure imprimir(num:integer);
begin
	if num < 10 then
		writeln(num)
	else 
	begin
		imprimir(num div 10);
		writeln(num mod 10);
	end;
end;

procedure imprimirDigitos (v:vector; dimL:integer);
begin
	if dimL > 0 then
	begin
		imprimir(v[dimL]);
		imprimirDigitos(v,dimL-1);
	end;
end;

var
	v:vector;
	dimL:integer;
begin
	randomize;
	cargarVector(v,dimL);
	imprimirVector(v,dimL);
	writeln('recursivo');
	imprimirVectorRecursivo(v,dimL);
	writeln('la suma del vector es ',sumar(v,diml));
	writeln('el maximo del vector es ',obtenerMaximo(v,dimL));
	buscarValor(v,dimL);
	imprimirDigitos(v,dimL);
end.
