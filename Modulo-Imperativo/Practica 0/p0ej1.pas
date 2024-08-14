program p0ej1;
type
	materias = 1..36;
	cadena30 = string[30];
	notas = 0..10;
	vNotas = array[materias] of notas;
	alumno = record
		nomyApe:cadena30;
		numAlumno:integer;
		ingreso:integer;
		matAprobadas:materias;
		notas:vNotas;
	end;
	listaAlumnos = ^nodo;
	nodo = record
		dato:alumno;
		sig:listaAlumnos;
	end;

procedure inicializarVector(var v:vNotas);
var
	i:materias;
begin
	for i:=1 to 36 do
		v[i]:=0;
end;

procedure leerAlumno (var a:alumno);
var
	i:materias;
begin
	inicializarVector(a.notas);
	writeln('Ingrese el nombre y apellido del alumno');
	readln(a.nomyApe);
	writeln('Ingrese el numero del alumno');
	readln(a.numAlumno);
	writeln('Ingrese la cantidad de materias aprobadas');
	readln(a.matAprobadas);
	for i:=1 to a.matAprobadas do
	begin
		writeln('Ingrese la nota obtenida en la materia ',i);
		readln(a.notas[i]);
	end;
end;

procedure agregarAdelante(var l:listaAlumnos; a:alumno);
var
	nue:listaAlumnos;
begin
	new(nue);
	nue^.dato:=a;
	nue^.sig:=l;
	l:=nue;
end;

procedure cargarLista(var l:listaAlumnos);
var
	a:alumno;
begin
	repeat
		leerAlumno(a);
		agregarAdelante(l,a);
	until(a.numAlumno=11111);
end;

procedure procesarAlumno(a:alumno; var numeroDeAlumno:Integer; var promedio:real);
var
   i:integer;
   total,cant:integer;
begin
  total:= 0; 
  cant := 0;
  numeroDeAlumno:= a.numAlumno;
  for i := 1 to a.matAprobadas do 
  begin
    cant:=cant+1;
    total:=total+a.notas[i];
  end;
  promedio:=total/cant;
  writeln('El numero de alumno es: ', a.numAlumno);
  writeln('El promedio es: ', promedio);
end;

procedure procesarLista(l:listaAlumnos);
var
  promedio:real;
  numeroDeAlumno:integer;
begin
  while (l <> nil) do 
  begin
    procesarAlumno(l^.dato,numeroDeAlumno,promedio);
    l := l^.sig;
  end;
end;

var
	l:listaAlumnos;
begin
	l:=nil;
	cargarLista(l);
	procesarLista(l);
end.

{C) si no se sabe la cantidad de materias aprobadas se puede ingresar notas hasta que se ingrese un 0 y eso indica que la anterior nota fue la ultima}
{si se ingresan los aplazos tambien se puede hacer que se ingresen notas hasta que sean mayor o igual a 4 y recien ahi pasa al siguiente campo¿ del vector, si se quiere sacar promedio con los aplazos se complica todo se deberia hacer una lista porque no se sabe la cantidad de aplazos que puede tener,suerte capo }
