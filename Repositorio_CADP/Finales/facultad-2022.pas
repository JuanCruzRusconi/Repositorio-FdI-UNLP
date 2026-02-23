La Ftacultad de Informatica organizara el congreso WICC, en donde se expondrán trabajos de investigación.
Realizar un programa que lea la información de cada publicación: título de la publicación, nombre del autor, DNI del 
autor y tipo de publicación (1..12). La lectura de publicaciones finaliza al ingresar un DNI de autor con valor 0 
(el cual no debe procesarse). La información se lee ordenada por DNI del autor y un autor puede tener varias 
publicaciones. Se pide escribir un programa que:
a. Informe el tipo de publicación con mayor cantidad de publicaciones.
b. Informar para cada autor la cantidad de publicaciones presentadas.

Program Facultad;
const

type
    rangoPublicacion = 1..12;
    publicacion = record
        titulo: string;
        autor: string;
        dni: integer;
        tipo: rangoPublicacion;
    end;

    listaPublicaciones = ^nodo;

    nodo = record
        elem: publicacion;
        sig: listaPublicaciones;
    end;

    vectorTipos = array[rangoPublicacion] of integer;

    procedure inicializarVector(var v: vectorTipos)
    var
        i: integer;
    begin
        for i:= 1 to 12 do begin
            v[i]:= 0;
        end;
    end;

    procedure leerPublicacion(var p: publicacion)
    begin
        read(p.dni);
        if(p.dni <> 0) then begin
            read(p.titulo);
            read(p.autor);
            read(p.tipo);
        end;
    end;

    procedure agregarAdelante(var l: listaPublicaciones; p: publicacion)
    var
        nuevo: listaPublicaciones;
    begin
        new(nuevo); nuevo^.elem:= p; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else begin
            nuevo^.sig:= l;
            l:= nuevo;
        end;
    end;    

    procedure cargarDatos(var l : listaPublicaciones; var v: vectorTipos)
    var
        p: publicacion;
    begin
        inicializarVector(v);
        leerPublicacion(p);
        while(p.dni <> 0) do begin
            v[p.tipo]:= v[p.tipo] + 1;
            agregarAdelante(l, p);
            leerPublicacion(p);
        end;     
    end;

    procedure cargarDatosSinLista(var l : listaPublicaciones; var v: vectorTipos)
    var
        p: publicacion;
        dniActual, cantActual: integer;
    begin
        inicializarVector(v);
        leerPublicacion(p);
        while(p.dni <> 0) do begin
            dniActual:= p.dni;
            cantActual:= 0;
            while(p.dni <> 0) and (dniActual = p.dni) do begin
                cantActual:= cantActual + 1;
                v[p.tipo]:= v[p.tipo] + 1;
                leerPublicacion(p);
            end;
            writeln("Para el autor de dni", dniActual, " la cantidad de publicaciones es de: ", cantActual);
        end;     
    end;

    procedure procesarDatos(l: listaPublicaciones)
    var
        dniActual, cantActual: integer;
    begin
        while(l <> nil) do begin
            dniActual:= l^.elem.dni;
            cantActual:= 0;
            while(l <> nil) and (dniActual = l^.elem.dni) do begin
                cantActual:= cantActual + 1;
                l:= l^.sig;
            end;
            writeln("Para el autor de dni", dniActual, " la cantidad de publicaciones es de: ", cantActual);
        end;
    end;

    procedure mayorCantPublicaciones(v: vectorTipos; var mayor: rangoPublicacion)
    var
        i: rangoPublicacion;
        maxCant, maxTipo: integer;
    begin
        maxCant:= -1;
        for i:= 1 to 12 do begin
            if(v[i] > maxCant) then begin
                maxCant:= v[i];
                mayor:= i;
            end;
        end;
    end;

var
    l: listaPublicaciones;
    v: vectorTipos;
    mayorTipo: rangoPublicacion;
begin
    l:= nil;
    cargarDatos(l, v);
    procesarDatos(l);
    mayorCantPublicaciones(v, mayorTipo);
    writeln("El tipo con mayor cantidad de publicaciones es: ", mayorTipo);
end.