La Feria del Libro necesita un sistema para obtener estadísticas sobre los libros
presentados.
a) Implementar un módulo que lea información de los libros. De cada libro se conoce:
ISBN, código del autor y código del género (1: literario, 2: filosofía, 3: biología, 4: arte,
5: computación, 6: medicina, 7: ingeniería) . La lectura finaliza con el valor 0 para el
ISBN. Se sugiere utilizar el módulo leerLibro(). El módulo deber retornar dos
estructuras:
i. Un árbol binario de búsqueda ordenado por código de autor. Para cada código de autor
debe almacenarse la cantidad de libros correspondientes al código.
ii. Un vector que almacene para cada género, el código del género y la cantidad de libros del
género.
b) Implementar un módulo que reciba el vector generado en a), lo ordene por cantidad
de libros de mayor a menor y retorne el nombre de género con mayor cantidad
cantidad de libros.
c) Implementar un módulo que reciba el árbol generado en a) y dos códigos. El módulo
debe retornar la cantidad total de libros correspondientes a los códigos de autores
entre los dos códigos ingresados (incluidos ambos).
NOTA: Implementar el programa principal, que invoque a los incisos a, b y c.

Program Ejercicio4;

const

type
    rangoGenero = 1..7;
    libro = record
        isbn: integer;
        codAutor: integer;
        codGenero: rangoGenero;
    end;

    registroArbol = record
        cod: integer;
        cant: integer;
    end;

    arbol = ^nodo;
    nodo = record
        elem: registroArbol;
        hi: arbol;
        hd: arbol;
    end;

    registroVector = record
        genero: integer;
        cant: integer;
    end;

    vector = array[rangoGenero] of registroVector;

    procedure leerLibro(var l: libro);
    begin
        readln(l.isbn);
        if(l.isbn <> 0) then begin
            readln(l.codAutor);
            readln(codGenero);
        end;
    end;

    procedure inicializarVector(var v: vector);
    var
        i: integer;
    begin
        for i:= 1 to 7 do 
            v[i].genero:= i;
            v[i].cant:= 0;
    end;

    procedure agregarAlArbol(var a: arbol; codA: integer);
    begin
        if(a = nil) then begin
            new(a);
            a^.elem.cod:= codA;
            a^.elem.cant:= 1;
            a^.hi:= nil;
            a^.hd:= nil;
        end
        else
            begin
                if(a^.elem.cod = codA) then a^.elem.cant:= a^.elem.cant + 1
                else if(a^.elem.cod > codA) then agregarAlArbol(a^.hi,  codA)
                else agregarAlArbol(a^.hd, codA);
            end;
    end;

    procedure cargarInformacion(var a: arbol; var v: vector);
    var
        l: libro;
    begin
        inicializarVector(v);
        leerlibro(l);
        while(l.isbn <> 0) do begin
            agregarAlArbol(a, l.codAutor);
            v[l.codGenero].cant:= v[l.codGenero].cant + 1;
            leerLibro(l);
        end;    
    end;

    procedure ordenarVector(var v: vector);
    var
        i, j, pos: integer;
        item: registroVector;
    begin
        for i: 1 to 7-1 do begin
            pos:= i;
            for j:= i+1 to 7 do
                if(v[j] > v[pos]) then pos:= j;
            item:= v[pos];
            v[pos]:= v[i];
            v[i]:= item;
    end;

    function cantTotalEntreCodigos(a: arbol; codA, codB: integer): integer
    begin
        if(a = nil) then cantTotalEntreCodigos:= 0;
        else
            begin
                if(a^.elem.cod >= codA) and (a^.elem.cod <= codB) then cantTotalEntreCodigos:= a^.elem.cant 
                                                    + cantTotalEntreCodigos(a^.hi, codA, codB)
                                                    + cantTotalEntreCodigos(a^.hd, codA, codB)
                else if (a^.elem.cod > codB) cantTotalEntreCodigos:= cantTotalEntreCodigos(a^.hi, codA, codB)
                else cantTotalEntreCodigos:= cantTotalEntreCodigos(a^.hd, codA, codB);
            end;
    end;

var
    a: arbol;
    v: vector;
    maxGenero: integer;
    cantTotal: integer;
begin
    a:= nil;
    cargarInformacion(a, v);
    ordenarVector(v, maxGenero);
    writeln('El mayor genero es el genero: ', v[1].genero);
    readln(codA);
    readln(codB);
    cantTotal:= cantTotalEntreCodigos(a, codA, codB);
end;