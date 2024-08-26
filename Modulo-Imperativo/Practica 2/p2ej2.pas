program p2ej2;

type
	lista = ^nodo;
	nodo = record
		dato:integer;
		sig:lista;
	end;

procedure agregarAdelante(var l:lista; i:integer);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=i;
	nue^.sig:=l;
	l:=nue;
end;


procedure cargarListaRecursiva (var l:lista);
var
	i:integer;
begin
	i:=random(101)+100;
	if i = 100 then
		writeln('Num 100 generado!');
	if i<>100 then
	begin
		agregarAdelante(l,i);
		cargarListaRecursiva(l);
	end;
end;

procedure imprimirLista (l:lista);
begin
	while l<>nil do
	begin
		writeln(l^.dato);
		l:=l^.sig;
	end;
	writeln('Termino la iteracion!');
end;


procedure imprimirListaRecursivo (l:lista);
begin
	if l<>nil then
	begin
		writeln(l^.dato);
		imprimirListaRecursivo(l^.sig);
	end;
end;


procedure imprimirListaRecursivoInverso (l:lista);
begin
	if l<>nil then
	begin
		imprimirListaRecursivoInverso(l^.sig);
		writeln(l^.dato);
	end;
end;

procedure buscarMinimo (l:lista; var min:integer);
begin
	if l<>nil then
	begin
		if min > l^.dato then
			min:=l^.dato;
		buscarMinimo(l^.sig,min);
	end;
end;

function valorMinimo (l:lista):integer;
var
	min:integer;
begin
	min:=200;
	buscarMinimo(l,min);
	valorMinimo:=min;
end;

procedure buscarNum(l:lista; num:integer; var ok:boolean);
begin
	if ((l<>nil) and (ok = false)) then
	begin
		if l^.dato <> num then
			buscarNum(l^.sig,num,ok)
		else
			ok:=true;
	end;
end;
			

function seEncuentra (l:lista):boolean;
var
	num:integer;
	ok:boolean;
begin
	ok:=false;
	writeln('Ingrese un valor a buscar ');
	readln(num);
	buscarNum(l,num,ok);
	seEncuentra:=ok;
end;

var
	l:lista;


begin
	randomize;
	cargarListaRecursiva(l);
	imprimirLista(l);
	imprimirListaRecursivo(l);
	writeln('Termino el recursivo!');
	imprimirListaRecursivoInverso(l);
	writeln('el valor minimo de la lista es de ',valorMinimo(l));
	if seEncuentra(l) then
		writeln('Se encuentra el valor!')
	else
		writeln('No se encuentra el valor');
end.
