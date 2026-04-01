La Facultad de Informatica organizara el congreso WICC, en donde se expondrán trabajos de investigación.
Realizar un programa que lea la información de cada publicación: título de la publicación, nombre del autor, DNI del 
autor y tipo de publicación (1..12). La lectura de publicaciones finaliza al ingresar un DNI de autor con valor 0 
(el cual no debe procesarse). La información se lee ordenada por DNI del autor y un autor puede tener varias 
publicaciones. Se pide escribir un programa que:
a. Informe el tipo de publicación con mayor cantidad de publicaciones.
b. Informar para cada autor la cantidad de publicaciones presentadas.

Program congreso;

const
    maxRango = 12;
type
    rangoPublicacion = 1..maxRango;
    publicacion = record
        titulo: string;
        nombre: string;
        dni: integer;
        tipo: rangoPublicacion;
    end;

    vector = arrar[rangoPublicacion] of integer;

    procedure inicializarVector(var v: vector)
    var
        i: integer;
    begin
        for i:= 1 to maxRango do
            v[i]:= 0;
    end;

    procedure leerPublicacion(var p: publicacion)
    begin
        read(p.dni);
        if(p.dni <> 0) then begin
            read(p.titulo);
            read(p.nombre);
            read(p.tipo;)
        end;
    end;

    procedure actualizarMaximo(v: vector; var mT: rangoPublicacion; var max: integer)
    var
        i: integer;
    begin
        for i:= 1 to maxRango do begin
            if(v[i] > max) then begin
                max:= v[i];
                mT:= i;
            end;
        end;
    end;

    procedure procesarInformacion(var v: vector; var mT: rangoPublicacion)
    var
        actual, cant: integer;
        max: integer;
        p: publicacion;
    begin
        max:= -1;
        leerPublicacion(p);
        while(p.dni <> 0) do begin
            actual:= p.dni;
            cant:= 0;
            while(p.dni <> 0) and (actual = p.dni) do begin
                cant:= cant + 1;
                v[p.tipo]:= v[p.tipo] + 1;
                leerPublicacion(p);
            end;
            writeln('El autor ', actual, ' presento: ', cant, ' publicaciones.');
        end;
        actualizarMaximo(v, mT, max);
    end;
var
    v: vector;
    mayorTipo: rangoPublicacion;
begin
    inicializarVector(v);
    procesarInformacion(v, mayorTipo);
    writeln('El rango con mayor cantidad de publicaciones es: ', mayorTipo);
end;