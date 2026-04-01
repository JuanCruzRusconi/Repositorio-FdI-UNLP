// Consigna Parcial - Primera Fecha - 10/6/2023- TEMA 1 - 8:00 AM
// Una empresa de venta de pasajes aéreos está analizando la información de los viajes realizados por sus aviones. 
// Para ello, se dispone de una estructura de datos con la información de todos los viajes. De cada viaje se conoce el 
// código de avión (entre 1000 y 2500), el año en que se realizó el viaje, la cantidad de pasajeros que viajaron, y la 
// ciudad de destino. La información no se encuentra ordenada por ningún criterio.
// Además, la empresa dispone de una estructura de datos con información sobre la
// capacidad máxima de cada avión.
// Realizar un programa que procese la información de los viajes e:
// 1. Informe el código del avión que realizó la mayor cantidad de viajes
// 2. Genere una lista con los viajes realizados en años múltiplo de 10 con destino
// "Punta Cana" en los que el avión no alcanzó su capacidad máxima
// 3. COMPLETO: Para cada avión, informe el promedio de pasajeros que viajaron
// entre todos sus viajes.

Program pasajes;
const
    maxCod = 2500;
type
    rangoCods = 1000..2500;
    viaje = record
        cod: rangoCods;
        ano: integer;
        cantPas: integer;
        destino: string;
    end;
    listaViajes = ^nodo;
    nodo = record
        elem: viaje;
        sig: listaViajes;
    end;
    vectorCapacidad = array[rangoCods] of integer;

    info = record
        viajes: integer;
        pasajeros: integer;
    end;
    vectorViajes = array[rangoCods] of info;

    procedure cargarLista(var l: listaViajes);

    procedure cargarVector(var v: vectorCapacidad);

    procedure inicializarVector(var v: vectorViajes)
    var
        i: integer;
    begin
        for i:= 1000 to 2500 do
            v[i].viajes:= 0;
            v[i].pasajeros:= 0;
    end;

    function cumpleNuevaLista(ano: integer; dest: string; pas: integer; maxCap: integer)
    var
        cumple: boolean
    begin
        cumple:= false;
        if(ano MOD 10 = 0) and (dest = 'Punta Cana') and (pas < maxCap) then
            cumple:= true;
        cumpleNuevaLista:= cumple;
    end;

    procedure agregarNuevaLista(var l: listaViajes, v: viaje)
    var
        nuevo, aux: listaViajes;
    begin
        new(nuevo); nuevo^.elem:= v; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else begin
            aux:= l;
            while(aux^.sig <> nil) do
                aux:= aux^.sig;
            aux^.sig:= nuevo;
        end;
    end;

    procedure procesarViajes(v: vectorViajes; var codMayor: rangoCods)
    var
        i, max: integer;
        promedio: real;
    begin
        codMayor:= 1;
        max:= -1;
        for i:= 1000 to maxCod do begin
            if(v[i].viajes > max) then begin
                codMayor:= i;
                max:= v[i].viajes;
            end;
            promedio:= v[i].pasajeros / v[i].viajes;
            writeln("Para el avion ", i, " el promedio es de: ", promedio);
        end;
    end;

    procedure procesarInformacion(l: listaViajes; vC: vectorCapacidad; var vV: vectorViajes; var codMayor: rangoCods; var lPC: listaViajes)
    var
        max: integer;
    begin
        inicializarVector(vV);
        while(l <> nil) do begin
            vV[l^.elem.cod].viajes:= vV[l^.elem.cod].viajes + 1;
            vV[l^.elem.cod].pasajeros:= vV[l^.elem.cod].pasajeros + l^.elem.cantPas;
            if(cumpleNuevaLista(l^.elem.ano, l^.elem.destino, l^.elem.cantPas, vC[l^.elem.cod])) then agregarNuevaLista(lPC, l^.elem);
            l:= l^.sig;
        end;
        procesarViajes(vV, codMayor);
    end;

var
    l: listaViajes;
    vC: vectorCapacidad;
    vV: vectorViajes;
    codMayor: rangoCods;
    lPC: listaViajes;
begin
    l:= nil;
    cargarLista(l);
    cargarVector(vC);
    lPC:= nil;
    procesarInformacion(l, vC, vV, codMayor,lPC);
    wirteln("El codigo de avion que realizo la mayor cantidad de viajes es: ", codMayor);
end.