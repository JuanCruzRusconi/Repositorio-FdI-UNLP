EL INDEC está actualizando el indice que calcula el costo de vida para una familia, Para ello, dispone de una estraetura de 
datos con información sobre los items de la canasta familiar, compuesta por productos y servicios, que consume una familia 
en un determinado período. De cada ítem se conoce su descripción, cuânto cuesta, el tipo (producto o servicio) y el código 
de categoria (1..300). Pueden existir muchos productos de la misma categoría, y la información se encuentra ordenada por código 
de categoría. Además, dispone de otra estructura de datos que posee el peso que representa (un valor real entre 0 y 1) en 
cada categoria de la canasta familiar. Realizar un programa que procese esta información e informe:
a. El coste de vida total para una familia. Para ello, debe sumar los elementos de la canasta familiar, multiplicados por 
el peso de este según su categoría.
b. Los códigos de las 15 categorías que representan el mayor gasto total para una familia.

Program indec;
const
    maxCat = 300;
type
    rangoCat = 1..maxCat;
    item = record
        desc: string;
        costo: real;
        tipo: string;
        cod: rangoCat;
    end;
    listaItems = ^nodo;
    nodo = record
        elem: item;
        sig: listaItems;
    end;
    vector = array [rangoCat] of real;

    categorias = record
        cat: rangoCat;
        gasto: real;
    end;
    vectorMaximos = array [1..15] of categorias;

    procedure cargarLista(var l: listaItems) // se dispone

    procedure cargarVector(var v: vector) // se dispone

    procedure inicializarVector(var v: vectorMaximos)
    var
        i: integer;
    begin
        for i:= 1 to 15 do
            v[i].gasto:= 0;
    end;

    procedure actualizarMaximos(var v: vectorMaximos; cat: rangoCat; gasto: real)
    var
        i, j: integer;
        pude: boolean;
    begin
        i:= 1;
        pude:= false;
        while(i <= 15) and (not pude) do begin
            if(gasto > v[i].gasto) then begin
                for j:= 15 downto i+1 do
                    v[j]:= v[j-1];
                v[i].cat:= cat;
                v[i].gasto:= gasto;
                pude:= true;
            end;
            i:= i + 1;
        end;
    end;

    procedure inicializarVector(var v: vector)
    var
        i: integer;
    begin
        for i:= 1 to 15 do begin
            v[i].cat:= 0;
            v[i].coste:= -1;
        end;
    end;

    procedure procesarDatos(l: listaItems; v: vector; var cT: real; var vT: vectorMaximos)
    var
        catActual: integer;
        gastoActual: real;
    begin
        cT:= 0;
        inicializarVector(vT);
        while(l <> nil) do begin
            catActual:= l^.elem.cod;
            gastoActual:= 0;
            while(l <> nil) and (catActual = l^.elem.cod) do begin
                gastoActual:= gastoActual + l^.elem.costo;
                l:= l^.sig;
            end;
            gastoActual:= gastoActual * v[catActual];
            cT:= cT + gastoActual;
            actualizarMaximos(vT, catActual, gastoActual);
        end;
    end;

    procedure imprimirMaxCategorias(v: vectorMaximos)
    var
        i: integer;
    begin
        for i:= 1 to 15 do
            writeln("Categoria posicion ", i, " es: ", v[i].cat, " con un gasto de: ", v[i].gasto);
    end;

var
    lI: listaItems;
    v: vector;
    cT: real;
    vT: vectorMaximos;
begin
    lI:= nil;
    cargarLista(lI);//se dispone
    cargarVector(v); // se dispone
    procesarDatos(lI, v, cT, vT);
    writeln("El costo de vida total es de: ", cT);
    imprimirMaxCategorias(vT);
end.

procedure actualizarMaximos(var v: vector; cod: rangoCod; coste: real)
var
    i, j: integer;
    pude: boolean;
begin
    i:= 1;
    pude:= false;
    while(i <= 15) and (not pude) do begin
        if(v[i].coste < coste) then begin
            for j:= 15 downto (i+1) do begin
                v[j]:= v[j-1];
            end;
            v[i].cod:= cat;
            v[i].coste:= coste;
            pude:= true;
        end
        i:= i + 1;
    end;
end;

procedure eliminarVector(var v: vector; var dL: integer)
var
    i, j: integer;
begin
    i:= 1;
    while(i <= dL) do begin
        if(cumple(v[i].algo)) then begin
            for j:= i to (dL - 1) do
                v[j]:= v[j+1];
            dL:= dL - 1;
        end
        else
            i:= i + 1;
    end;
end;