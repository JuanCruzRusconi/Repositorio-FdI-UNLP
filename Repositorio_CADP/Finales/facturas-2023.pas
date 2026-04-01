Un comercio dispone de una estructura de datos con las facturas (como máximo 2000 facturas) realizadas durante marzo de 
2023. De cada factura se conoce el número de factura, código de cliente, código de sucursal y monto total. Las facturas 
se encuentran ordenadas por código de sucursal. Se pide implementar un programa con un módulo que reciba la estructura 
que se dispone y devuelva el código de sucursal con mayor cantidad de facturas. El programa debe informar el valor 
retornado por el módulo.

Program facturas;
const
    maxFacturas = 2000;
type
    rangoFacturas = 1..maxFacturas;
    factura = record
        num: integer;
        cod: integer;
        suc: integer;
        monto: real;
    end;
    vectorFacturas = array [rangoFacturas] of factura;

    procedure cargarDatos(var v: vectorFacturas; var dL: integer);
    var
        i: integer; f: factura;
    begin
        dL:= 0;
        leerFactura(f);
        while(dL < maxFacturas) do begin
            dL:= dL + 1;
            v[dL]:= f;
            leerFactura(f);
        end;
    end;

    procedure actualizarMaximo(var mayorSuc: integer; var mayorFac: integer; suc, cant: integer; )
    var
    begin
        if(cant > mayorFac) then begin
            mayorSuc:= suc;
            mayorFac:= cant;
        end;
    end;

    procedure procesarDatos(v: vectorFacturas; dL: integer; var mayorSuc: integer)
    var
        i, mayorFac: integer;
        sucActual, cantActual: integer;
    begin
        max:= -1;
        i:= 1;
        while(i <= dL) do begin
            sucActual:= v[i].suc;
            cantActual:= 0;
            while(i <= dL) and (sucActual = v[i].suc) do begin
                cantActual:= cantActual + 1;
                i:= i + 1;
            end;
            actualizarMaximo(mayorSuc, mayorFac, sucActual, cantActual);
        end;
    end;

var
    v: vectorFacturas;
    dL: integer;
    mayorSucursal: integer;
begin
    cargarDatos(v, dL);
    procesarDatos(v, dL, mayorSucursal);
    writeln("La sucursal con mayor cantidad de facturas es: ", mayorSucursal);
end;