// Consigna Parcial - Primera Fecha - 10/6/2023- TEMA 1 - 8:00 AM
// Una empresa de venta de pasajes aéreos está analizando la información de los viajes realizados por sus aviones. Para ello, se dispone de una estructura de datos con la información de todos los viajes. De cada viaje se conoce el código de avión (entre 1000 y 2500), el año en que se realizó el viaje, la cantidad de pasajeros que viajaron, y la ciudad de destino. La información no se encuentra ordenada por ningún criterio.
// Además, la empresa dispone de una estructura de datos con información sobre la
// capacidad máxima de cada avión.
// Realizar un programa que procese la información de los viajes e:
// 1. Informe el código del avión que realizó la mayor cantidad de viajes
// 2. Genere una lista con los viajes realizados en años múltiplo de 10 con destino
// "Punta Cana" en los que el avión no alcanzó su capacidad máxima
// 3. COMPLETO: Para cada avión, informe el promedio de pasajeros que viajaron
// entre todos sus viajes.

program pasajes
const
    maxCodAvion = 2500;
type
    rangoAvion = 1000..maxCodAvion;

    viaje = record
        cod: rangoAvion;
        año: integer;
        cantPas: integer;
        des: string;
    end;

    listaViajes = ^nodo
    nodo = record
        elem: viaje;
        sig: listaViajes;
    end;

    vectorCapacidadPorAvion = array[rangoAvion] of integer;

    procedure cargarListaViajes( var l: listaViajes ) // se dispone

    procedure cargarVectorCapacidades( var v: vectorCapacidadPorAvion )// se dispone

    procedure inicializarVectorViajes( var vV: vectorCapacidadPorAvion; var vC: vectorCapacidadPorAvion )
    var
        i: rangoAvion
    begin
        for i:= 1000 to maxCodAvion do
            vV[i]:= 0;
            vC[i]:= 0;

    end;

    function añoMultiplo10(año: integer): boolean
    var
    begin
        if((año MOD 10) = 0) then añoMultiplo10:= true;
        else añoMultiplo10:= false;
    end;

    function noAlcanzoMaxCap(cap: integer; cant: integer): boolean
    var
    begin
        if(cant < cap) then noAlcanzoMaxCap:= true;
        else noAlcanzoMaxCap:= false;
    end;

    procedure agregarAdelante( var lNueva: listaViajes, v: viaje)
    var
        nuevo: listaViajes;
    begin
        new(nuevo); nuevo^.elem: v; nuevo^.sig: nil;
        if(lNueva = nil) then lNueva:= nuevo;
        else
            begin
                nuevo^.sig:= lNueva;
                lNueva:= nuevo;
            end;
    end;

    procedure procesarInformacion( l: listaViajes; vC: vectorCapacidadPorAvion; var vVia: vectorCapacidadPorAvion;
                                    var lN: listaViajes, var vCap: vectorCapacidadPorAvion)
    var
        avionActual: rangoAvion;
    begin
        inicializarVectores(vVia, vCap);
        while(l <> nil) do
            begin
                avionActual:= l^.elem.cod;
                vVia[avionActual]:= vVia[avionActual] + 1;
                if(añoMultiplo10(l^.elem.año) and (l^.elem.des = "Punta Cana") 
                    and (noAlcanzoMaxCap(vC[avionActual], l^.elem.cantPas)))
                    then agregarAdelante(lN, l^.elem);
                vCap[avionActual]:= vCap[avionActual] + l^.elem.cantPas;
                l:= l^.sig;
            end;
    end;

    procedure recorrerVectorViajes(vV: vectorCapacidadPorAvion; vC: vectorCapacidadPorAvion)
    var
        i: rangoAvion; max: integer; codMax: rangoAvion; promedio: real;
    begin
        max:= -1;
        for i:= 1000 to maxCodAvion do
            begin 
                if(vV[i] > max) then 
                    begin
                        max:= vV[i];
                        codMax:= i;
                    end;
                write("El codigo del avion que realizo mas viajes es: ", codMax);
                promedio:= vC[i] / vV[i];
                write("El promedio de pasajeros entre todos sus viajes es: ", promedio);
            end;
    end;

var 
    lV: listaViajes; vCPA: vectorCapacidadPorAvion; vViajes: vectorCapacidadPorAvion;
    lNueva: listaViajes; vCapacidades: vectorCapacidadPorAvion;
begin
    lV:= nil;
    lNueva:= nil;
    cargarListaViajes(lV); // se dispone
    cargarVectorCapacidades(vCPA);// se dispone
    procesarInformacion(lV, vCPA, vViajes, lNueva);
    recorrerVectores(vViajes, vCapacidades);
end;