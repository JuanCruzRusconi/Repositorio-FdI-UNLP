Un comercio dispone de una estructura de datos con las ventas (como máximo 500 ventas) realizadas
durante el mes de enero. De cada venta se conoce el número de venta, monto total y una lista de los
productos vendidos (de cada producto vendido se tiene código y cantidad). Se pide implementar un
programa que elimine de la estructura de datos todas las ventas cuya lista de productos contengan
exactamente 5 productos.

Program ventas;

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
        sig: listaProductos
    end;

    venta = record
        numVenta: integer;
        montoTot: real;
        listaProds: listaProductos;
    end;

    vectorVentas = array[rangoVentas] of venta;

    procedure cargarDatos (var v: vectorVentas; var dimL: integer) // se dispone

    function contiene5Prods (l: listaProductos): boolean
    var
        cant: integer;
    begin
        cant:= 0;
        while(l <> nil) do begin
            cant:= cant + 1;
            l:= l^.sig;
        end;
        contiene5Prods:= (cant = 5);
    end;

    procedure eliminar (var v: vectorVentas; ven: venta)
    var

    begin
        
    end;

    procedure procesarVentas (v: vectorVentas; dimL: integer; var l: listaProductos)
    var
        i: integer;
    begin
        for i:= 1 to dimL do begin
            if(contiene5Prods(v[i].listaProds)) then eliminar(v, v[i]);
        end;
    end;

var
    vV: vectorVentas;
    dimL: integer
    lP: listaProductos;
begin
    lP:= nil;
    dimL:= 0;
    cargarDatos(vV, dimL); // se dispone
    procesarVentas(vV, lP);
end.