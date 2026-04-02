2. Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados creado en el
ejercicio 1, informe por pantalla cantidad de números menores a 15000 y el promedio de los
números ingresados. El nombre del archivo a procesar debe ser proporcionado por el usuario
una única vez. Además, el algoritmo deberá listar el contenido del archivo en pantalla. Resolver
el ejercicio realizando un único recorrido del archivo.

Program ejercicio2;
const 
    numMenor = 15000;
type
    archivo_numeros: file of integer;
var
    numeros: archivo_numeros;
    archivo: string[20];
    numActual: integer;
    cantMenores: integer;
    cantTotal: integer;
    promedio: real;
begin
    writeln("Ingrese el nombre del archivo a procesar:");
    readln(archivo);
    assign(numeros, archivo);
    reset(numeros);
    cantMenores:= 0;
    cantTotal:= 0;
    promedio:= 0;
    while(not eof(numeros)) do begin
        read(numeros, numActual);
        if(numActual < numMenor) then cantMenores:= cantMenores + 1;
        promedio:= promedio + numActual;
        cantTotal:= cantTotal + 1;
        write(numActual);
    end;
    promedio:= promedio / cantTotal;
    close(numeros);
end.
