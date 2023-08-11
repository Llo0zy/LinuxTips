# LinuxTips
Este no será un post como otro cualquiera, os voy a dar un par de truquicos por si eres nuevo en los entornos de linux y vienes de estar toda tu vida con Windows. Seguro que hay alguien que se esta pensando pasarse a un linux nativo (como sistema operativo principal) pues esta es tu señal, si yo pude, tu también.

Yo tendre como distro a Parrot Security Edition, ya que me resulta más fácil tener todas las herramientas instaladas por defecto, dicho esto, espero que os guste mucho y empecemos!!!


## Doble Pantalla
Al pasarse a nativo el primer error que te vas a encontrar va a ser que no detecta bien las pantallas extenernas (si usas portatil) o pantallas extras que pongas con ordenador de mesa, esto sirve principalmente para 2 pantallas, pero también lo puedes aplicar con 3 o las que quieras.

Usaremos todo el rato el comando **xrandr**, comenzaremos viendo que pantallas nos esta detectando el sistema, para esto usaremos: ``xrandr --listactivemonitors``

![image](https://github.com/Llo0zy/LinuxTips/assets/108870244/ece6c062-2bde-4324-862b-dbd789822241)

Aquí observamos que tenemos como pantalla principal la interna (eDP-1) y como secundaria la externa (HMDI-1)

Una vez que tenemos la lista de las pantallas activas podemos indicar cual queremos que sea la principal, con el comando: ``xrandr --output eDP-1 --primary``

![image](https://github.com/Llo0zy/LinuxTips/assets/108870244/fe410f9b-6182-4b26-a493-1027ddf4c147)

También podemos cambiar las posiciones de las pantallas, imaginate que tu tienes tu pantalla principal en la izquierda y la secundaria en la derecha, pero el sistema te lo detecta al reves, perfectamente podemos usar el comando: ``xrandr --output eDP-1 --left-of HDMI-1``, tanto left como right, bottom o top, podmeos usar para cambiar el orden de las pantallas, como vemos tampoco es algo muy complicado.

Otra opción menos común, son las pantallas verticales, aquí os dejo un comando para poder rotar la orientación de la pantalla y que la resolución se adapte mejor: ``randr --output HDMI-1 --rotate left``, como en otros comando puede ser: left, right, bottom, top y para dejarla por defecto ponemos: normal

Quiero añadir que si estas usando la polybar en los archivos: ``~/.config/polybar/current.ini`` y ``~/.config/polybar/workspace.ini`` tienen el argumento **monitor=** que suele estar vacio o con la variable: ``${env:PRIMARY_MONITOR}``, podemos añadir los nombres de las pantallas (también llamados: IDs).



## Cambiar el DPI de tu ratón
Soy una de esas personas muy tiquismiquis cuando hablamos de la sensibilidad de mi ratón, por eso me parece muy importante saber cambiar el DPI de tu ratón mediante la terminal.
Como las pantallas, primero tendremos que listar que es lo que detecta el sistema, con el comando: ``xinput list`` lo podemos ver:

![image](https://github.com/Llo0zy/LinuxTips/assets/108870244/5d3239c3-3acf-41db-9b24-62fed953bd16)

Como podemos ver a mi me detecta tanto mi raton inalambrico (Marcando con un rectangulo rojo) y mi touchpad (**id=16**), estoy se identifican con las ids, que también usaremos para modificar el DPI, una vez que sabemos que **ID** tiene nuestro ratón, en mi caso **id=14**, podemos proceder a cambiar el DPI (cabe recalcar que este cambio solo afectara a la sesión activa, es decir, si apagamos y volvemos a encender el DPI se reiniciara, por eso os recomiendo saber como ejecutar comandos automaticamente al iniciar el sistema).

Con el comando: ```xinput --set-prop 14 "Coordinate Transformation Matrix" 0.5 0 0 0 0.5 0  0 0 1``` podemos disminuir la velocidad del ratón, esto lo tienes que ir probando tu mismo, pero con >1 disminuimos y con <1 aumentamos la velocidad.


## Shortcuts
Una ventaja que tiene linux sobre windows es que puedes poner atajos de teclado para todo y esto es gracias a: **sxhkd**, no os preocupeis por el nombre os ireis acostumbrando :), el caso al instalar esta herramienta se nos creara un archivo en la ruta: ``~/.config/sxhkd/sxhkdrc``, aqui os saldra varias por defecto, yo os dejare un par que me han servido muchísimo.

#### Base para los shortcuts
Os dejo tambien algunas referencias por si no estais acostumbrados:
- Return -> Enter
- super -> Tecla de Windows
- Shift -> Mayúsculas
- Ctrl -> Control
- Tab -> Tabulador (A la izquierda de la Q)
```
combinacion + del teclado
  /ruta/del/archivo o comando
```

### Abrir terminal
```
super + Return
  /opt/kitty/bin/kitty
```

### Tomar captura de pantalla
Para esto necesitareis **flameshot**, para ello instalaremos el paquete: ``sudo apt install flameshot``
```
super + shift + s # El mismo comando que usamos en windows
  flameshot gui 
```

### Abrir Obsidian
```
super + shift + o
  obsidian
```

### Abrir Google Chrome
```
super + shift + g
  google-chrome-stable
```

### Centrarse en una aplicacion
```
super + g
  bspc node -s biggest.window
```



## Ejecutar comandos al inciar la terminal
Esto sirve tanto como dice el titulo, ejecutar comando nada más al iniciar la terminal, tanto al inciar el sistema operativo.

Empezamos al incial la terminal, para esto tendremos que ir al archivo de configuración de nuestro usuario, esto lo podemos ver con: ``echo $SHELL``, en mi caso estoy usando una szh si nos vamos a ``cd ~ o cd`` y ejecutamos un ``ls -a `` podemos encontrar el nombre de nuestra terminal:

![image](https://github.com/Llo0zy/LinuxTips/assets/108870244/8db25c4b-9347-4e59-9ade-dda8fe254aba)

En este archivo podremos ejecutar comandos como si fuera una terminal normal y corriente, y cada vez que abramos una terminal, da igua que sea una ventana o una partición se ejecutara todos los comandos que escribas en este archivo.
Aquí también puedes meter funciones para agilizar tu proceso, yo os dejo una función que uso todos los dias al iniciar mi terminal:
```
function upgrade(){
    sudo apt update && parrot-upgrade -y && sudo apt --fix-broken  install
}
```

Ahora al poner **upgrade** se updateara el sistema, usara el comando **parrot-upgrade** (al usar parrot si uso simplemente **apt upgrade** puedo estropear el sistema) y **apt --fix-broken install**.
