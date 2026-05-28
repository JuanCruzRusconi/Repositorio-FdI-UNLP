Se cuenta con un archivo que posee información de las ventas que realiza una empresa a los diferentes
clientes. Se necesita obtener un reporte con las ventas organizadas por cliente. Para ello, se deberá
informar por pantalla: los datos personales del cliente, el total mensual (mes por mes cuánto compró) y
finalmente el monto total comprado en el año por el cliente. Además, al finalizar el reporte, se debe
informar el monto total de ventas obtenido por la empresa.
El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año, mes, día y
monto de la venta. El orden del archivo está dado por: cod cliente, año y mes.
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron compras. No es
necesario que informe tales meses en el reporte.

program ejercicio9;
const
    valorAlto = 9999;
type
    cliente = record
        cod: integer;
        nom: string[10];
        ape: string[10];
        ano: integer;
        mes: integer;
        dia: integer;
        monto: real;
    end;
    archMaestro = file of cliente;

    procedure leer(var maestro: archMaestro; var c: cliente);
    begin
        if(not EOF(maestro)) then
            read(maestro, c)
        else
            c.cod:= valorAlto;
    end;

    procedure procesarDatos(var maestro: archMaestro);
    var
        c: cliente;
        montoTotalEmpresa: real;
        clienteActual: integer;
        anoActual, mesActual: integer;
        apeActual, nomActual: string[10];
        montoMesActual, montoAnualActual: real;
    begin
        montoTotalEmpresa:= 0;
        leer(maestro, c);
        while(c.cod <> valorAlto) do begin
            clienteActual:= c.cod;
            writeln('Cliente ', clienteActual, ', ', c.nom, ', ', c.ape);
            while(clienteActual = c.cod) do begin
                anoActual:= c.ano;
                montoAnualActual:= 0;
                while(clienteActual = c.cod) and (anoActual = c.ano) do begin
                    mesActual:= c.mes;
                    montoMesActual:= 0;
                    while(clienteActual = c.cod) and (anoActual = c.ano) and (mesActual = c.mes) do begin
                        montoMesActual:= montoMesActual + c.monto;
                        leer(maestro, c);
                    end;
                    writeln('Total mensual del mes', mesActual, ' es de ', montoMesActual);
                    montoAnualActual:= montoAnualActual + montoMesActual;
                end;
                writeln('Total anual del año ', anoActual, ' es de ', montoAnualActual);
                montoTotalEmpresa:= montoTotalEmpresa + montoAnualActual;
            end;
        end;
        writeln('Total de la empresa es de ', montoTotalEmpresa);
    end;
var
    maestro: archMaestro;
begin
    assign(maestro, 'archivo_maestro');
    reset(maestro);
    procesarDatos(maestro);
    close(maestro);
end;
