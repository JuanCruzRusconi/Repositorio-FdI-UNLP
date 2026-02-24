Un comercio dispone de una estructura de datos con las ventas (como máximo 500 ventas) realizadas
durante el mes de enero. De cada venta se conoce el número de venta, monto total y una lista de los
productos vendidos (de cada producto vendido se tiene código y cantidad). Se pide implementar un
programa que elimine de la estructura de datos todas las ventas cuya lista de productos contengan
exactamente 5 productos.

Program comercio;
const
    maxVentas = 5000;
type
    rangoVentas = 1..maxVentas;

    producto = record
        cod: integer;
        cant: integer;
    end;

    listaVentas = ^nodo;
    nodo = record
        elem: producto;
        sig: listaVentas;
    end;

    venta = record
        num: integer;
        monto: real;
        lista: listaVentas;
    end;

    vector = array[rangoVentas] of venta;

    procedure cargarDatos(var v: vector; var dL: integer) // se dispone

    function tiene5Ventas(l: listaVentas): boolean
    var
        cant: integer;
    begin
        cant:= 0
        while(l <> nil) do begin
            cant:= cant + 1;
            l:= l^.sig;
        end;
        tiene5Ventas = (cant = 5);
    end;

    procedure eliminarVentas(var v: vector; var dL: integer)
    var
        j, i: integer;
    begin
        i:= 1;
        while(i <= dL) do begin
            if(tiene5Ventas(v[i].lista)) then begin
                for j:= i to (dL - 1) do
                    v[j]:= v[j+1];
                dL:= dL - 1;
            end
            else
                i:= i + 1;
        end;
    end;

var
    v: vector;
    dL: integer;
begin
    cargarDatos(v, dL); // se dispone
    eliminarVentas(v, dL);
end;