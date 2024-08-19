program ProgramaListas;
type
	lista = ^nodo;
	nodo = record
		dato:integer;
		sig:lista;
	end;
	
procedure agregarAtras (var l:lista; num:integer);
var
	nue,act:lista;
begin
	new(nue);
	nue^.dato:= num;
    nue^.sig:= nil;
    if(L <> nil)then begin
		act:=L;
    while(act^.sig <> nil)do
               act:= act^.sig;
          act^.sig:= nue;
       end
       else
          L:= nue;
end;

procedure cargarLista (var l:lista);
var
	num:integer;
begin
	num :=random(150-100)+100;
	agregarAtras(l,num);
	while num<>120 do
	begin
		num :=random(150-100)+100;
		agregarAtras(l,num);
	end;
end;

procedure imprimirLista (l:lista);
begin
     while( L <> nil )do begin
          writeln( L^.dato );
          L:= L^.sig;
     end;
end;

procedure buscarElemento (l:lista; num:integer; var existe:boolean);
begin
     while(l <> nil)and(l^.dato <> num )do 
     begin
          l:=l^.sig;
     end;
     if(l <> nil)then 
          existe:= true;
end;

var
	l:lista;
	num:integer;
	existe:boolean;
begin
	l:=nil;
	cargarLista(l);
	imprimirLista(l);
	writeln('Ingrese el numero a buscar');
	readln(num);
	existe:=false;
	buscarElemento(l,num,existe);
	writeln(existe);
end.
