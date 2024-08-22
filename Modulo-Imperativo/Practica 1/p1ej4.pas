program p1ej4;
const
	maxRubro = 8;
	maxTres = 30;
type
	rubros = 1..maxRubro;
	producto = record
		codigo:integer;
		rubro:rubros;
		precio:real;
	end;
	lista = ^nodo;
	nodo = record
		dato:producto;
		sig:lista;
	end;
	vectorRubros = array [rubros] of lista;
	vectorRubroTres = array [1..maxTres] of producto;
	
procedure leerProducto (var p:producto);
begin
	writeln('Ingrese el codigo del producto');
	p.codigo:=random(1000);
	writeln(p.codigo);
	writeln('Ingrese el rubro del producto');
	p.rubro:=random(8)+1;
	writeln(p.rubro);
	writeln('Ingrese el precio del producto,0 para finalizar');
	readln(p.precio);
end;

procedure inicializarVector(var vR:vectorRubros);
var
	i:rubros;
begin
	for i:=1 to maxRubro do
		vR[i]:=nil;
end;

procedure insertarOrdenado (var l:lista; p:producto);
var
	nue,ant,act:lista;
begin
	new(nue);
	nue^.dato:=p;
	nue^.sig:=nil;
	if (l=nil) then 
		l:=nue
	else begin
		act:=l;ant:=l;
		while (act<>nil) and (act^.dato.codigo<p.codigo) do begin
			ant:=act;
			act:=act^.sig;
		end;
		if (ant=act) then 
			l:=nue
		else
			ant^.sig:=nue;
		nue^.sig:=act;
	end;
end;

procedure cargarRubros (var vR:vectorRubros);
var
	p:producto;
begin
	leerProducto(p);
	while p.precio <> 0 do 
	begin
		insertarOrdenado(vR[p.rubro],p);
		leerProducto(p);
	end;
end;

procedure cargarRubroTres (l:lista; var vT:vectorRubroTres;var dimL:integer);
begin
	dimL:=0;
	while (l<>nil) and (diml<30) do begin
		diml:=diml +1;
		vT[diml]:=l^.dato;
		l:=l^.sig;
	end;
end;


procedure pasarlista(l:lista);
begin
	while (l<>nil) do 
	begin
		writeln(l^.dato.codigo);
		l:=l^.sig;
	end;
end;

procedure mostrarCodigos (vR:vectorRubros);
var
	i:rubros;
begin
	for i:=1 to maxRubro do
	begin
		writeln('en el rubro ',i,' tenemos los sig codigos:');
		pasarlista(vR[i]);
	end;
end;

procedure ordenarVector(var vT:vectorRubroTres;diml:integer);
var
	i,j,p:integer;
	pr:producto;
begin
	for i:=1 to diml-1 do begin
		p:=i;
		for j:=i+1 to diml do
			if (vT[j].precio<vT[p].precio) then
				p:=j;
		pr:=vT[p];
		vT[p]:=vT[i];
		vT[i]:=pr;
	end;
end;

procedure imprimirRubroTres(vT:vectorRubroTres;dimL:integer);
var
	i:integer;
begin
	for i:=1 to diml do
		writeln('El precio del producto numero ',i,' del rubro 3 es: ',vT[i].precio:2:2);
end;

function calcularPromedio(vT:vectorRubroTres;dimL:integer):real;
var
	suma:real;
	i:integer;
begin
	suma:=0;
	for i := 1 to diml do
		suma:=suma+ vT[i].precio;
	calcularPromedio:= suma / diml;
end;


var
	vR:vectorRubros;
	dimL:integer;
	vT:vectorRubroTres;
begin
	randomize;
	cargarRubros(vR);
	mostrarCodigos(vR);
	cargarRubroTres(vR[3],vT,dimL);
	ordenarVector(vT,dimL);
	imprimirRubroTres(vT,dimL);
	writeln('EL promedio de los precios del rubro 3 es de ',calcularPromedio(vT,dimL));
end.
