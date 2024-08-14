{
 1.- Implementar un programa que procese la información de los alumnos de la Facultad de
Informática.
a) Implementar un módulo que lea y retorne, en una estructura adecuada, la información de
todos los alumnos. De cada alumno se lee su apellido, número de alumno, año de ingreso,
cantidad de materias aprobadas (a lo sumo 36) y el código de materia junto con la nota
obtenida (sin contar los aplazos) en cada una de las materias aprobadas. La lectura finaliza
cuando se ingresa el número de alumno 11111, el cual debe procesarse.
b) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne la
información con número de alumno y promedio de cada alumno.
c) Implementar un módulo que reciba la estructura generada en el inciso a) y retorne la
información con número de alumno y el código y nota de la materia con mayor nota de cada
alumno.
d) Analizar: ¿qué cambios requieren los puntos a y b, si no se sabe de antemano la cantidad de
materias aprobadas de cada alumno, y si además se desean registrar los aplazos? ¿cómo
puede diseñarse una solución modularizada que requiera la menor cantidad de cambios?
* }
program Ej1P0;
const
  MATERIAS=36;
  FIN=1111;
type
  subMaterias=1..MATERIAS;
  materia=record
    codigoMateria:string;
    nota:integer;
   end;
  vectorMaterias= array[subMaterias] of materia;
  alumno=record
    apellido:string;
    numAlumno:integer;
    anioIngreso:integer;
    materiasAprobadas:subMaterias;//dimension logica 
    materias:vectorMaterias;//vector de materias con codigo y nota 
   end;
  lista=^nodo;
  nodo=record
    dato:alumno;
    sig:lista;
   end;
procedure leerMateria(var m:materia);
  begin
    write('ingrese cod de materia: ');readln(m.codigoMateria);
    write('ingrese nota del alumno: ');readln(m.nota);
  end;
procedure cargarMaterias(var v:vectorMaterias;diml:subMaterias);//carga las materias del alumno
  var
    x:integer;
  begin
    for x:=1 to diml do
      begin
        leerMateria(v[x]);
      end;
  end;   
 procedure leerAlumno(var a:alumno);//carga los datos del alumno
   begin
     write('ingresar apellido: ');readln(a.apellido);
     write('ingrese numAlumno: ');readln(a.numAlumno);
     write('ingrese anio de ingreso: ');readln(a.anioIngreso);
     write('ingrese cantidad de materias aprobadas: ');readln(a.materiasAprobadas);
     cargarMaterias(a.materias,a.materiasAprobadas);
   end;
 procedure agregarAdelante(var l:lista;a:alumno);// parametro a haciendo referencia al registro alumno //agrega adelante en lista
   var
     nue:lista;
   begin
     new(nue);
     nue^.dato:=a;
     nue^.sig:=l;
     l:=nue; 
   end;
 procedure incisoA(var l:lista);//genera la lista
   var
     aux:alumno;//variable local al modulo que genera la lista
   begin
     repeat // con FIN siendo mi condicion de corte o representando el 1111
       leerAlumno(aux);
       agregarAdelante(l,aux);
     until(aux.numAlumno = FIN);
   end;
 function mejorNota(v:vectorMaterias;diml:subMaterias):string;
   var
     x:integer;
     mejor:real;
     aux:string;
   begin
     mejor:=0;
     for x:=1 to diml do
       begin
         if(v[x].nota > mejor)then
           begin
             mejor:=v[x].nota;
             aux:=v[x].codigoMateria;
           end;
       end;
     mejorNota:=aux;
   end;
 function promedio(v:vectorMaterias;diml:subMaterias):real;
   var
     x:integer;
     total:real;
   begin
     total:=0;
     for x:=1 to diml do
       total:=v[x].nota+total;
     if(total=0)then
       promedio:=0
     else
       promedio:=total/diml;
   end;
 procedure incisoB(l:lista);
   begin
     while(l<>nil)do
       begin
         writeln('el promedio del alumno de numero: ',l^.dato.numAlumno,' es: ',promedio(l^.dato.materias,l^.dato.materiasAprobadas):2:2);
         l:=l^.sig;
       end;
   end;
 procedure incisoC(l:lista);
   begin
     while(l<>nil)do
       begin
         writeln('el numero del alumno es: ',l^.dato.numAlumno,' y el codigo de la materia con mayor nota es: ',mejorNota(l^.dato.materias,l^.dato.materiasAprobadas));
         l:=l^.sig;
       end;
   end;
var
  pri:lista;
BEGIN
  pri:=nil;
  incisoA(pri);
  writeln('INCISO B');
  incisoB(pri);
  writeln('INCISO C');
  incisoC(pri);
  //Para el inciso D yo reemplazaria el vector de materias por una lista ordenada por codigo de materia y para que el aprobado y los aplazos esten juntos 
  //y seria una lista ya que seria imposible saber cuantas veces se aplazo una materia
END.

