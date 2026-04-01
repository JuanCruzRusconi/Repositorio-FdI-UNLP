Un comercio dispone de una estructura de datos con las facturas realizadas durante agosto de 2023. De cada factura se conoce 
el número de factura, código de cliente, código de sucursal (1..5) y monto total. Se pide implementar un programa que lea un 
código de sucursal e invoque a un módulo que reciba dicho código y elimine las facturas correspondientes al código de sucursal 
recibida. Además debe retornar la cantidad de facturas eliminadas.

Program facturas;
const

type
    rangoSucursal = 1..5;
    factura = record
        num: integer;
        cod: integer;
        suc: rangoSucursal;
        monto: real;
    end;

    listaFacturas = ^nodo;
    nodo = record
        elem: factura;
        sig: listaFacturas;
    end;

    procedure cargarDatos(var l: listaFacturas)// se dispone;

    procedure eliminarFacturas(var l: listaFacturas; cod: rangoSucursal; 
    var cant: integer)
    var
        actual, ant: listaFacturas;
    begin
        actual:= l;
        while(actual <> nil) do begin
            if(actual^.elem.suc <> cod) then begin
                ant:= actual;
                actual:= actual^.sig;
            end
            else begin
                if(actual = l) then l:= l^.sig;
                else
                    ant^.sig:= actual^.sig;
                dispose(actual);
                actual:= ant;
                cant:= cant + 1;
            end;
        end;
    end;

var
    l: listaFacturas;
    codigo: rangoSucursal;
    cantidad: integer;
begin
    l:= nil;
    cargarDatos(l);
    writeln('Ingrese un codigo de sucursal');
    readln(codigo);
    eliminarFacturas(l, codigo, cantidad);
    writeln('L cantidad de facturas eliminadas es de ', cantidad);
end;