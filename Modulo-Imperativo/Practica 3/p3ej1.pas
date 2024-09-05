{Escribir un programa que:
a. Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro para: 
    i. Informar los datos de los socios en orden creciente.
    ii. Informar los datos de los socios en orden decreciente.
    iii. Informar el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
    iv. Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.
    vi. Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
    vii. Informar la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
    viii. Informar el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne el promedio de las edades de los socios.

}


program p3ej1;
type
	cadena30 = string[30];
	socio = record
		numero:integer;
		nombre:cadena30;
		edad:integer;
	end;
	arbol = ^nodo;
	nodo = record
		dato:socio;
		HD:arbol;
		HI:arbol;
	end;
	
Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('Ana', 'Jose', 'Luis', 'Ema', 'Ariel', 'Pedro', 'Lena', 'Lisa', 'Martin', 'Lola'); 
  
  begin
    s.numero:= random (51) * 100;
    If (s.numero <> 0)
    then begin
           s.nombre:= vNombres[random(10)];
           s.edad:= 12 + random (79);
         end;
  end;  
  
Procedure InsertarElemento (var a: arbol; elem: socio);
  Begin
    if (a = nil) 
    then begin
           new(a);
           a^.dato:= elem; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.numero < a^.dato.numero) 
         then InsertarElemento(a^.HI, elem)
         else InsertarElemento(a^.HD, elem); 
End;



procedure GenerarArbol (var a: arbol);
var unSocio: socio;  
Begin
 writeln;
 writeln ('----- Ingreso de socios y armado del arbol ----->');
 writeln;
 a:= nil;
 CargarSocio (unSocio);
 while (unSocio.numero <> 0)do
  begin
   InsertarElemento (a, unSocio);
   CargarSocio (unSocio);
  end;
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure informarDatosCrec (a:arbol);
begin
	if(a<>nil)then
	begin
		informarDatosCrec(a^.HI);
		writeln('Los datos del socio ',a^.dato.numero,' su nombre ',a^.dato.nombre ,' su edad ', a^.dato.edad);
		informarDatosCrec(a^.HD);
	end;
end;

procedure informarDatosDec (a:arbol);
begin
	if(a<>nil)then
	begin
		informarDatosDec(a^.HD);
		writeln('Los datos del socio ',a^.dato.numero,' su nombre ',a^.dato.nombre ,' su edad ', a^.dato.edad);
		informarDatosDec(a^.HI);
	end;
end;

   procedure actualizarMaximo(var maxValor,maxElem : integer; nuevoValor, nuevoElem : integer);
	begin
	  if (nuevoValor >= maxValor) then
	  begin
		maxValor := nuevoValor;
		maxElem := nuevoElem;
	  end;
	end;
	
	procedure NumeroMasEdad (a: arbol; var maxEdad: integer; var maxNum: integer);
	begin
	   if (a <> nil) then
	   begin
		  actualizarMaximo(maxEdad,maxNum,a^.dato.edad,a^.dato.numero);
		  numeroMasEdad(a^.hi, maxEdad,maxNum);
		  numeroMasEdad(a^.hd, maxEdad,maxNum);
	   end; 
	end;


procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad := -1;
  NumeroMasEdad (a, maxEdad, maxNum);
  if (maxEdad = -1) 
  then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;


 function AumentarEdad (a: arbol): integer;
  var resto: integer;
  begin
     if (a = nil) 
     then AumentarEdad:= 0
     else begin
            resto:= a^.dato.edad mod 2;
            if (resto = 1) then a^.dato.edad:= a^.dato.edad + 1;
            AumentarEdad:= resto + AumentarEdad (a^.HI) + AumentarEdad (a^.HD);
          end;  
       end;


procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  

begin
  writeln;
  writeln ('----- Cantidad de socios con edad aumentada ----->');
  writeln;
  writeln ('Cantidad: ', AumentarEdad (a));
  writeln;
  writeln;
  writeln ('//////////////////////////////////////////////////////////');
  writeln;
end;

function buscarNombre(a:arbol; nom:cadena30):boolean;
var
    aux:boolean;
begin
    aux:=false;
    if (a<>nil) then begin
        if (a^.dato.nombre = nom) then
            aux:=true
        else begin
            aux:=buscarNombre(a^.hi,nom);
            if (not aux) then
                aux:=buscarNombre(a^.hd,nom);
        end;
    end;
    buscarNombre:=aux;
end;



procedure InformarExistenciaNombreSocio (a:arbol);
var
	nom:cadena30;
begin
	writeln('Ingrese el socio a buscar');
	readln(nom);
	if buscarNombre(a,nom) then
		writeln('El socio existe')
	else
		writeln('El socio no existe');
end;

function cantsocios(a:arbol;var cant:integer):integer;
begin
	if a<>nil then
	begin
		cant:=cant+1;
		cantsocios(a^.HI,cant);
		cantsocios(a^.HD,cant);
	end;
	cantsocios:=cant;
end;
		

procedure InformarCantidadDeSocios(a:arbol);
var
	cant:integer;
begin
	cant:=0;
	cantsocios(a,cant);
	writeln('La cantidad actual de socios es de ',cant);
end;

var
	a:arbol;
	
begin
	randomize;
	generarArbol(a);
	informarDatosCrec(a);
	writeln('AHORA DECRECIENTE');
	writeln('-----------------');
	informarDatosDec(a);
	InformarNumeroSocioConMasEdad(a);
	AumentarEdadNumeroImpar(a);
	InformarExistenciaNombreSocio(a);
	InformarCantidadDeSocios(a);
end.

	
