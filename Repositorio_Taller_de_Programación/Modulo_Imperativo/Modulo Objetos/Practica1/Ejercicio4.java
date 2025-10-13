/*
Un edificio de oficinas está conformado por 8 pisos (1..8) y 4 oficinas por piso
(1..4). Realice un programa que permita informar la cantidad de personas que
concurrieron a cada oficina de cada piso. Para esto, simule la llegada de personas al
edificio de la siguiente manera: a cada persona se le pide el nro. de piso y nro. de
oficina a la cual quiere concurrir. La llegada de personas finaliza al indicar un nro.
de piso 9. Al finalizar la llegada de personas, informe lo pedido
package practica1_ejercicio3;
*/

import PaqueteLectura.GeneradorAleatorio;

public class Practica1_Ejercicio3 {

    public static void main(String[] args) {
       
        GeneradorAleatorio.iniciar();
       
        int [][] matrizOficinas = new int[4][8];
        int numPiso;
        int numOficina;
       
        for(int i=0; i<4; i++){
            for(int j=0; j<8; j++){
                matrizOficinas[i][j] = 0;
            }
        }
       
        numPiso = GeneradorAleatorio.generarInt(10);
        while(numPiso != 9){
            System.out.println("Num piso: " + numPiso);
            if (numPiso >= 1 && numPiso <= 8) {
                numOficina = GeneradorAleatorio.generarInt(5);
                System.out.println("Num ofi: " + numOficina);
                if (numOficina >= 1 && numOficina <= 4) {
                matrizOficinas[numOficina-1][numPiso-1] ++;
                }
            }
            numPiso = GeneradorAleatorio.generarInt(10);
        }
       
        for(int i=0; i<4; i++){
            for(int j=0; j<8; j++){
                System.out.println("Cantidad de personas en piso " + (j+1) + " en la oficina " + (i+1) + " es de: " + matrizOficinas[i][j]);
            }
        }
       
    }
   
}