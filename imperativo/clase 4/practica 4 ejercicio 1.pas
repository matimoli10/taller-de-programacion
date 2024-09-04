Program ImperativoClase4;

type venta = record
               codigoVenta: integer;
               codigoProducto: integer;
               cantUnidades: integer;
               precioUnitario: real;
             end;
     productoVendido = record
                         codigo: integer;
                         cantTotalUnidades: integer;
                         montoTotal: real;
                       end;
     arbol = ^nodoArbol;
     nodoArbol = record
                    dato: productoVendido;
                    HI: arbol;
                    HD: arbol;
                 end;
     
procedure ModuloA (var a: arbol);
{ Almacene los productos vendidos en una estructura eficiente para la búsqueda por código de producto. De cada producto deben quedar almacenados la cantidad total 
de unidades vendidas y el monto total. }

  Procedure CargarVenta (var v: venta);
  begin
    v.codigoVenta:= random (51) * 100;
    If (v.codigoVenta <> 0)
    then begin
           v.codigoProducto:= random (100) + 1;
           v.cantUnidades:= random(15) + 1;
           v.precioUnitario:= (100 + random (100))/2;
         end;
  end;  
  
  Procedure InsertarElemento (var a: arbol; elem: venta);
  var p: productoVendido;
     
     Procedure ArmarProducto (var p: productoVendido; v: venta);
     begin
       p.codigo:= v.codigoProducto;
       p.cantTotalUnidades:= v.cantUnidades;
       p.montoTotal:= v.cantUnidades * v.precioUnitario;
     end;
  
  Begin
    if (a = nil) 
    then begin
           new(a);
           ArmarProducto (p, elem);
           a^.dato:= p; 
           a^.HI:= nil; 
           a^.HD:= nil;
         end
    else if (elem.codigoProducto = a^.dato.codigo)
         then begin
                a^.dato.cantTotalUnidades:= a^.dato.cantTotalUnidades + elem.cantUnidades;
                a^.dato.montoTotal:= a^.dato.montoTotal + (elem.cantUnidades * elem.precioUnitario);
              end
         else if (elem.codigoProducto < a^.dato.codigo) 
              then InsertarElemento(a^.HI, elem)
              else InsertarElemento(a^.HD, elem); 
  End;

var unaVenta: venta;  
Begin
 writeln;
 writeln ('----- Ingreso de ventas y armado de arbol de productos ----->');
 writeln;
 a:= nil;
 CargarVenta (unaVenta);
 while (unaVenta.codigoVenta <> 0) do
  begin
   InsertarElemento (a, unaVenta);
   CargarVenta (unaVenta);
  end;
 writeln;
 writeln ('-----------------------------------------------');
 writeln;
end;

procedure ModuloB (a: arbol);
{ Imprima el contenido del árbol ordenado por código de producto.}
  procedure ImprimirArbol (a: arbol);
  begin
    if (a <> nil)
    then begin
          if (a^.HI <> nil) then ImprimirArbol (a^.HI);
          writeln ('Codigo producto: ', a^.dato.codigo, ' cantidad unidades: ', a^.dato.cantTotalUnidades, ' monto total: ', a^.dato.montoTotal:2:2);
          if (a^.HD <> nil) then ImprimirArbol (a^.HD);
         end;
  end;

begin
  writeln;
  writeln ('----- Modulo B ----->');
  writeln;
  if ( a = nil) then writeln ('Arbol vacio')
                else ImprimirArbol (a);
  writeln;
  writeln ('-----------------------------------------------');
  writeln;
end;

procedure ModuloC (a: arbol);
{Retornar el menor código de producto.}

  function ObtenerMinimo (a: arbol): integer;
  begin
    if (a = nil) 
    then ObtenerMinimo:= 9999
    else if (a^.HI = nil) then ObtenerMinimo:= a^.dato.codigo
                          else ObtenerMinimo:= ObtenerMinimo (a^.HI)
  end;
   
