/* 
Escriba un programa que defina una matriz de enteros de tamaño 5x5. Inicialice
la matriz con números aleatorios entre 0 y 30.
Luego realice las siguientes operaciones:
- Mostrar el contenido de la matriz en consola.
- Calcular e informar la suma de los elementos de la fila 1
- Generar un vector de 5 posiciones donde cada posición j contiene la suma
de los elementos de la columna j de la matriz. Luego, imprima el vector.
- Leer un valor entero e indicar si se encuentra o no en la matriz. En caso de
encontrarse indique su ubicación (fila y columna) en caso contrario
imprima “No se encontró el elemento”. 
*/

package javaapplication2;

import PaqueteLectura.Lector;
import PaqueteLectura.GeneradorAleatorio;

public class JavaApplication2 {
   
    public static void main(String[] args) {
   
        int [][] matriz = new int[5][5];
        int [] vector = new int[5];
       
        for(int i=0; i<5; i++) {
            for(int j=0; j<5; j++) {
                matriz[i][j] = GeneradorAleatorio.generarInt(31);
            }
        }
       
        for(int i=0; i<5; i++)
            for (int j=0; j<5; j++)
                System.out.println("Numero generado en la posicio " + i + "," + j + "= " + matriz[i][j]);
   
        int sumaFila1 = 0;
        for (int j=0; j<5; j++)
            sumaFila1 += matriz[1][j];
       
        System.out.println("La suma de los elementos de la matriz en la fila 1 es: " + sumaFila1);
       
        for(int j=0; j<5; j++){
            int sumaCol=0;
            for(int i=0; i<5; i++){
                sumaCol += matriz[i][j];
            }
            vector[j] = sumaCol;
        }
       
        for(int j=0; j<5; j++)
            System.out.println("Elemento posicion " + j + " contiene la suma total: " + vector[j]);
       
        System.out.println("Ingrese un numero entero");
        int numIngresado = Lector.leerInt();
        int posI = 0;
        int posJ = 0;
        int posicionI = -1;
        int posicionJ = -1;
        boolean encontrado = false;
        while(posI < 5 && !encontrado){
            posJ = 0;
            while(posJ < 5  && !encontrado) {
                if(numIngresado == matriz[posI][posJ]){
                    posicionI = posI;
                    posicionJ = posJ;
                    encontrado = true;
                }
                else
                    posJ += 1;
            }
            posI += 1;
        }
       
        if(encontrado == true) System.out.println("Elemento encontrado posicion: " + posicionI + "," + posicionJ);
        else System.out.println("Elemento NO encontrado");
    }
}