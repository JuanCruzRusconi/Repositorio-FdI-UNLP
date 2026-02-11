// Consigna Parcial Fecha 3 Tema 1 - 2023
// Una revista deportiva dispone de información de los jugadores de fútbol participantes de la liga profesional 2022. De cada jugador se conoce 
// codigo de jugador, apellido y nombros, codigo de equipo (1 28), año de nacimento y la calificación obtenida para cada una de las 27 fechas 
// del torneo ya finalizado. La calificadón es ruménca de 0 a 10, donde el valor 0 significa que el jugador no ha participado de la fecha.
// Se solicita:
// a. Informar para cada equipo la cantidad de jugadores mayores a 35 años.
// b. Informar los códigos de los 2 jugadores con mejor calificación promedio en los partidos en los que participé. Solo
// deben considerarse los jugadores que participaron en más de 14 fechas.
// c. (COMPLETO): Implementar e invocar a un módulo que genere una lista con los jugadores cuyo código posee exactamente 3 dígitos impares y 
// haya nacido entre 1983 y 1990, La lista debe estar ordenada por código de jugador.

program Revista

const
    totalEquipos = 28;
    totalFechas = 27;
type
    rangoEquipos = 1..totalEquipos;
    rangoFechas = 1..totalFechas;
    calificacion = 0..10;

    vectorCalificaciones = array[rangoFechas] of calificacion;

    jugador = record
        cod: integer;
        apellido: string;
        nombre: string;
        codEquipo: rangoEquipos;
        año: integer;
        calificacion: vectorCalificaciones;
    end;
    listaJugadores = ^nodo
    nodo = record
        elem: jugador;
        sig: ^listaJugadores;
    end;

    vectorMayores35 = array[rangoEquipos] of integer;

    procedure cargarListaJugadores( var l: listaJugadores )// se dispone

    procedure actualizarMejoresCodigos (cod: integer; var j1, j2: integer; vec: vectorCalificaciones)
    var
        minimo1: real;
        minimo2: real;
        i: rangoFechas;
        cantFechas: integer;
        puntaje: integer;
        promedio: real;
    begin
        minimo1:= 0;
        cantFechas:= 0;
        puntaje:= 0;
        for i := 1 to totalFechas do
            begin
                if(vec[i] >= 1) then
                    begin
                        cantFechas:= cantFechas + 1;
                        puntaje:= puntaje + v[i]
                    end;
            end;
        if(cantFechas > 14) then
            begin
                promedio:= puntaje / cantFechas; 
                if(promedio > minimo1) then
                    begin
                        minimo2:= minimo1;
                        j2:= j1;
                        minimo1:= promedio;
                        j1:= cod;
                    end;
                    else
                        if( promedio > minimo2) then
                            begin
                                minimo2:= promedio;
                                j2:= cod;
                            end;
                    end;
            end;
    end;

    function tiene3DigitosImpares (cod: integer) : boolean
    var 
        num: integer; cant: integer;
    begin
        cant:= 0;
        while(cod <> 0) do
            begin
                num:= cod MOD 10
                if((num MOD 2) = 1) then cant:= cant + 1;
                num:= cod DIV 10;
            end;
        if(cant = 3) then tiene3DigitosImpares:= true;
        else tiene3DigitosImpares:= false;
    end;

    procedure insertarNuevaLista(var lNueva: listaJugadores; j: jugador)
    var
        nuevo, anterior, actual: listaJugadores;
    begin
        new(nuevo); nuevo^.elem:= jug; nuevo^.sig:= nil;
        if( lNueva = nil) then lNueva = nuevo;
        else
            begin
                actual:= lNueva; anterior:= lNueva;
                while(actual <> nil) and (actual^.elem.cod < nuevo^.elem.cod) do
                    begin
                        anterior:= actual;
                        actual:= actual^.sig;
                    end;
            end;
        if(actual = lNueva) then 
            begin 
                nuevo^.sig:= lNueva;
                lNueva:= nuevo;
            end;
        else
            begin
                anterior^.sig:= nuevo;
                nuevo^.sig:= actual;
            end;
    end;

    procedure inicializarVectorMayores35(var v: vectorMayores35)
    var 
        i: rangoEquipos
    begin
        for i := 1 to totalEquipos do
            v[i]:= 0;
    end;

    procedure informarMayores35PorEquipo(v: vectorMayores35)
    var 
        i: rangoEquipos
    begin
        for i:= 1 to totalEquipos do
            begin
                write("la cantidad de jugaores del equipo" i es v[i]);
            end;
    end;

    procedure procesarInformacion ( l: listaJugadores; v35: vectorMayores35; mejorJ1, mejorJ2: integer
                                    l2: listaJugadores)
    var 

    begin
        inicializarVectorMayores35(v35);
        while(l <> nil) do
            begin
                if((2024 - l^.elem.año) > 35) then v35[l^.elem.codEquipo]:= v35[l^.elem.codEquipo] + 1;
                actualizarMejoresCodigos(l^.elem.cod, mejorJ1, mejorJ2, l^.elem.calificacion);
                if(tiene3DigitosPares(l^.elem.cod) and (l^.elem.año > 1983) and (l^.elem.año < 1990)) then 
                    insertarNuevaLista(l2, l^.elem);
                l:= l^.sig;
            end;
    end; 

var
    lJ: listaJugadores; vC: vectorCalificaciones; vM35: vectorMayores35; mejorJugador1, mejorJugador2: integer;
    lJ2: listaJugadores;
begin 
    lJ:= nil;
    lJ2:= nil;
    cargarListaJugadores(lJ); // se dispone
    procesarInformacion(lJ, vM35, mejorJugador1, mejorJugador2, lJ2);
    informarMayores35PorEquipo(vM35);
    write("El mejor jugador es: ", mejorJugador1, "el segundo es: ", mejorJugador2);
end.
