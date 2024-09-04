program ejercicio_2;

type rangoEdad = 12..100;
     cadena15 = string [15];
     socio = record
               numero: integer;
               nombre: cadena15;
               edad: rangoEdad;
             end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: socio;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure GenerarArbol (var a: arbol);
{ Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio se debe almacenar numero de socio, 
nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio. La informacion de cada socio debe generarse
aleatoriamente. }

  Procedure CargarSocio (var s: socio);
  var vNombres:array [0..9] of string= ('ana', 'jose', 'luis', 'ema', 'ariel', 'pedro', 'lena', 'lisa', 'martin', 'lola'); 
  
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

procedure InformarSociosOrdenCreciente (a: arbol);
{ Informar los datos de los socios en orden creciente. }
  
  procedure InformarDatosSociosOrdenCreciente (a: arbol);
  begin
    if ((a <> nil) and (a^.HI <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HI);
    writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
    if ((a <> nil) and (a^.HD <> nil))
    then InformarDatosSociosOrdenCreciente (a^.HD);
  end;

Begin
 writeln;
 writeln ('----- Socios en orden creciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenCreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarSociosOrdenDecreciente (a:arbol);

    procedure InformarDatosSociosOrdenDecreciente (a: arbol);
      begin
        if ((a <> nil) and (a^.HD <> nil)) then begin
          InformarDatosSociosOrdenDecreciente (a^.HD);
        end;
        writeln ('Numero: ', a^.dato.numero, ' Nombre: ', a^.dato.nombre, ' Edad: ', a^.dato.edad);
        if ((a <> nil) and (a^.HI <> nil))then begin 
          InformarDatosSociosOrdenDecreciente (a^.HI); 
        end;
      end;

Begin
 writeln;
 writeln ('----- Socios en orden decreciente por numero de socio ----->');
 writeln;
 InformarDatosSociosOrdenDecreciente (a);
 writeln;
 writeln ('//////////////////////////////////////////////////////////');
 writeln;
end;

procedure InformarNumeroSocioConMasEdad (a: arbol);
{ Informar el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor.  }

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

procedure AumentarEdadNumeroImpar (a: arbol);
{Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.}
  
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

procedure InformarExistenciaNombreSocio (a:arbol);
   
   function busco_nombre (a:arbol; nombre: cadena15): boolean;
     begin 
       busco_nombre := false ;
       if(a <> nil)then begin
         if(a^.dato.nombre <> nombre)then begin 
           busco_nombre := busco_nombre (a^.HI,nombre) or busco_nombre(a^.HD,nombre);
         end
         else begin 
           busco_nombre := true;
         end;
       end
       else begin 
         busco_nombre := false;
       end;
     end;
var 
  nombre: cadena15;
begin 
  writeln('ingrese un nombre');
  readln(nombre);
  if(busco_nombre(a,nombre) = true ) then begin 
    writeln('');
    writeln(' el nombre ingresado existe en el arbol ');
  end
  else begin 
    writeln('');
    writeln(' el nombre ingresado no existe en el arbol ');
  end;
end;

procedure InformarCantidadSocios (a:arbol; var cant:integer);
  
  function cant_socios (a:arbol): integer ;
    begin 
      if(a <> nil)then begin 
        cant_socios := cant_socios(a^.HI) + cant_socios(a^.HD) + 1;
      end
      else begin 
        cant_socios := 0;
      end;
    end;
begin 
  cant := cant_socios(a);
  writeln('la cantidad de socios es de: ',cant);
end;

procedure InformarPromedioDeEdad (a:arbol; cant: integer; var prom: real); 
  
  function suma_edad (a:arbol):integer;
    begin 
      if(a <> nil)then begin 
        suma_edad := suma_edad(a^.HI) + suma_edad(a^.HD) + a^.dato.edad;
        writeln('la suma actual ',suma_edad);
      end
      else begin 
        suma_edad := 0;
      end;
    end;
var 
  suma:integer;    
begin 
  suma:= suma_edad(a);
  writeln('la suma de las edades es: ',suma);
  prom := suma / cant; 
end;
  
procedure num_masgrande(a: arbol; var max_num: integer);
  begin 
    if(a <> nil)then begin 
      if(max_num < a^.dato.numero)then begin 
        max_num:= a^.dato.numero;
        num_masgrande(a^.HD,max_num);
      end;
    end;
  end;

procedure num_maschico(a: arbol; var min_num:integer);
  begin 
    if(a <> nil)then begin 
      if(min_num > a^.dato.numero)then begin 
        min_num := a^.dato.numero;
        num_maschico(a^.HI,min_num);
      end;
    end;
  end;

function busca_existencia(a: arbol; valor:integer): boolean;
  begin 
    if(a <> nil)then begin 
      busca_existencia := false;
      if(valor = a^.dato.numero)then begin
        busca_existencia := true;
      end
      else begin 
        if(valor < a^.dato.numero)then begin 
          busca_existencia := busca_existencia (a^.HI,valor);
        end
        else begin 
          busca_existencia := busca_existencia (a^.HD,valor);
        end;
      end;
    end
    else begin 
      busca_existencia := false;
    end;
  end;

procedure comprendidos(a: arbol; min, max: integer);
  
  function cant_comprendidos (a: arbol; min, max: integer): integer;
    begin 
      if(a <> nil)then begin 
        if(a^.dato.numero < max)and(a^.dato.numero > min)then begin 
          cant_comprendidos := cant_comprendidos(a^.HI,min,max) + cant_comprendidos(a^.HD,min,max) + 1;
        end
        else begin 
          if(a^.dato.numero >= max)then begin 
            cant_comprendidos := cant_comprendidos(a^.HI,min,max);
          end
          else begin 
            if(a^.dato.numero <= min)then begin 
              cant_comprendidos := cant_comprendidos(a^.HD,min,max);
            end;
          end;
        end;
      end
      else begin 
        cant_comprendidos := 0;
      end;
    end;
begin 
  writeln('la cantidad de socios que se encuentran entre esos valores son: ',cant_comprendidos(a,min,max));
end;

var a: arbol; 
{  cant : integer;
  prom : real;}
  max_num: integer;
  min_num: integer;
  valor :integer;
  min, max:integer;
Begin
  randomize;
  {prom := 0;}
  max_num := 0;
  min_num := 9999; 
  GenerarArbol (a);
  {InformarSociosOrdenCreciente (a);}
  InformarSociosOrdenDecreciente (a); 
  {InformarNumeroSocioConMasEdad (a);
  AumentarEdadNumeroImpar (a);
  InformarExistenciaNombreSocio (a); 
  InformarCantidadSocios (a,cant);
  writeln(' ');
  InformarPromedioDeEdad (a,cant,prom);
  writeln('el promedio de las edades de los socios es: ',prom);}
  num_masgrande(a,max_num);
  writeln('el numero de socio mas grande es: ',max_num);
  writeln(' ');
  num_maschico(a,min_num);
  writeln('el numero de socio mas chico es: ',min_num);
  writeln(' ');
  writeln('ingrese el valor que desea buscar ');
  readln(valor);
  writeln('el valor ',valor,' se encuentra en el arbol ? ',busca_existencia(a,valor));
  writeln('');
  writeln('ingrese el numero menor: ');
  readln(min);
  writeln('ingrese el numero mayor: ');
  readln(max);
  comprendidos(a,min,max);
End.
