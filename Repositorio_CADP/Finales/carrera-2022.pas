Se dispone de la información de los participantes inscriptos a una carrera (a lo sumo 5000). De cada participante se tiene 
DNI, nombre y apellido, categoría (1..5) y fecha de inscripción. Se pide implementar un programa que guarde en una 
estructura adecuada los participantes de aquellas categorías que posean a lo sumo 50 inscriptos. Se sabe que cada 
participante se puede anotar en una sola categoría.

Program carrera;
const 
    maxParticipantes = 5000;
type
    rangoParticipantes = 1..maxParticipantes;
    rangoCategoria = 1..5;
    participante = record
        dni: integer;
        nombre: string;
        categoria: rangoCategoria;
        fecha: string;
    end;

    vectorParticipantes = array[rangoParticipantes] of participante;
    vectorCategorias = array[rangoCategoria] of integer;

    listaParticipantes = ^nodo;
    nodo = record
        elem: participante;
        sig: listaParticipantes;
    end;

    procedure leerParticipante(var p: participante)
    begin
        readln(p.dni);
        if(p.dni <> -1) then begin
            readln(p.nombre);
            readln(p.categoria);
            readln(p.fecha);
        end;
    end;

    procedure cargarParticipantes(var v: vectorParticipantes; var dimL: rangoParticipantes)
    var
        p: participante;
    begin
        dL:= 0;
        leerParticipante(p);
        while(dimL <= maxParticipantes) and (p.dni <> -1) do begin
            dL:= dL + 1;
            v[dL]:= p;
            leerParticipante(p);
        end;
    end;

    procedure inicializarVector(var vC: vectorCategorias)
    var
        i: integer;
    begin
        for i:= 1 to 5 do
            vC[i]:= 0;
    end;

    procedure procesarParticipantes(v: vectorParticipantes; dimL: rangoParticipantes; var vC: vectorCategorias)
    var
        i: integer;
        cant: integer;
    begin
        inicializarVector(vC);
        i:= 1
        while(i <= dimL) do begin
            vC[v[i].categoria]:= vC[v[i].categoria] + 1;
            i:= i + 1;
        end;
    end;

    procedure agregarLista(var l: listaParticipantes; p: participante)
    var
        nuevo: listaParticipantes;
    begin
        new(nuevo); nuevo^.elem:= p; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else begin
            nuevo^.sig:= l;
            l:= nuevo;
        end;
    end;

    procedure cargarListaParticipante(v: vectorParticipantes; dimL: rangoParticipantes; vC: vectorCategorias; var l: listaParticipantes);
    var
        i:= integer;
    begin
        i:= 1;
        while(i <= dimL) do begin
            if(vC[v[i].categoria] <= 50) then agregarLista(l, v[i]);
            i:= i + 1;
        end;
    end;

var 
    vP: vectorParticipantes;
    dimL: rangoParticipantes;
    vC: vectorCategorias;
    lP: listaParticipantes;
begin
    cargarParticipantes(vP, dimL);
    lP:= nil;
    procesarParticipantes(vP, dimL, vC);
    cargarListaParticipante(vP, dimL, vC, lP);
end.