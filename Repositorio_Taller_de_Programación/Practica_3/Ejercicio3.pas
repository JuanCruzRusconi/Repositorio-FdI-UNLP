Implementar un programa que contenga:
a. Un módulo que lea información de los finales rendidos por los alumnos de la Facultad de
Informática y los almacene en una estructura de datos. La información que se lee es legajo,
código de materia, fecha y nota. La lectura de los alumnos finaliza con legajo 0. La estructura
generada debe ser eficiente para la búsqueda por número de legajo y para cada alumno deben
guardarse los finales que rindió en una lista.
b. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con
legajo impar.
c. Un módulo que reciba la estructura generada en a. e informe, para cada alumno, su legajo y
su cantidad de finales aprobados (nota mayor o igual a 4).
c. Un módulo que reciba la estructura generada en a. y un valor real. Este módulo debe
retornar los legajos y promedios de los alumnos cuyo promedio supera el valor ingresado.

Program Ejercicio3;
type
    final = record
        cod: integer;
        fecha: integer;
        nota: integer;
    end;

    listaFinales = ^nodoLista;
    nodoLista = record
        elem: final;
        sig: listaFinales;
    end;

    alumno = record
        legajo: integer;
        lista: listaFinales;
    end;

    arbol = ^nodoArbol;
    nodoArbol = record
        elem: alumno;
        hi: arbol;
        hd: arbol;
    end;

    procedure leerDatos(var a: alumno; var f: final);
    begin
        writeln('Ingrese numero de legajo:');
        readln(a.legajo);
        if(a.legajo <> 0) then begin
            writeln('Ingrese codigo de final:');
            readln(f.cod);
            writeln('Ingrese fecha de final:');
            readln(f.fecha);
            writeln('Ingrese nota de final:');
            readln(f.nota);
        end;
    end;

    procedure agregarFinalLista(var l: listaFinales; f: final);
    var
        nuevo, aux: listaFinales;
    begin
        new(nuevo); nuevo^.elem:= f; nuevo^.sig:= nil;
        if(l = nil) then l:= nuevo
        else
        begin
            aux:= l;
            while(aux^.sig <> nil) do
                aux:= aux^.sig;
            aux^.sig:= nuevo;
        end;
    end;

    procedure agregarArbol(var a: arbol; al: alumno; f: final);
    begin
        if(a = nil) then begin
            new(a);
            a^.elem.legajo:= al.legajo;
            a^.elem.lista:= nil;
            agregarFinalLista(a^.elem.lista, f);
            a^.hi:= nil;
            a^.hd:= nil;
        end
        else begin
            if(a^.elem.legajo = al.legajo) then agregarFinalLista(a^.elem.lista, f)
            else
            begin
                if(a^.elem.legajo > al.legajo) then agregarArbol(a^.hi, al, f)
                else agregarArbol(a^.hd, al, f);
            end;
        end;
    end;

    procedure cargarInformacion(var a: arbol);
    var
       al: alumno;
       f: final;
    begin
        leerDatos(al, f);
        while(al.legajo <> 0) do begin
            agregarArbol(a, al, f);
            leerDatos(al,f);
        end;
    end;

    function cantLegajoImpar(a: arbol): integer;
    begin
        if(a = nil) then cantLegajoImpar:= 0
        else
        begin
            if(a^.elem.legajo MOD 2 = 1) then cantLegajoImpar:= 1 + cantLegajoImpar(a^.hi) + cantLegajoImpar(a^.hd)
            else cantLegajoImpar:= cantLegajoImpar(a^.hi) + cantLegajoImpar(a^.hd);
        end;
    end;

    procedure contarFinales(l: listaFinales; var cant: integer);
    begin
        while(l <> nil) do begin
            if(l^.elem.nota >= 4) then cant:= cant + 1;
            l:= l^.sig;
        end;
    end;

    // Funcion recursiva de contarFinales
    function contarFinales(l: lista): integer;
    begin
        if(l = nil) then contarFinales:= 0;
        else
            if(l^.elem.nota >= 4) then contarFinales:= 1 + contarFinales(l^.sig);
            else contarFinales(l^.sig);
        end;
    end;

    // Procedimiento recursivo de contarFinales
    procedure contarFinales(l: lista, var cant: integer);
    begin
        if(l <> nil) then begin
            if(l^.elem.nota >= 4) then cant:= cant + 1;
            contarFinales(l^.sig, cant);
        end;
    end;

    procedure informarFinalesAprobados(a: arbol);
    var
        cant: integer;
    begin
        if(a <> nil) then begin
            informarFinalesAprobados(a^.hi);
            cant:= 0;
            contarFinales(a^.elem.lista, cant);
            writeln('Alumno: ', a^.elem.legajo, ' tiene ', cant, ' finales aprobado/s.');
            informarFinalesAprobados(a^.hd);
        end;
    end;
    
    function calcularPromedio(l: listaFinales): real;
    var
        cant: integer;
        notas: integer;
    begin
        cant:= 0;
        notas:= 0;
        while(l <> nil) do begin
            cant:= cant + 1;
            notas:= notas + l^.elem.nota;  
            l:= l^.sig;
        end;
        calcularPromedio:= notas / cant;
    end;

    procedure mayorAlPromedio(a: arbol; prom: real);
    var
        promAl: real;
    begin
        if(a <> nil) then begin
            mayorAlPromedio(a^.hi, prom);
            promAl:= calcularPromedio(a^.elem.lista);
            if(promAl > prom) 
                then writeln('El alumno: ', a^.elem.legajo, ' superó el promedio de ', prom, ' con un promedio de: ', promAl);
            mayorAlPromedio(a^.hd, prom);
        end;
    end;

var
    a: arbol;
    legajoImpar: integer;
    promedio: real;
begin
    Randomize;
    a:= nil;
    cargarInformacion(a);
    legajoImpar:= cantLegajoImpar(a);
    writeln('La cantidad de alumnos con legajo impar es: ', legajoImpar);
    informarFinalesAprobados(a);
    writeln('Ingrese un promedio:');
    readln(promedio);
    mayorAlPromedio(a, promedio);
end.