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
    categorias = 1..maxCat;
    item = record
        desc: string;
        costo: real;
        tipo: string;
        cod: categorias;
    end;

    listaItems = ^nodo;
    nodo = record
        elem: item;
        sig: listaItems;
    end;

    vectorPeso = array [categorias] of real;

    gastoCategoria = record
        cod: categorias;
        gasto: real;
    end;

    listaMayoresCategorias = ^nodo2;
    nodo2 = record  
        elem: gastoCategoria;
        sig: listaMayoresCategorias;
    end;

    procedure cargarLista(var l: listaItems); // se dispone

    procedure cargarVector(var v: vectorPeso); // se dispone

    procedure agregarListaMayoresCategorias(var l: listaMayoresCategorias; cat: categorias; coste: real)
    var
        nuevo, anterior, actual: listaMayoresCategorias;
    begin
        new(nuevo); nuevo^.elem.cod:= cat; nuevo^.elem.gasto:= coste; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo;
        else begin
            actual:= l; anterior:= l;
            while(actual <> nil) and (actual^.elem.gasto > nuevo^.elem.gasto) do begin
                anterior:= actual;
                actual:= actual^.sig;
            end;
        end;    
        if(actual = l) then begin
            nuevo^.sig:= l;
            l:= nuevo;
        end;
        else begin
            anterior^.sig:= nuevo;
            nuevo^.sig:= actual;
        end;
    end;

    procedure procesarDatos(l: listaItems; v: vectorPeso; var cT: real; var lMC: listaMayoresCategorias)
    var
        catActual: categorias;
        costeActual: real;
    begin
        cT:= 0;
        while(l <> nil) do begin
            catActual:= l^.elem.cod;
            costeActual:= 0;
            while(l <> nil) and (l^.elem.cod = catActual) do begin
                costeActual:= costeActual + l^.elem.costo * v[l^.elem.cod];
                l:= l^.sig;
            end;
            cT:= cT + costeActual;
            agregarListaMayoresCategorias(lMC, catActual, costeActual);
        end;
    end;

    procedure imprimirListaMayoresCategorias(l: listaMayoresCategorias)
    var
        pos: integer;
    begin
        pos:= 1;
        while(l <> nil) and (pos <= 15) do begin
            writeln("En la posición ", pos, " categoría: ", l^.elem.cod, " con un gasto total de: ", l^.elem.gasto);
            pos:= pos + 1;
            l:= l^.sig;
        end;
    end;

var
    l: listaItems;
    v: vectorPeso;
    cT: real;
    lMC: listaMayoresCategorias;
begin
    l:= nil;
    lMC: listaMayoresCategorias;
    cargarLista(l);
    cargarVector(v);
    lMC:= nil;
    procesarDatos(l, v, cT, lMC);
    writeln("El costo de vida total para una familia es de: ", cT);
    imprimirListaMayoresCategorias(lMC);
end;