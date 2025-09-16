Una biblioteca nos ha encargado procesar la información de los préstamos realizados
durante el año 2021. De cada préstamo se conoce el ISBN del libro, el número de socio, día
y mes del préstamo y cantidad de días prestados. Implementar un programa con:
a. Un módulo que lea préstamos y retorne 2 estructuras de datos con la información de
los préstamos. La lectura de los préstamos finaliza con ISBN 0. Las estructuras deben
ser eficientes para buscar por ISBN.
i. En una estructura cada préstamo debe estar en un nodo. Los ISBN repetidos
insertarlos a la derecha.
ii. En otra estructura, cada nodo debe contener todos los préstamos realizados al ISBN.
(prestar atención sobre los datos que se almacenan).
b. Un módulo recursivo que reciba la estructura generada en i. y retorne el ISBN más
grande.
c. Un módulo recursivo que reciba la estructura generada en ii. y retorne el ISBN más
pequeño.
d. Un módulo recursivo que reciba la estructura generada en i. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
e. Un módulo recursivo que reciba la estructura generada en ii. y un número de socio. El
módulo debe retornar la cantidad de préstamos realizados a dicho socio.
f. Un módulo que reciba la estructura generada en i. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
g. Un módulo que reciba la estructura generada en ii. y retorne una nueva estructura
ordenada ISBN, donde cada ISBN aparezca una vez junto a la cantidad total de veces
que se prestó.
h. Un módulo recursivo que reciba la estructura generada en g. y muestre su contenido.
i. Un módulo recursivo que reciba la estructura generada en i. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).
j. Un módulo recursivo que reciba la estructura generada en ii. y dos valores de ISBN. El
módulo debe retornar la cantidad total de préstamos realizados a los ISBN
comprendidos entre los dos valores recibidos (incluidos).

Program Ejercicio3;
    anio = 2021;
type
    prestamo = record
        num: integer;
        dia: integer;
        mes: integer;
        cant: integer;
    end;

    isbn = record
        isbnCod: integer;
        prestamo: prestamo;
    end;

    arbol1 = ^nodo1;
    nodo1 = record
        elem: isbn;
        hi: arbol1;
        hd: arbol1;
    end;

    listaPrestamos = record
        elem: prestamo;
        sig: listaPrestamos;
    end;

    prestamosISBN = record
        isbn: integer;
        lista: listaPrestamos;
    end;

    arbol2 = ^nodo2;
    nodo2 = record
        elem: prestamosISBN;
        hi: arbol2;
        hd: arbol2;
    end;

    procedure leerPrestamo(var i: isbn);
    begin
        read(i.isbnCod);
        if(p.isbn <> 0) then begin
            read(i.prestamo.num);
            read(i.prestamo.dia);
            read(i.prestamo.mes);
            read(i.prestamo.cant);
        end;
    end;

    procedure agregarAlArbol1(var a: arbol1, i: isbn);
    begin
        if(a = nil) then begin
            new(a);
            a^.elem:= i;
            a^.hi:= nil;
            a^.hd:= nil;
        end
        else
            begin
                if(a^.elem.isbn = i.isbnCod) then agregarAlArbol1(a^.hd, i)
                else if (a^.elem.isbn > p.isbn) then agregarAlArbol1(a^.hi, i)
                else agregarAlArbol1(a^.hd, i)
            end;
    end;

    procedure agregarAlArbol2(var a: arbol2, i: isbn);
    begin
        if(a = nil) then begin
            new(a);
            a^.elem:= p;
            a^.hi:= nil;
            a^.hd:= nil;
        end
        else
            begin
                if(a^.elem.isbn = p.cod) then agregarAlArbol1(a^.hd, p)
                else if (a^.elem.isbn > p.isbn) then agregarAlArbol1(a^.hi, p)
                else agregarAlArbol1(a^.hd, p)
            end;
    end;

    procedure cargarInformacion(var a1: arbol1; var a2: arbol2);
    var
        i: isbn;
    begin
        leerPrestamo(i);
        while(p.isbn <> 0) do begin
            agregarAlArbol1(a1, i);
            agregarAlArbol2(a2, i);
            leerPrestamo(i);
        end;
    end;

    function retornarMasGrande(a: arbol1): integer;
    begin
        if(a = nil) then retornarMasGrande:= 0
        else
        begin
            if(a^.hd = nil) then retornarMasGrande:= a^.elem.isbnCod
            else retornarMasGrande:= retornarMasGrande(a^.hd);
        end;
    end;

    function retornarMasChico(a: arbol2): integer;
    begin
        if(a = nil) then retornarMasChico:= 0
        else
        begin
            if(a^.hi = nil) then retornarMasChico:= a^.elem.isbnCod
            else retornarMasChico:= retornarMasChico(a^.hi);
        end;
    end;

    function retornarCantPrestamosSocio(a: arbol1; soio: integer): integer;
    begin
        if(a = nil) then retornarCantPrestamosSocio:= 0;
        else
        begin
            if(a^.elem.isbn.prestamo.num = socio) then retornarCantPrestamosSocio:= a^.elem.prestamo.cant + retornarCantPrestamosSocio(a^.hi, socio) + retornarCantPrestamosSocio(a^.hd, socio)
            else if(a^.elem.prestamo.num > socio) then retornarCantPrestamosSocio:= retornarCantPrestamosSocio(a^.hi, socio)
            else retornarCantPrestamosSocio:= retornarCantPrestamosSocio(a^.hd, socio);
        end;
    end;

    function contarCantPrestamos(l: listaPrestamos): integer;
    var
        cant: integer
    begin
        cant:= 0;
        while(l <> nil) then begin
            cant:= cant + l^.elem.cant;
            l:= l^.sig;
        end;
        contarCantPrestamos:= cant;
    end;

    function retornarCantPrestamosSocio(a: arbol2; soio: integer): integer;
    begin
        if(a = nil) then retornarCantPrestamosSocio:= 0;
        else
        begin
            if(a^.elem.isbn.prestamo.num = socio) then retornarCantPrestamosSocio:= contarCantPrestamos(a^.elem.lista)+ retornarCantPrestamosSocio(a^.hi, socio) + retornarCantPrestamosSocio(a^.hd, socio)
            else if(a^.elem.prestamo.num > socio) then retornarCantPrestamosSocio:= retornarCantPrestamosSocio(a^.hi, socio)
            else retornarCantPrestamosSocio:= retornarCantPrestamosSocio(a^.hd, socio);
        end;
    end;

var
    a1: arbol1;
    a2: arbol2:
    mayorIsbn: integer;
    menorIsbn: integer;
    socio, socio2: integer;
    cantPrestamos, cantPrestamos2: integer;
begin
    a1:= nil;
    a2:= nil;
    cargarInformacion(a1, a2);
    mayorIsbn:= retornarMasGrande(a1);
    writeln('El isbn mas grande es: ', mayorIsbn);
    menorIsbn:= retornarMasChico(a2);
    writeln('El isbn mas chico es: ', menorIsbn);
    readln(socio);
    cantPrestamos:= retornarCantPrestamosSocio(a, socio);
    writeln('La cantidad de prestamos realizados al socio ', socio, ' es: ', cantPrestamos);
    eadln(socio2);
    cantPrestamos2:= retornarCantPrestamosSocio2(a, socio2);
end;