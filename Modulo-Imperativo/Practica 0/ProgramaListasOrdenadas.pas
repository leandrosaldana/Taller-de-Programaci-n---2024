program ProgramaListasOrdenadas;
type
	lista = ^nodo;
	nodo = record
		dato:integer;
		sig:lista;
	end;
	
procedure insertarOrdenado(var l:lista; num:integer);
var  
	act,ant,nue:lista;
begin
     new(nue);
     nue^.dato:= num;
     ant:= L;
     act:= L;
     while (act <> nil)and(act^.dato < num)do begin
          ant:= act;
          act:= act^.sig;
     end;
     if(ant = act)then L:= nue
                  else ant^.sig:= nue;
     nue^.sig:= act;
end;
	
procedure cargarListaOrdenada(var l:lista);
var
	num:integer;
begin
	num:=random(150-100)+100;
	insertarOrdenado(l,num);
	while num<>120 do
	begin
		num:=random(150-100)+100;
		insertarOrdenado(l,num);
	end;
end;

procedure imprimirLista (l:lista);
begin
     while( L <> nil )do begin
          writeln( L^.dato );
          L:= L^.sig;
     end;
end;

function buscarElementoOrdenado (l:lista; num:integer):boolean;
var
	existe:boolean;
begin
	existe:=false;
	while ((l<>nil) and (l^.dato < num)) do
	begin
		l:=l^.sig;
	end;
	if ((l<>nil) and (l^.dato = num)) then
		existe:=true;
	buscarElementoOrdenado:=existe;
end;

var
	l:lista;
	num:integer;
	existe:boolean;
begin
	cargarListaOrdenada(l);
	imprimirLista(l);
	writeln('Ingrese el valor a buscar');
	readln(num);
	existe:=buscarElementoOrdenado(l,num);
	writeln(existe);
end.
