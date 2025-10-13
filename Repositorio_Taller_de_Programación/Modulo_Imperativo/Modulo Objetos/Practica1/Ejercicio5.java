/*
El dueño de un restaurante entrevista a cinco clientes y les pide que califiquen
(con puntaje de 1 a 10) los siguientes aspectos: (0) Atención al cliente (1) Calidad
de la comida (2) Precio (3) Ambiente.
Escriba un programa que lea desde teclado las calificaciones de los cinco clientes
para cada uno de los aspectos y almacene la información en una estructura. Luego
imprima la calificación promedio obtenida por cada aspecto.
*/

package practica1_ejercicio5;

import PaqueteLectura.Lector;

public class Practica1_Ejercicio5 {

    public static void main(String[] args) {
       
        int [][] matrizCalificacion = new int [5][4];
       
        int cal;
        for(int i=0; i<5; i++){
            System.out.println("Calificaciones del cliente " + i);
            for(int j=0; j<4; j++){
                System.out.println("Ingrese su calificacion");
                cal = Lector.leerInt();
                if(cal >=1 && cal<=10){
                    matrizCalificacion[i][j] = cal;
                }
                else {
                    System.out.println("Por favor ingrese un valor entre 1 y 10");
                    cal = Lector.leerInt();
                    matrizCalificacion[i][j] = cal;
                }
            }
            System.out.println("----------");
        }
       
        for(int i=0; i<5; i++){
            System.out.println("Calificaciones del cliente " + i);
            for(int j=0; j<4; j++){
                System.out.println("Aspecto " + j + " es: " + matrizCalificacion[i][j]);
            }
        }
       
    }
   
}