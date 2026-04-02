1. Realizar un algoritmo que cree un archivo binario de números enteros no ordenados y permita
incorporar datos al archivo. Los números son ingresados desde el teclado. La carga finaliza
cuando se ingresa el número 30000, que no debe incorporarse al archivo. El nombre del archivo
debe ser proporcionado por el usuario desde el teclado.

Program ejercicio1;
const
    limiteNum = 3000;
type
    archivo_numeros = file of integer;
var
    numeros: archivo_numeros;
    nombre_fisico: string[20];
    num: integer;
begin
    writeln("Ingrese el nombre del archivo");
    readln(nombre_fisico);
    assign(numeros, nombre_fisico);
    rewrite(numeros);
    writeln("Ingrese un numero");
    readln(num);
    while(num <> limiteNum) do begin
        write(numeros, num);
        writeln("Ingrese otro numero");
        readln(num);
    end;
    close(numeros);
end.