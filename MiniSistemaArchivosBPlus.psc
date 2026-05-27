Proceso MiniSistemaArchivosBPlus
	
    Definir archivos Como Cadena
    Dimension archivos[20]
	
    Definir opcion Como Entero
    Definir total Como Entero
    Definir i Como Entero
    Definir archivoBuscado Como Cadena
    Definir encontrado Como Logico
	
    total <- 0
	
    Escribir "===================================="
    Escribir " MINI SISTEMA DE ARCHIVOS B+ "
    Escribir "===================================="
	
    Repetir
		
        Escribir ""
        Escribir "1. Insertar archivo"
        Escribir "2. Buscar archivo"
        Escribir "3. Mostrar nodo actual"
        Escribir "4. Salir"
        Escribir "Seleccione una opcion:"
        Leer opcion
		
        Segun opcion Hacer
			
				// ==================================
				// INSERTAR ARCHIVO
				// ==================================
			
            1:
				
                Si total < 20 Entonces
					
                    total <- total + 1
					
                    Escribir ""
                    Escribir "Ingrese nombre del archivo:"
                    Leer archivos[total]
					
                    Escribir ""
                    Escribir "Archivo insertado correctamente."
					
                    // ==========================
                    // VERIFICACION DE OVERFLOW
                    // ==========================
					
                    Si total > 3 Entonces
						
                        Escribir ""
                        Escribir "*** OVERFLOW DETECTADO ***"
                        Escribir "Nodo excede el limite de claves."
						
                        Escribir ""
                        Escribir "Aplicando SPLIT..."
                        Escribir "Dividiendo nodo..."
                        Escribir "Promoviendo clave indice..."
                        Escribir "Reorganizando arbol B+..."
						
                    FinSi
					
                Sino
					
                    Escribir "Memoria llena."
					
                FinSi
				
				// ==================================
				// BUSCAR ARCHIVO
				// ==================================
				
            2:
				
                Si total = 0 Entonces
					
                    Escribir ""
                    Escribir "El arbol esta vacio."
					
                Sino
					
                    encontrado <- Falso
					
                    Escribir ""
                    Escribir "Ingrese archivo a buscar:"
                    Leer archivoBuscado
					
                    Para i <- 1 Hasta total Hacer
						
                        Si archivos[i] = archivoBuscado Entonces
							
                            encontrado <- Verdadero
							
                        FinSi
						
                    FinPara
					
                    Si encontrado Entonces
						
                        Escribir ""
                        Escribir "Archivo encontrado."
						
                    Sino
						
                        Escribir ""
                        Escribir "Archivo no encontrado."
						
                    FinSi
					
                FinSi
				
				// ==================================
				// MOSTRAR CONTENIDO DEL NODO
				// ==================================
				
            3:
				
                Si total = 0 Entonces
					
                    Escribir ""
                    Escribir "No existen archivos registrados."
					
                Sino
					
                    Escribir ""
                    Escribir "===== CONTENIDO DEL NODO ====="
					
                    Para i <- 1 Hasta total Hacer
						
                        Escribir "- ", archivos[i]
						
                    FinPara
					
                    Escribir "================================"
					
                    // ==========================
                    // SIMULACION VISUAL B+
                    // ==========================
					
                    Si total <= 3 Entonces
						
						Escribir ""
						Escribir "Estado del arbol:"
						
						Para i <- 1 Hasta total Hacer
							
							Escribir "[ ", archivos[i], " ]"
							
						FinPara
						
                        Escribir "]"
						
                    Sino
						
                        Escribir ""
                        Escribir "Estado conceptual del arbol B+:"
						
                        Escribir ""
                        Escribir "          [ INDICE ]"
						
                        Escribir ""
                        Escribir "[ ", archivos[1], " | ", archivos[2], " ]"
						
                        Escribir "          |"
						
                        Escribir "[ ", archivos[3], " | ", archivos[4], " ]"
						
                    FinSi
					
                FinSi
				
				// ==================================
				// SALIR
				// ==================================
				
            4:
				
                Escribir ""
                Escribir "Finalizando simulacion..."
				
            De Otro Modo:
				
                Escribir ""
                Escribir "Opcion invalida."
				
        FinSegun
		
    Hasta Que opcion = 4
	
FinProceso