Un comercio dispone de una estructura de datos con las ventas (como máximo 500 ventas) realizadas
durante el mes de enero. De cada venta se conoce el número de venta, monto total y una lista de los
productos vendidos (de cada producto vendido se tiene código y cantidad). Se pide implementar un
programa que elimine de la estructura de datos todas las ventas cuya lista de productos contengan
exactamente 5 productos.

Program comercio;
const 
    maxVentas = 500;
type
    rangoVentas = 1..maxVentas;

    producto = record
        cod: integer;
        cant: integer;
    end;

    listaProductos = ^nodo;
    nodo = record
        elem: producto;
        sig: listaProductos;
    end;

    venta = record
        num: integer;
        monto: real;
        lista: listaProductos;
    end;

    vector = array [rangoVentas] of venta;

    procedure cargarDatos(var v: vector; var dL: integer)// se dispone

    function tiene5Productos(l: listaProductos): boolean
    var
        cant: integer;
    begin
        cant:= 0;
        while(l <> nil) do begin
            cant:= cant + 1;
            l:= l^.sig;
        end;
        tiene5Productos:= (cant = 5);
    end;

    procedure eliminarVenta(var v: vector; var dL: integer; pos: integer)
    var
        i: integer;
    begin
        for i:= pos to dL-1 do begin
            v[i]:= v[i+1];
        end;
        dL:= dL - 1;
    end;

    procedure procesarVentas(var v: vector; var dL: integer)
    var
        i: integer;
    begin
        i:= 1;
        while(i <= dL) do begin
            if(tiene5Productos(v[i].lista)) then eliminarVenta(v, dL, i);
            else i:= i + 1;
        end;
    end;

var
    v: vector;
    dL: integer;
begin
    cargarDatos(v, dL); // se dispone
    procesarVentas(v, dL);
end.