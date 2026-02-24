Una empresa dispone de la información de las asistencias de sus empleados durante un período de tiempo. De cada empleado 
conoce: DNI, apellido y nombre, código de departamento en el que trabaja (entre 1 y 100), fecha y si estuvo presente o no 
ese día (no todos los días se pasa asistencia y los empleados pueden haber estado trabajando o haber faltado). Esta 
estructura se encuentra ordenada por código de departamento. Se pide realizar un programa que informe el departamento 
con más empleados presentes durante el período evaluado por la empresa.

Program empleados
type
    rangoDepto = 1..100;
    empleado = record
        dni: integer;
        apeNom: string;
        cod: rangoDepto;
        fecha: integer;
        presente: boolean;
    end;

    listaAsistencias = ^nodo;
    nodo = record
        elem: empleado;
        sig: listaAsistencias;
    end;

    procedure cargarDatos (var l: listaAsistencias) // se dispone

    procedure actualizarMaximo(var maxDepto, maxEmple; actual, cant: integer)
    begin
        if(cant > maxEmple) then begin
            maxDepto:= actual;
            maxEmple:= cant;
        end;
    end;

    procedure procesarDatos(l: listaAsistencias; var maxDepto, maxEmple: integer)
    var
        actual, cant: integer;
    begin
        maxEmple:= -1;
        while(l <> nil) do begin
            actual:= l^.elem.cod;
            cant:= 0;
            while (l <> nil) and (actual = l^.elem.cod) do begin
                if(l^.elem.presente = true) then cant:= cant + 1;
                l:= l^.sig;
            end;
            actualizarMaximo(maxDepto, maxEmple, actual, cant);
        end;
    end;

var
    l: listaAsistencias;
    maxDepto: integer;
    maxEmple: integer;
begin
    l:= nil;
    cargarDatos(l);
    procesarDatos(l, maxDepto, maxEmple);
    writeln("El departamento con mas empleados presentes durante ese perido es: ", maxDepto, " con: ", maxEmple, " empleados.");
end.