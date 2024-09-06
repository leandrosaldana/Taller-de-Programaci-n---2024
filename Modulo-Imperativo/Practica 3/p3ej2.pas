{INCOMPLETO

program p3ej2;
type
	fechas = 1..31;
	venta = record
		codigo:integer;
		fecha:fechas;
		cant:integer;
	end;
	arbol = ^nodo;
	nodo = record
		dato:venta;
		HI:arbol;
		HD:arbol;
	end;
	producto = record
		codigo:integer;
		cant:integer;
	end;
	arbolP = ^nodoP;
	nodoP = record
		dato:producto;
		HI:arbolP;
		HD:arbolP;
	end;
	lista = ^nodoL;
	nodoL = record
		dato:integer;
		sig:lista;
	end;
	codigoVentas = record
		codigo:integer;
		ventas:lista;
	end;
	arbolL = ^nodoLista;
	nodoLista = record
		dato:codigoVentas;
		HI:arbolL;
		HD:arbolL;
	end;


procedure agregarAdelante (var l:lista; cant:integer);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=cant;
	nue^.sig:=l;
	l:=nue;
end;

procedure generarVenta (var v:venta);
begin
	v.codigo:=random(15);
	if v.codigo <> 0 then
	begin
		v.fecha:=random(31)+1;
		v.cant:=random(1000);
	end;
end;

procedure insertarArbol (var a:arbol; v:venta);
begin
	if a=nil then
	begin
		new(a);
		a^.dato:=v; a^.HI:=nil; a^.HD:=nil;
	end
	else if v.codigo < a^.dato.codigo then
		insertarArbol(a^.HI,v)
	else
		insertarArbol(a^.HD,v);
end;

procedure insertarP(var a: arbolP; cod:integer;cant:integer);
begin
 if (a = nil) then begin
	new(a);
	a^.dato.codigo:= cod;
	a^.dato.cant:= cant;
	a^.HI:= nil;
	a^.HD:= nil;
 end
 else
	if (a^.dato.codigo >= cod) then
		InsertarP(a^.HI, cod,cant)
 else
		InsertarP (a^.HD, cod,cant);
end;

procedure insertarArbolLista(var al:arbolL; v:venta);
begin
	if al=nil then
	begin
		new(al);
		al^.dato.codigo:=v.codigo;
		al^.dato.ventas:=nil;
		agregarAdelante(al^.dato.ventas,v.cant);
		al^.HI:=nil;
		al^.HD:=nil;
	end
	else if v.codigo < al^.dato.codigo then
		insertarArbolLista(al^.HI,v)
	else
		insertarArbolLista(al^.HD,v);
end;

procedure cargarArbol (var a:arbol; var ap:arbolp; var al:arbolL);
var
	v:venta;
begin
	generarVenta(v);
	while v.codigo <> 0 do
	begin
		insertarArbol(a,v);
		insertarP(ap,v.codigo,v.cant);
		insertarArbolLista(al,v);
		generarVenta(v);
	end;
end;

procedure recorrerFecha (a:arbol; dia:fechas;var cant:integer);
begin
	if a<>nil then
	begin
		if a^.dato.fecha = dia then
			cant:=cant+a^.dato.cant;
		recorrerFecha(a^.HI,dia,cant);
		recorrerFecha(a^.HD,dia,cant);
	end;
end;


procedure cantporFecha (a:arbol);
var
	dia:fechas;
	cant:integer;
begin
	cant:=0;
	writeln('Ingrese la fecha 1-31 que quieras saber');
	readln(dia);
	recorrerFecha(a,dia,cant);
	writeln('La cantidad de ventas en el dia ',dia, ' fue de ',cant); 

end;

procedure recorrerArbol (a:arbol);
begin
	if a<>nil then
	begin
		recorrerArbol(a^.HI);
		writeln('Fecha: ',a^.dato.fecha);
		writeln('La cantidad de ventas fue de ',a^.dato.cant);
		writeln('Codigo de producto: ',a^.dato.codigo);
		recorrerArbol(a^.HD);
	end;
end;

procedure recorrerArbolP (ap:arbolp);
begin
	if ap<>nil then
	begin
		recorrerArbolp(ap^.HI);
		writeln('La cantidad de ventas fue de ',ap^.dato.cant);
		writeln('Codigo de producto: ',ap^.dato.codigo);
		recorrerArbolp(ap^.HD);
	end;
end;


procedure recorrerLista(l:lista);
begin
	if l<>nil then
	begin
		writeln('cantidad de ventas: ',l^.dato);
		l:=l^.sig;
		recorrerLista(l);
	end;
end;
	

procedure recorrerArbolL (al:arbolL);
begin
	if al<>nil then
	begin
		recorrerArbolL(al^.HI);
		writeln('Codigo de producto: ',al^.dato.codigo);
		recorrerLista(al^.dato.ventas);
		recorrerArbolL(al^.HD);
	end;
end;

var
	a:arbol;
	ap:arbolP;
	al:arbolL;
	
begin
	randomize;
	cargarArbol(a,ap,al);
	recorrerArbol(a);
	cantporFecha(a);
	recorrerArbolP(ap);
	recorrerArbolL(al);
end.
