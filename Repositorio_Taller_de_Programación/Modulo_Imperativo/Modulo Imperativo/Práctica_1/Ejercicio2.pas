Netflix ha publicado la lista de películas que estarán disponibles durante el mes de
septiembre de 2025. De cada película se conoce: código de película, código de género (1:
acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y
puntaje promedio otorgado por las críticas.
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el
código de la película -1.
b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje
obtenido entre todas las críticas, a partir de la estructura generada en a)..
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos
métodos vistos en la teoría.
d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje,
del vector obtenido en el punto c).

Program Ejercicio2;
const 
    dimF = 8;
type
    rangoGeneros = 1..8;

    pelicula = record
        cod: integer;
        gen: rangoGeneros;
        punt: real;
    end;

    listaP = ^nodo;
    nodo = record
        elem: pelicula;
        sig: listaP;
    end;

    vectorGeneros = array[rangoGeneros] of listaP;

    vectorMayorPunt = array[rangoGeneros] of integer;

    procedure leerPelicula(var p: pelicula);
    begin
        read(p.cod);
        if(p.cod <> -1) then
        begin
            read(p.gen);
            read(p.punt);
        end;
    end;

    procedure inicializarVector(var v: vectorGeneros);
    var
        i: integer;
    begin
        for i:= 1 to 8 do
            v[i]:= nil;
    end;

    procedure agregarAlFinal(var l: listaP; p: pelicula);
    var
        nuevo, aux: listaP;
    begin
        new(nuevo); nuevo^.elem:= p; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo
        else
        begin
            aux:= l;
            while(aux^.sig <> nil) do aux:= aux^.sig;
            aux^.sig:= nuevo;
        end;
    end;

    procedure cargarListaP(var v: vectorGeneros; var l: listaP);
    var
        p: pelicula;
    begin
        inicializarVector(v);
        leerPelicula(p);
        while(p.cod <> -1) do
        begin
            agregarAlFinal(v[p.gen], p);
            leerPelicula(p);
        end;
    end;

    function calcularMaximo(l: listaP) : integer;
    var
        max: integer;
        codMax: integer;
    begin
        max:= -1;
        while(l<>nil) do begin
            if(l^.punt > max) then begin
                max:= l^.punt;
                codMax:= l^.cod;
            end;
            l:= l^.sig;
        calcularMaximo:= codMax;
    end;

    procedure cargarVectorMayorPuntaje(vG: vectorGeneros; var vMP: vectorMayorPunt);
    var
        i: integer;
    begin
        for i: 1 to 8 do
        begin
            vMP[i]:= calcularMaximo(vG[i]); 
        end;
    end;

    procedure ordenarVectorMayorPuntaje(var vMP: vectorMayorPunt);
    var
        pos, i, j: integer;
        item: integer;
    begin
        for i:= 1 to dimF-1 do
        begin
            pos:= i;
            for j:= pos to dimF do
                if(vMP[j] < vMP[pos]) then pos:= j;
            item:= vMP[pos];
            vMP[pos]:= vMP[i];
            vMP[i]:= item;
        end;
    end;

    procedure imprimirDatos(vMP: vectorMayorPunt);
    begin
        writeln('El codigo de pelicula con mayor puntaje es: ', vMP[8]);
        writeln('El codigo de pelicula con menor puntaje es: ', vMP[1]);
    end;

var
    lP: listaP;
    vG: vectorGeneros;
    vMP: vectorMayorPunt;
begin
    cargarListaP(lP);
    cargarVectorMayorPuntaje(vG, vMP);
    ordenarVectorMayorPuntaje(vMP);
    imprimirDatos(vMP);
end.