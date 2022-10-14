	.text
	.org 0x0000
    // ejercicio 2a
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
	cbz x5, suma // Se ejecutará 64 veces hasta q x5 llegue a 0 y termina el programa
	cbz xzr, loop

    // N = 9 y resultado guardamos en 10
suma:
    add x10, x1, x9   // X10 = 10 numero de iteraciones
    add x11, xzr, xzr   // X11 = 0 guarda la suma
    add x0, xzr, xzr    // x0 = 0   a que lugar de mem accedemos

loop2:
    ldur x12, [x0, #0]
    add x11, x11, x12
    sub x10, x10, x1
    add x0, x0, x8
    cbz x10, exit
    cbz xzr, loop2

exit:
    stur x11, [x0, #0]
    cbz xzr, infiniteloop

infiniteloop:
    cbz xzr, infiniteloop
	



    /* Ejercicio 2b)
    add X30, X0, X29    // X30 inicializo con valor 29
loop:
    sub X29, X29, X1    // Resto de a uno
    add X30, X30, X29   // Actualizo la sumatoria 28 + 27 + 26...
    cbz X29, L1         // Corto el bucle si llego a 0
    cbz XZR, loop       // Entro de nuevo al bucle porque no llegue a 0

L1:
    stur X30, [X0, #240]  // Guardo la sumatoria de los N registros en posicion N+1

exitloop:
    cbz XZR, exitloop   // Loop infinito

    // Ejercicio 2c)
    add X2, X0, X0
    
loop:
    add X2, X2, X17
    sub X16, X16, X1
    cbz X16, L1
    cbz XZR, loop
L1:
    stur X2, [X0, #0]
exitloop:
    cbz XZR, exitloop
    */
