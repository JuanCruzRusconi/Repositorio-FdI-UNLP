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
        numFac: integer;
        codCli: integer;
        codSuc: integer;
        monto: real;
    end;

    vectorFacturas = array[rangoFacturas] of factura;

    procedure cargarVectorFacturas (var vF: vectorFacturas; var dimL: integer) //. se dispone

    procedure actualizarMaximo (var maxCod: integer; var maxFac: integer; codActual: integer; cantActual: integer)
    begin
        if(cantActual > maxFac) then begin
            maxCod:= codActual;
            maxFac:= cantActual;
        end;
    end;

    procedure procesarFacturas (vF: vectorFacturas; dimL: integer; var maxCod: integer; var maxFac: integer)
    var
        i, codActual, cantActual: integer;
    begin
        maxCod:= -1;
        maxFac:= -1;
        i:= 1;
        while(i <= dimL) do begin
            cantActual:= 0;
            codActual:= vF[i].codSuc;
            while(i <= dimL) and (codActual = vF[i].codSuc) do begin
                cantActual:= cantActual + 1;
                i:= i + 1;
            end;
            actualizarMaximo(maxCod, maxFac, codActual, cantActual);
        end;
    end;

var
    vF: vectorFacturas;
    dimL: integer;
    maxCod: integer;
    maxFac: integer;
begin
    cargarVectorFacturas(vF, dimL); // se dispone
    procesarFacturas(vF, dimL, maxCod, maxFac);
    writeln("El codigo de sucursal con mayor cantidad de facturas es: ", maxCod);
end.