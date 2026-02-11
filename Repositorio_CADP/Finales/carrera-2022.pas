Se dispone de la información de los participantes inscriptos a una carrera (a lo sumo 5000). De cada participante se tiene 
DNI, nombre y apellido, categoría (1..5) y fecha de inscripción. Se pide implementar un programa que guarde en una 
estructura adecuada los participantes de aquellas categorías que posean a lo sumo 50 inscriptos. Se sabe que cada 
participante se puede anotar en una sola categoría.

Program carrera;
const
    maxInscriptos = 5000;
type
    rangoCat = 1..5;

    participante = record
        dni: integer;
        nomApe: string;
        categoria: rangoCat;
        fecha: integer;
    end;

    vectorInscriptos = array[1..maxInscriptos] of participante;

    listaParticipantes = ^nodo;

    nodo = record
        elem: participante;
        sig: listaParticipantes;
    end;

    vectorContador = array[rangoCat] of integer;

    procedure cargarVectorInscriptos(var vI: vectorInscriptos; var dimL: integer) // se dispone

    procedure inicializarVector(var vC: vectorContador)
    var
        i: integer;
    begin
        for i:= 1 to 5 do
            vC[i]:= 0;
    end;

    procedure procesarParticipantes(vI: vectorInscriptos; dimL: integer; var vC: vectorContador)
    var
        i: integer;
    begin
        inicializarVector(vC);
        for i:= 1 to dimL do begin
            vC[vI[i].categoria]:= vC[vI[i].categoria] + 1;
        end;
    end;

    procedure agregarAtras(var lP: listaParticipantes; p: participante)
    var
        nuevo, aux: listaParticipantes;
    begin
        new(nuevo); nuevo^.elem:= p; nuevo^.sig:= nil;
        if(lP = nil) then lP:= nuevo;
        else begin
            aux:= lP;
            while(aux^.sig <> nil) do
                aux:= aux^.sig;
            aux^.sig:= nuevo;
        end; 
    end;

    procedure cargarListaParticipante(vI: vectorInscriptos, dimL: integer, vC: vectorContador, var lP: listaParticipantes);
    var
        i: integer;
    begin
        for i:= 1 to dimL do begin
            if(vC[vI[i].categoria] <= 50) then
                agregarAtras(lP, vI[i]);
        end;
    end;


var
    vI: vectorInscriptos;
    dimL: integer;
    lP: listaParticipantes;
    vC: vectorContador;
begin
    lP:= nil;
    cargarVectorInscriptos(vI, dimL);
    procesarParticipantes(vI, dimL, vC);
    cargarListaParticipante(vI, dimL, vC, lP);
end.