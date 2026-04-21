Algoritmo SimulacionWorstFit
    // simulacion de administracion de memoria con worst-fit
    // memoria total: 600 unidades
    
    Definir max_procesos Como Entero
    max_procesos <- 20
    
    Definir inicio_bloque, tamanio_bloque, estado_bloque, id_proceso_bloque Como Entero
    Dimension inicio_bloque[max_procesos], tamanio_bloque[max_procesos]
    Dimension estado_bloque[max_procesos], id_proceso_bloque[max_procesos]
    //estado_bloque: 0 = libre, 1 = ocupado
    
    Definir num_bloques Como Entero
    Definir opcion, salir Como Entero
    Definir id_proceso, tamanio_proceso, encontrado, i, j, mejor_idx, mejor_tamanio Como Entero
    
    num_bloques <- 1
    inicio_bloque[1] <- 0
    tamanio_bloque[1] <- 600
    estado_bloque[1] <- 0
    id_proceso_bloque[1] <- 0
    
    salir <- 0
    
    Escribir "  SIMULADOR DE MEMORIA: ALGORITMO WORST-FIT"
    Escribir "  Memoria total: 600 unidades"
    Escribir "  Worst-Fit: elige el bloque libre mas grande disponible"
    
    Repetir
        Escribir ""
        Escribir "-*-*-*-*-*-*-*-*- MENU PRINCIPAL -*-*-*-*-*-*-*-*-"
        Escribir "1. Mostrar estado actual de la memoria"
        Escribir "2. Cargar nuevo proceso (Worst-Fit)"
        Escribir "3. Liberar proceso"
        Escribir "4. Compactar memoria"
        Escribir "5. Salir"
        Escribir "-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-"
        Escribir Sin Saltar "Seleccione una opcion: "
        Leer opcion
        
        Segun opcion Hacer
            Caso 1:
                Escribir ""
                Escribir "-*-*- ESTADO ACTUAL DE LA MEMORIA -*-*-"
                Escribir "Inicio  Tamaño  Estado    Proceso"
                Escribir "------  ------  ------    -------"
                Para i <- 1 Hasta num_bloques Hacer
                    Si estado_bloque[i] = 0 Entonces
                        Escribir inicio_bloque[i], "      ", tamanio_bloque[i], "     Libre       ---"
                    Sino
                        Escribir inicio_bloque[i], "      ", tamanio_bloque[i], "     Ocupado    P", id_proceso_bloque[i]
                    FinSi
                FinPara
                Escribir "-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-"
                
            Caso 2:
                //cargar nuevo proceso usando algoritmo worst-fit
                Escribir Sin Saltar "Ingrese ID del proceso (entero): "
                Leer id_proceso
                Escribir Sin Saltar "Ingrese tamaño del proceso: "
                Leer tamanio_proceso
                
                //inicializar variables para la busqueda worst-fit
                mejor_idx <- -1
                mejor_tamanio <- -1  //max para worstfit
                
                Para i <- 1 Hasta num_bloques Hacer
                    Si estado_bloque[i] = 0 Y tamanio_bloque[i] >= tamanio_proceso Entonces
                        Si tamanio_bloque[i] > mejor_tamanio Entonces  //buscar el mas grande
                            mejor_tamanio <- tamanio_bloque[i]
                            mejor_idx <- i
                        FinSi
                    FinSi
                FinPara
                
                Si mejor_idx = -1 Entonces
                    Escribir "ERROR: No hay suficiente espacio contiguo para el proceso P", id_proceso
                    Escribir "Intente compactar la memoria primero."
                Sino
                    //asignar el proceso en el bloque mas grande encontrado
                    Escribir "Worst-Fit: bloque seleccionado de ", mejor_tamanio, " unidades en posicion ", inicio_bloque[mejor_idx]
                    
                    Si tamanio_bloque[mejor_idx] = tamanio_proceso Entonces
                        //el bloque queda exactamente lleno, sin residuo
                        estado_bloque[mejor_idx] <- 1
                        id_proceso_bloque[mejor_idx] <- id_proceso
                        Escribir "Proceso P", id_proceso, " asignado exactamente en el bloque [", inicio_bloque[mejor_idx], "]"
                    Sino
                        // desplazar bloques hacia la derecha para insertar el nuevo bloque residual
                        Para j <- num_bloques Hasta mejor_idx+1 Con Paso -1 Hacer
                            inicio_bloque[j+1] <- inicio_bloque[j]
                            tamanio_bloque[j+1] <- tamanio_bloque[j]
                            estado_bloque[j+1] <- estado_bloque[j]
                            id_proceso_bloque[j+1] <- id_proceso_bloque[j]
                        FinPara
                        
                        //modificar el bloque original para que sea el ocupado
                        tamanio_bloque[mejor_idx] <- tamanio_proceso
                        estado_bloque[mejor_idx] <- 1
                        id_proceso_bloque[mejor_idx] <- id_proceso
                        
                        //crear el nuevo bloque libre residual (a la derecha del ocupado)
                        inicio_bloque[mejor_idx+1] <- inicio_bloque[mejor_idx] + tamanio_proceso
                        tamanio_bloque[mejor_idx+1] <- mejor_tamanio - tamanio_proceso
                        estado_bloque[mejor_idx+1] <- 0
                        id_proceso_bloque[mejor_idx+1] <- 0
                        
                        num_bloques <- num_bloques + 1
                        Escribir "Proceso P", id_proceso, " asignado en [", inicio_bloque[mejor_idx], "]"
                        Escribir "Bloque residual libre de ", tamanio_bloque[mejor_idx+1], " unidades en [", inicio_bloque[mejor_idx+1], "]"
                    FinSi
                    Escribir "Asignacion exitosa usando Worst-Fit."
                FinSi
                
            Caso 3:
                //liberar un proceso de memoria
                Escribir Sin Saltar "Ingrese ID del proceso a liberar: "
                Leer id_proceso
                encontrado <- 0
                
                Para i <- 1 Hasta num_bloques Hacer
                    Si estado_bloque[i] = 1 Y id_proceso_bloque[i] = id_proceso Entonces
                        estado_bloque[i] <- 0
                        id_proceso_bloque[i] <- 0
                        encontrado <- 1
                        Escribir "Proceso P", id_proceso, " liberado del bloque en [", inicio_bloque[i], "]"
                        
                        //fusionar con bloque libre siguiente si existe
                        Si i < num_bloques Y estado_bloque[i+1] = 0 Entonces
                            tamanio_bloque[i] <- tamanio_bloque[i] + tamanio_bloque[i+1]
                            // desplazar bloques hacia la izquierda
                            Para j <- i+1 Hasta num_bloques-1 Hacer
                                inicio_bloque[j] <- inicio_bloque[j+1]
                                tamanio_bloque[j] <- tamanio_bloque[j+1]
                                estado_bloque[j] <- estado_bloque[j+1]
                                id_proceso_bloque[j] <- id_proceso_bloque[j+1]
                            FinPara
                            num_bloques <- num_bloques - 1
                            Escribir "  -> fusionado con bloque libre adyacente de la derecha"
                            //ajustar indice porque se elimino un bloque
                            i <- i - 1
                        FinSi
                        
                        //fusionar con bloque libre anterior si existe
                        Si i > 1 Y estado_bloque[i-1] = 0 Entonces
                            tamanio_bloque[i-1] <- tamanio_bloque[i-1] + tamanio_bloque[i]
                            // desplazar bloques hacia la izquierda
                            Para j <- i Hasta num_bloques-1 Hacer
                                inicio_bloque[j] <- inicio_bloque[j+1]
                                tamanio_bloque[j] <- tamanio_bloque[j+1]
                                estado_bloque[j] <- estado_bloque[j+1]
                                id_proceso_bloque[j] <- id_proceso_bloque[j+1]
                            FinPara
                            num_bloques <- num_bloques - 1
                            Escribir "  -> fusionado con bloque libre adyacente de la izquierda"
                        FinSi
                        
                        i <- num_bloques
                    FinSi
                FinPara
                
                Si encontrado = 0 Entonces
                    Escribir "ERROR: No se encontro el proceso P", id_proceso, " en memoria."
                FinSi
                
            Caso 4:
                // compactar memoria: mover todos los bloques ocupados al inicio
                Escribir "Iniciando compactacion de memoria..."
                
                Definir nuevo_inicio Como Entero
                Definir temp_inicio, temp_tamanio, temp_estado, temp_id Como Entero
                Dimension temp_inicio[max_procesos], temp_tamanio[max_procesos]
                Dimension temp_estado[max_procesos], temp_id[max_procesos]
                
                nuevo_inicio <- 0
                Definir num_temp Como Entero
                num_temp <- 0
                
                //copiar todos los bloques ocupados en orden
                Para i <- 1 Hasta num_bloques Hacer
                    Si estado_bloque[i] = 1 Entonces
                        num_temp <- num_temp + 1
                        temp_inicio[num_temp] <- nuevo_inicio
                        temp_tamanio[num_temp] <- tamanio_bloque[i]
                        temp_estado[num_temp] <- 1
                        temp_id[num_temp] <- id_proceso_bloque[i]
                        nuevo_inicio <- nuevo_inicio + tamanio_bloque[i]
                    FinSi
                FinPara
                
                //agregar un unico bloque libre al final
                num_temp <- num_temp + 1
                temp_inicio[num_temp] <- nuevo_inicio
                temp_tamanio[num_temp] <- 600 - nuevo_inicio
                temp_estado[num_temp] <- 0
                temp_id[num_temp] <- 0
                
                //reemplazar la lista original con la compactada
                num_bloques <- num_temp
                Para i <- 1 Hasta num_bloques Hacer
                    inicio_bloque[i] <- temp_inicio[i]
                    tamanio_bloque[i] <- temp_tamanio[i]
                    estado_bloque[i] <- temp_estado[i]
                    id_proceso_bloque[i] <- temp_id[i]
                FinPara
                
                Escribir "Compactacion completada."
                Escribir "Memoria libre contigua al final: ", 600 - nuevo_inicio, " unidades."
                Escribir "Fragmentacion externa eliminada completamente."
                
            Caso 5:
                salir <- 1
                Escribir "Saliendo del simulador..."
                Escribir "-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-"
                
            De Otro Modo:
                Escribir "Opcion no valida. Intente de nuevo."
        FinSegun
        
    Hasta Que salir = 1
    
FinAlgoritmo
