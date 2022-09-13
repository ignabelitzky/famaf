	.text
	.org 0x0000
    // Los registros vienen inicializados de x0 a x30 con el valor de sus indices
	add x5, x30, x30 // x5 = x30 + x30 = 30 + 30 = 60
	add x5, x5, x4 // x5 = x5 + x4 = 60 + 4 = 64 // x5 será el contador de posiciones
	sub x2, x2, x2 // x2 = x2 - x2 = 2 - 2 = 0
loop:
	stur x2, [x0, #0] // carga el valor de x2 en la direccion de mem apuntada por x0 + 0 = en la address 0 guardará 0
						// es decir, la memoria en la posición 0 queda con el valor 0
	add x0, x0, x8 // x0 = 0 + 8 = 8 para pasar a la siguiente posicion de memoria
	sub x5, x5, x1 // x5 = x5 - x1 = 64 - 1 = 63 // decremento el contador pq ya avancé a la siguiente posicion de mem
	add x2, x2, x1 // x2 = x2 + x1 = 0 + 1 = 1 // aumento para la inicializacion
	cbz x5, exitloop // Se ejecutará 64 veces hasta q x5 llegue a 0 y termina el programa
	cbz xzr, loop
exitloop: 
	cbz XZR, exitloop	
