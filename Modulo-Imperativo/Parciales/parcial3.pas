program parcial3;
type
	pasaje = record
		vuelo:integer;
		cliente:integer;
		destino:integer;
		monto:real;
	end;
	pasaje2 = record
		vuelo:integer;
		cliente:integer;
		monto:real;
	end;
	lista = ^nodol;
	nodol = record
		dato:pasaje2;
		sig:lista;
	end;
	datosdestino = record
		datos:lista;
		destino:integer;
	end;
		
	arbol = ^nodo;
	nodo = record
		dato:datosdestino;
		HI:arbol;
		HD:arbol;
	end;
	
procedure leerPasaje (var p:pasaje);
begin
	p.monto:=random(9999)/(random(10)+1);
	if p.monto <> 0 then
	begin
		p.vuelo:=random(7000);
		p.cliente:=random(10)+1;
		p.destino:=random(500)+1;
	end;
end;

procedure agregarAdelante (var l:lista; p:pasaje);
var
	nue:lista;
begin
	new(nue);
	nue^.dato.vuelo:=p.vuelo;
	nue^.dato.monto:=p.monto;
	nue^.dato.cliente:=p.cliente;
	nue^.sig:=l;
	l:=nue;
end;


procedure insertarArbol (var a:arbol; p:pasaje);
begin
	if a=nil then
	begin
		new(a);
		a^.dato.destino:=p.destino;
		a^.dato.datos:= nil;
		agregarAdelante(a^.dato.datos,p);
		a^.HI:=nil;
		a^.HD:=nil;
	end
	else if a^.dato.destino = p.destino then
		agregarAdelante(a^.dato.datos,p)
	else if a^.dato.destino > p.destino then
		insertarArbol(a^.HI,p)
	else
		insertarArbol(a^.HD,p);
end;

procedure cargarArbol (var a:arbol);
var
	p:pasaje;
begin
	leerPasaje(p);
	while p.monto <> 0 do
	begin
		insertarArbol(a,p);
		leerPasaje(p);
	end;
end;

procedure recorrerLista (l:lista);
begin
	while l<>nil do
	begin
		writeln('vuelo: ',l^.dato.vuelo,' cliente: ',l^.dato.cliente, ' monto : ',l^.dato.monto:2:2);
		l:=l^.sig;
	end;
end;

procedure recorrerArbol (a:arbol; dest:integer;var cumple:boolean);
begin
	if ((a<>nil) and (cumple=false)) then
	begin
		recorrerArbol(a^.HI,dest,cumple);
		if dest = a^.dato.destino then
		begin
			writeln('Destino : ',a^.dato.destino);
			recorrerLista(a^.dato.datos);
			cumple:=true;
		end;
		recorrerArbol(a^.HD,dest,cumple);
	end;
end;

procedure buscarDestino(a:arbol);
var
	dest:integer;
	cumple:boolean;
begin
	writeln('Ingrese la ciudad destino para ver sus viajes');
	readln(dest);
	cumple:=false;
	recorrerArbol(a,dest,cumple);
	if cumple=false then
		writeln('No hubo viajes a ese destino!');
end;

procedure actualizarMax (l:lista; var max,maxviajes:integer; destino:integer);
var
	cant:integer;
begin
	cant:=0;
	while l<>nil do
	begin
		cant:=cant+1;
		l:=l^.sig;
	end;
	if cant>maxviajes then
	begin
		maxviajes:=cant;
		max:=destino;
	end;
end;

procedure recorrerArbolViajes(a:arbol; var max,maxviajes:integer);
begin
	if a<>nil then
	begin
		recorrerArbolViajes(a^.HI,max,maxviajes);
		actualizarMax(a^.dato.datos,max,maxviajes,a^.dato.destino);
		recorrerArbolViajes(a^.HD,max,maxviajes);
	end;
end;

procedure ciudadMax (a:arbol);
var
	max,maxviajes:integer;
begin
	maxviajes:=0;
	recorrerArbolViajes(a,max,maxviajes);
	writeln('La ciudad que mas viajes tuvo fue la ',max,' con ',maxviajes,' viajes!');
end;


var
	a:arbol;


begin
	randomize;
	cargarArbol(a);
	buscarDestino(a);
	ciudadMax(a);
end.
