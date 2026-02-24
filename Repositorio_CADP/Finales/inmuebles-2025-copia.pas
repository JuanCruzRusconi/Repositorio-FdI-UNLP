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
        cant: integer;
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
            read(i.cant);
            read(i.cod);
        end;
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

    procedure agregarAtras(var l: listaInmueble; i: inmueble)
    var
        nuevo, aux: listaInmueble;
    begin
        new(nuevo); nuevo^.elem:= i; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else begin
            aux:= l;
            while(aux^.sig <> nil) do
                aux:= aux^.sig;
            aux^.sig:= nuevo;
        end;
    end;

    function masPares(cod: integer): boolean
    var
        dig, par, impar: integer;
    begin
        par:= 0;
        impar:= 0;
        while(cod <> 0) doo begin
            dig:= cod MOD 10;
            if(dig MOD 2 = 0) then par++;
            else impar++;
            cod:= cod DIV 10;
        end;
        masPares:= (par >= impar);
    end;

    procedure procesarDatos(var l: listaInmuebles)
    var
        i: inmueble;
        c: integer;
    begin
        leerInmueble(i);
        c:= 1;
        while(c <= 50) and (i.dir <> 'ZZZ') do begin
            if(masPares(i.cod)) then agregarAdelante(l, i)
            else agregarAtras(l, i);
            leerInmueble(i);
            c:= c + 1;
        end;
    end;
var
    l: listaInmuebles;
begin
    l:= nil;
    procesarDatos(l);
end;