var menorCodigo: integer;
begin
  writeln;
  writeln ('----- Modulo C ----->');
  writeln;
  write ('Menor codigo de producto: ');
  writeln;
  menorCodigo:= ObtenerMinimo (a);
  if (menorCodigo = 9999) 
  then writeln ('Arbol vacio')
  else begin
         writeln;
         writeln ('El codigo menor es ', menorCodigo); 
         writeln;
       end;
  writeln;
  writeln ('-----------------------------------------------');
  writeln;
end;

procedure ModuloD (a: arbol);
{ Retornar la cantidad de códigos que existen en el árbol que son menores que un valor que se recibe como parámetro }
  
  function CantidadDeCodigosMenores (a: arbol; cod: integer): integer;
  begin
    if(a <> nil)then begin 
      if(a^.dato.codigo < cod)then begin 
        CantidadDeCodigosMenores := CantidadDeCodigosMenores(a^.hi,cod) + CantidadDeCodigosMenores(a^.hd,cod) + 1;
      end
      else begin
        CantidadDeCodigosMenores := CantidadDeCodigosMenores(a^.hi,cod);
      end;
    end
    else begin 
      CantidadDeCodigosMenores := 0;
    end;
  end;
   
var cantidad, unCodigo: integer;
begin
  writeln;
  writeln ('----- Modulo D ----->');
  writeln;
  write ('Ingresar un codigo: ');
  readln (unCodigo);
  cantidad:= CantidadDeCodigosMenores (a, unCodigo);
  writeln;
  writeln ('La cantidad de codigos menores al codigo ', unCodigo, ' es: ', cantidad);
  writeln;
  writeln;
  writeln ('-----------------------------------------------');
  writeln;
end;

procedure ModuloE (a: arbol);
{ Contenga un módulo que reciba la estructura generada en el punto a y dos códigos de producto y retorne el monto total entre todos los códigos de productos 
comprendidos entre los dos valores recibidos (sin incluir). }
  
  function ObtenerMontoTotalEntreDosCodigos (a: arbol; codigo1, codigo2: integer): real;
  begin
    if(a <> nil)then begin
      if(a^.dato.codigo > codigo1) and (a^.dato.codigo < codigo2 ) then begin 
        ObtenerMontoTotalEntreDosCodigos := ObtenerMontoTotalEntreDosCodigos(a^.hi,codigo1,codigo2) + ObtenerMontoTotalEntreDosCodigos(a^.hd,codigo1,codigo2) + a^.dato.montoTotal;
      end
      else begin 
        if(a^.dato.codigo < codigo1 )then begin 
          ObtenerMontoTotalEntreDosCodigos := ObtenerMontoTotalEntreDosCodigos(a^.hd,codigo1,codigo2);
        end
        else begin 
          if(a^.dato.codigo > codigo2)then begin 
            ObtenerMontoTotalEntreDosCodigos := ObtenerMontoTotalEntreDosCodigos(a^.hi,codigo1,codigo2);
          end;
        end;
      end;
    end
    else begin 
      ObtenerMontoTotalEntreDosCodigos := 0;
    end;
  end;
var codigo1, codigo2: integer;
    montoTotal: real;
begin
  writeln;
  writeln ('----- Modulo E ----->');
  writeln;
  write ('Ingrese primer codigo de producto: ');
  readln (codigo1);
  write ('Ingrese segundo codigo de producto (mayor al primer codigo): ');
  readln (codigo2);
  writeln;
  montoTotal:= ObtenerMontoTotalEntreDosCodigos(a, codigo1, codigo2);
  if (montoTotal = 0) 
  then writeln ('No hay codigos entre ', codigo1, ' y ', codigo2)
  else begin
         writeln;
         writeln ('El monto total entre el codigo ', codigo1, ' y el codigo : ', codigo2, ' es: ', montoTotal:4:2); 
         writeln;
       end;
  writeln;
  writeln ('-----------------------------------------------');
  writeln;
end;

var a: arbol; 
Begin
  randomize;
  ModuloA (a);
  ModuloB (a);
  ModuloC (a);
  ModuloD (a);
  ModuloE (a);
End.