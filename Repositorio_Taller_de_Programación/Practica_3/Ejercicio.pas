Escribir un programa que:
a. Implementar un modulo que almacene informacion de socios de un club en un arbol binario de busqueda. De cada socio 
se debe almacenar numero de socio, nombre y edad. La carga finaliza con el numero de socio 0 y el arbol debe quedar
ordenado por numero de socio. La informacion de cada socio debe generarse aleatoriamente.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro para: 
    i. Informar los datos de los socios en orden creciente    por número de socio.
    ii. Informar los datos de los socios en orden decreciente por número de socio.
    iii. Informar el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
    iv. Aumentar en 1 la edad de los socios con edad impar e informar la cantidad de socios que se les aumento la edad.
    vi. Leer un nombre e informar si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que 
    reciba el nombre leído y retorne verdadero o falso.
    vii. Informar la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
    viii. Informar el promedio de edad de los socios. Debe invocar al módulo recursivo del inciso vii e invocar a un 
    módulo recursivo que retorne la suma de las edades de los socios.

Program Ejercicio1;

type
    rangoEdad = 12..80;
    cadena = string[15];

    socio = record
        num: integer;
        nombre: cadena;
        edad: rangoEdad;
    end;

    arbol = ^nodo;
    nodo = record
        elem: socio;
        hi: arbol;
        hd: arbol;
    end;

    procedure leerSocio(var s: socio);
    begin
        s.num:= random(15);
        if(s.num <> 0) then
            begin
                s.nombre:= 'Juan';
                s.edad:= 12 + random(80 - 12);
            end;
    end;

    procedure agregarAlArbol(var a: arbol; s: socio);
    begin
        if(a = nil) then begin
            new(a); a^.elem:= s; a^.hi:= nil; a^.hd:= nil
        end
        else
            begin
                if(a^.elem.num > s.num) then agregarAlArbol(a^.hi, s)
                else agregarAlArbol(a^.hd, s)
            end;
    end;

    procedure cargarInformacion(var a: arbol);
    var
        s: socio;
    begin
        leerSocio(s);
        while(s.num <> 0) do
            begin
                agregarAlArbol(a, s);
                leerSocio(s);
            end;
    end;

    procedure informarSociosCreciente(a: arbol);
    begin
        if(a <> nil) then
            begin
                informarSociosCreciente(a^.hi);
                write(a^.elem.num);
                write(a^.elem.nombre);
                write(a^.elem.edad);
                writeln('-----');
                informarSociosCreciente(a^.hd);
            end;
    end;

    procedure informarSociosDecreciente(a: arbol);
    begin
        if(a <> nil) then
            begin
                informarSociosDecreciente(a^.hd);
                writeln(a^.elem.num);
                writeln(a^.elem.nombre);
                writeln(a^.elem.edad);
                writeln('-----');
                informarSociosDecreciente(a^.hi);
            end;
    end;

    procedure actualizarMaximo(num: integer; edad: integer; var maxEdad: integer; var maxNum: integer);
    begin
        if(edad > maxEdad) then
            begin
                maxEdad:= edad;
                maxNum:= num;
            end;
    end;

    procedure socioMayorEdad(a: arbol; var maxNum: integer; var maxEdad: integer);
    begin
        if(a <> nil) then
            begin
                actualizarMaximo(a^.elem.num, a^.elem.edad, maxEdad, maxNum);
                socioMayorEdad(a^.hi, maxNum, maxEdad);
                socioMayorEdad(a^.hd, maxNum, maxEdad);
            end;
    end;

    function esImpar(num: integer): boolean;
    begin
        if(num MOD 2 = 0) then esImpar:= true
        else esImpar:= false;
    end;

    function aumentarEdadEInformar(a: arbol): integer;
    var 
        resto: integer;
    begin
        if(a <> nil) then
            begin
                resto:= a^.elem.edad MOD 2;
                if(resto <> 0) then a^.elem.edad:= a^.elem.edad + 1;
                aumentarEdadEInformar:= aumentarEdadEInformar(a^.hi) + aumentarEdadEInformar(a^.hd) + resto;
            end
        else    
            aumentarEdadEInformar:= 0;
    end;
    
    function buscarNombre(a: arbol; nombre: string): boolean;
    var
        existe: boolean;
    begin
        if(a = nil) then buscarNombre:= false
        else
            begin
                if(a^.elem.nombre = nombre) then buscarNombre:= true
                else
                    begin
                        existe:= buscarNombre(a^.hi, nombre);
                        if(existe = false) then existe:= buscarNombre(a^.hd, nombre);
                        buscarNombre:= existe;
                    end;
            end;
    end;
    
    function informarSocios(a: arbol): integer;
    begin
        if(a = nil) then
            informarSocios:= 0
        else
            informarSocios:= 1 + informarSocios(a^.hi) + informarSocios(a^.hd);
    end;
    
    function calcularEdades(a: arbol): integer;
    begin
        if(a = nil) then calcularEdades:= 0
        else
            calcularEdades:= a^.elem.edad + calcularEdades(a^.hi) + calcularEdades(a^.hd);
    end;
    
    function calcularPromedio(a: arbol): real;
    var
        cant, edades: integer;
    begin
        cant:= calcularEdades(a);
        if(cant = 0) then calcularPromedio:= 0
        else
            begin
                edades:= calcularEdades(a);
                calcularPromedio:= edades/cant;
            end;
    end;

var
    a: arbol;
    maxNum: integer;
    maxEdad: integer;
    cant: integer;
    nom: string;
    nombre: boolean;
    socios: integer;
    promedio: real;
begin
    a:= nil;
    Randomize;
    cargarInformacion(a);
    writeln('Informar socios creciente: ');
    informarSociosCreciente(a);
    writeln('Informar socios decreciente: ');
    informarSociosDecreciente(a);
    maxEdad:= -1;
    socioMayorEdad(a, maxNum, maxEdad);
    if(maxEdad = -1) then writeln('Arbol vacío')
    else writeln('El socio con mayor edad es: ', maxNum, ' con la edad de: ', maxEdad);
    cant:= aumentarEdadEInformar(a);
    writeln('La cantidad de socios que se aumento la edad es de: ', cant);
    writeln('Ingrese un nombre');
    readln(nom);
    nombre:= buscarNombre(a, nom);
    writeln('Se encontro el nombre: ', nombre);
    socios:= informarSocios(a);
    writeln('La cantidad de socios es: ', socios);
    promedio:= calcularPromedio(a);
    writeln('Promedio: ', promedio);
end.