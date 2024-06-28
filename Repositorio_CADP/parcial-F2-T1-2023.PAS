// Consigna Parcial - Primera Fecha - 10/6/2023 - TEMA 1 - 10:30 hs -2023
// Una empresa de venta de tickets de tren está analizando la información de los viajes realizados por sus trenes durante el año 2022. Para ello, se dispone de una estructura de datos con la información de todos los viajes. De cada viaje se conoce el código de tren, el mes en que se realizó el viaje (entre 1 y 12), la cantidad de pasajeros que viajaron, y el código de la ciudad de destino (entre 1 y 20). La información se encuentra ordenada por código de tren.
// Además, la empresa dispone de una estructura de datos con información del costo del ticket por
// ciudad destino.
// Realizar un programa que procese la información de los viajes y:
// 1. Genere una lista que tenga por cada código del tren, la cantidad de viajes realizados.
// 2. Informe el mes con mayor monto recaudado.
// 3. COMPLETO: Informe el promedio de pasajeros por cada tren entre todos sus// 

program tickets

const 
    totalDestinos = 20;
    totalMeses = 12;
type
    rangoDestinos = 1..totalDestinos;
    rangoMeses = 1..totalMeses;

    viaje = record 
        codTren: integer;
        mes: rangoMeses;
        cantPas: integer;
        codDes: rangoDestinos;
    end;
    listaViajes = ^nodo
        elem: viaje;
        sig: listaViajes;
    end;

    vectorCostoTicket = array[rangoDestinos] of real;

    tren = record   
        cod: integer;
        cant: integer;
    end;
    listaCantViajes = ^nodo
        elem: tren;
        sig: listaCantViajes;
    end;

    vectorMontoPorMes = array[rangoMeses] of real;

    procedure cargarListaViajes( var l : listaViajes ) // se dispones

    procedure cargarVectorCostoTicket( var v: vectorCostoTicket ) // se dispone

    procedure inicializarVectorMontoMes( var v: vectorMontoPorMes )
    var 
        i: rangoMeses
    begin
        for i:= 1 to totalMeses do
            v[i]:= 0;
    end;

    procedure generarNuevaLista( var l: listaCantViajes; cod: integer; cant: integer)
    var
        nuevo: listaCantViajes;
    begin
        new(nuevo); nuevo^.elem.cod:= cod; nuevo^.elem.cant:= cant; neuvo^.sig:= nil;
        if( l = nil ) then l:= nuevo;
        else
            begin
                nuevo^.sig:= l;
                l:= nuevo;
            end;
    end;

    procedure procesarInformacion(lV: listaViajes; vCT: vectorCostoTicket; var lCV: listaCantViajes;
                        var vMM: vectorMontoPorMes)
    var
        trenActual: integer, pasActual: integer, 
        promedioActual: real; cantVActual: integer;
    begin
        inicializarVectorMontoMes(vMM);
        while (lV <> nil) do begin
            trenActual:= lV^.elem.codTren;
            pasActual:= 0;
            cantVActual:= 0;
            while(lV <> nil) and (trenActual = lV^.elem.codTren) do begin
                pasActual:= pasActual + lV^.elem.cantPas;
                cantVActual:= cantVActual + 1;
                vMM[lV^.elem.mes]:= vMM[lV^.elem.mes] + (vCT[lV^.elem.codDes] * l^.elem.cantPas);
                lV:= lV^.sig;
            end;
        generarNuevaLista(lCV, trenActual, cantVActual);
        promedio:= pasActual / cantVActual;
        write("El promedio del tren codigo: ", trenActual "es: ", promedio);
    end;

    procedure informarMayorMes( v: vectorMontoPorMes )
    var
        i: rangoMeses, max: real; mayorMes: rangoMeses;
    begin
        max:= 0;
        for i:= 1 to totalMeses do
            begin
                if(v[i] > max) then 
                    begin
                        max:= v[i];
                        mayorMes:= i;
                    end;
        end;
        write("El mes con mayor monto recaudado es: ", mayorMes);
    end;

var
    lVia: listaViajes; vCosTic: vectorCostoTicket; lCantVia: listaCantViajes; 
    vMontMes: vectorMontoPorMes;
begin
    lVia:= nil;
    lCantVia:= nil;
    cargarListaViajes(lVia); // se dispone
    cargarVectorCostoTicket(vCosTic); // se dispone
    procesarInformacion(lVia, vCosTic, lCantVia, vMontMes)
    informarMayorMes(vMontMes);
end.