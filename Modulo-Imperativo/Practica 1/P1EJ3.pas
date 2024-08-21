program P1EJ3;
const
	maxGeneros = 8;
type
	generos = 1..maxGeneros;
	pelicula = record
		codigo:integer;
		genero:generos;
		puntajeProm:real;
	end;
	lista = ^nodo;
	nodo = record
		dato:pelicula;
		sig:lista;
	end;
	vectorGeneros = array[generos] of lista;
	
procedure leerPelicula (var p:pelicula);
begin
	writeln('Ingrese codigo de pelicula, -1 para finalizar');
	readln(p.codigo);
	if p.codigo <> -1 then
	begin
		writeln('Ingrese genero de la pelicula');
		p.genero:=random(8)+1;
		writeln(p.genero);
		writeln('Ingrese puntaje promedio de la critica');
		p.puntajeProm:=random(10)+1;
		writeln(p.puntaje:2:2);
	end;
end;

procedure agregarAtras (var l:lista;p:pelicula);
var
	nuevo,aux:lista;
begin
	new(nuevo);
	nuevo^.elem:=p;
	nuevo^.sig:=nil;
	if (l=nil) then 
		l:=nuevo
	else begin
		aux:=l;
		while (aux^.sig<>nil) do
			aux:=aux^.sig;
		aux^.sig:=nuevo;
	end;
end;

procedure cargarListasPeliculas (var l:lista);
var
	p:pelicula;
begin
	l:=nil;
	leerPelicula(p);
	while p.codigo <> -1 do
	begin
		agregarAtras(l,p)
		
