Se lee información de inmuebles. De cada inmueble se lee dirección, cantidad de habitaciones y código de venta.
Se pide realizar un programa que genere una estructura donde los inmuebles cuyo código de venta tiene más dígitos 
pares que impares (o iguales también se considera) queden almacenadas antes que los inmuebles cuyo código de venta 
tiene más dígitos impares que pares. La lectura finaliza cuando se han leído 50 inmuebles o se lea un inmueble con 
dirección igual a "ZZZ".

Program inmuebles;
const

type
    inmueble = record
        dir: string;
        cantHab: integer;
        cod: integer;
    end;

    listaInmuebles = ^nodo;
    nodo = record
        elem: inmueble;
        sig: listaInmuebles;
    end;

    procedure leerInmueble(var i: inmueble)
    begin
        read(i.dir);
        if(i.dir <> 'ZZZ') then begin
            read(i.cantHab);
            read(i.cod);
        end;
    end;

    function masPares(cod: integer): boolean;
    var
        dig, pares, impares: integer;
    begin
        pares:= 0;
        impares:= 0;
        while(cod <> 0) do begin
            dig:= cod MOD 10;
            if(dig MOD 2 = 0) then pares:= pares + 1;
            else impares:= impares + 1;
            cod:= cod DIV 10;
        end;
        masPares:= (pares >= impares);
    end;

    procedure agregarAdelante(var l: listaInmuebles; i: inmueble)
    var
        nuevo: listaInmuebles;
    begin   
        new(nuevo); nuevo^.elem:= i; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo
        else begin
            nuevo^.sig:= l;
            l:= nuevo;
        end;
    end;

    procedure agregarAtras(var l: listaInmuebles; i: inmueble)
    var
        nuevo, actual: listaInmuebles;
    begin
        new(nuevo); nuevo^.elem:= i; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else begin
            actual:= l;
            while(actual^.sig <> nil) do begin
                actual:= actual^.sig;
            end;
            actual^.sig:= nuevo;
        end;
    end;

    procedure cargarDatos(var l: listaInmuebles)
    var
        i: inmueble;
        cant: integer;
    begin
        cant:= 0;
        leerInmueble(i);
        while(cant < 50) and (i.dir <> 'ZZZ') do begin
            if(masPares(i.cod)) then agregarAdelante(l, i);
            else agregarAtras(l, i);
            cant:= cant + 1;
            leerInmueble(i);
        end;
    end;

var
    l: listaInmuebles;
begin
    l:= nil;
    cargarDatos(l);
end;



procedure insertar(var l: listaInmuebles; i: inmueble)
var
    nuevo, ant, actual: l;
begin
    new(nuevo); nuevo^.elem:= i; nuevo^.sig: nil;
    if(l = nil) then l:= nuevo;
    else begin
        ant:= l; actual:= l;
        while(l <> nil) and(actual^.elem.cod < nuevo^.elem.cod) do begin
            ant:= actual;
            actual:= actual^.sig;
        end;
    end;
    if(actual = l) then begin
        nuevo^.sig:= l;
        l:= nuevo;
    end
    else begin
        ant^.sig:= nuevo;
        nuevo^.sig:= actual;
    end;
end;