Una empresa dispone de la información de las asistencias de sus empleados durante un período de tiempo. De cada empleado 
conoce: DNI, apellido y nombre, código de departamento en el que trabaja (entre 1 y 100), fecha y si estuvo presente o no 
ese día (no todos los días se pasa asistencia y los empleados pueden haber estado trabajando o haber faltado). Esta 
estructura se encuentra ordenada por código de departamento. Se pide realizar un programa que informe el departamento 
con más empleados presentes durante el período evaluado por la empresa.

Program empresa;
const
    maaxCod = 100;
type
    rangoCod = 1..maxCod;
    empleado = record
        dni: integer;
        nombre: string;
        cod: rangoCod;
        fecha: string;
        presente: boolean;
    end;

    listaAsistencias = ^nodo;
    nodo = record
        elem: empleado;
        sig: listaAsistencias;
    end;

    procedure insertarLista(var l: lista; e: empleado)
    var
        nuevo, ant, actual: listaAsistencias;
    begin
        new(nuevo); nuevo^.elem:= e; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else begin
            ant:= l;
            actual:= l;
            while(actual <> nil) and (actual^.elem.cod < nuevo^.elem.cod) do begin
                ant:= actual;
                actual:= actual^.sig;
            end;
        end;
        if(actual = l) then begin
            nuevo^.sig:= l;
            l:= nuevo;
        end
        else begin
            anterior^.sig:= nuevo;
            nuevo^.sig:= actual;
        end;
    end;

    procedure cargarDatos(var l: listaAsistencias)
    var
        e: empleado;
    begin
        leerEmpleado(e);
        while(e.dni <> -1) do begin
            insertarLista(l, e);
            leerEmpleado(e);
        end;
    end;

    procedure calcularMaximo(var maxDepto: rangoCod; var maxPresentes: integer; deptoActual: rangoCod; presentesActual: integer)
    begin
        if(presentesActual > maxPresentes) then begin
            maxPresentes:= presentesActual;
            maxDepto:= deptoActual;
        end;
    end;

    procedure procesarDatos(l: listaAsistencias; var maxDepto: rangoCod; var maxPresentes: integer)
    var
        deptoActual: rangoCod;
        presentesActual: integer;
    begin
        maxDepto:= -1;
        maxPresentes:= -1;
        while(l <> nil) do begin
            deptoActual:= l^.elem.cod;
            presentesActual:= 0;
            while(l <> nil) and (deptoActual = l^.elem.cod) do begin
                if(l^.elem.presente = true) then presentesActual:= presentesActual + 1;
                l:= l^.sig;
            end;
            calcularMaximo(maxDepto, maxPresentes, deptoActual, presentesActual);
        end;
    end;

var
    l: listaAsistencias;
    maxDepto: rangoCod;
    maxPresentes: integer;
begin
    l:= nil;
    cargarDatos(l);
    procesarDatos(l, maxDepto, maxPresentes);
    writeln("El departamento con mayor cantidad de asistencias es: ", maxDepto, " con un total de: ", maxPresentes);
end.