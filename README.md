# LinuxTips
Este no será un post como cualquier otro. Voy a darte un par de truquitos por si eres nuevo en los entornos de Linux y vienes de estar toda tu vida con Windows. Seguro que hay alguien que está pensando en pasarse a un Linux nativo (como sistema operativo principal). Pues esta es tu señal; si yo pude, tú también.

Yo utilizaré Parrot Security Edition como mi distribución (distro), ya que me resulta más fácil tener todas las herramientas instaladas por defecto. Dicho esto, ¡espero que os guste mucho y empecemos!


## Doble Pantalla
Al pasarte a nativo, el primer problema que enfrentarás será que no detecta bien las pantallas externas (si usas un portátil) o las pantallas adicionales que conectes a una computadora de escritorio. Esto se aplica principalmente a 2 pantallas, pero también se puede aplicar a 3 o las que quieras.

Utilizaremos el comando **xrandr** todo el tiempo. Comenzaremos viendo qué pantallas nos está detectando el sistema. Para esto, usaremos: `xrandr --listactivemonitors`

![image](https://github.com/Llo0zy/LinuxTips/assets/108870244/ece6c062-2bde-4324-862b-dbd789822241)

Aquí observamos que tenemos la pantalla interna (eDP-1) como principal y la pantalla externa (HDMI-1) como secundaria.

Una vez que tenemos la lista de pantallas activas, podemos indicar cuál queremos que sea la principal con el comando:`xrandr --output eDP-1 --primary`

![image](https://github.com/Llo0zy/LinuxTips/assets/108870244/fe410f9b-6182-4b26-a493-1027ddf4c147)

También podemos cambiar las posiciones de las pantallas. Imagina que tienes tu pantalla principal a la izquierda y la secundaria a la derecha, pero el sistema lo detecta al revés. Perfectamente podemos usar el comando: `xrandr --output eDP-1 --left-of HDMI-1`. Tanto left como right, bottom o top, podemos usar para cambiar el orden de las pantallas. Como ves, tampoco es algo muy complicado.

Otra opción menos común, son las pantallas verticales, aquí os dejo un comando para poder rotar la orientación de la pantalla y que la resolución se adapte mejor: ``randr --output HDMI-1 --rotate left``, como en otros comando puede ser: left, right, bottom, top y para dejarla por defecto ponemos: normal

Quiero añadir que si estas usando la polybar en los archivos: ``~/.config/polybar/current.ini`` y ``~/.config/polybar/workspace.ini`` tienen el argumento **monitor=** que suele estar vacio o con la variable: ``${env:PRIMARY_MONITOR}``, podemos añadir los nombres de las pantallas (también llamados: IDs).



## Cambiar el DPI de tu ratón
Soy una de esas personas muy quisquillosas cuando se trata de la sensibilidad de mi ratón. Por eso, me parece muy importante saber cómo cambiar el DPI de tu ratón mediante la terminal. Al igual que con las pantallas, primero tendremos que listar qué es lo que detecta el sistema con el comando ``xinput list``. Lo podemos ver aquí:

![image](https://github.com/Llo0zy/LinuxTips/assets/108870244/5d3239c3-3acf-41db-9b24-62fed953bd16)

Como podemos ver a mi me detecta tanto mi raton inalambrico (Marcando con un rectangulo rojo) y mi touchpad (**id=16**), estoy se identifican con las ids, que también usaremos para modificar el DPI, una vez que sabemos que **ID** tiene nuestro ratón, en mi caso **id=14**, podemos proceder a cambiar el DPI (cabe recalcar que este cambio solo afectara a la sesión activa, es decir, si apagamos y volvemos a encender el DPI se reiniciara, por eso os recomiendo saber como ejecutar comandos automaticamente al iniciar el sistema).

Con el comando: ```xinput --set-prop 14 "Coordinate Transformation Matrix" 0.5 0 0 0 0.5 0  0 0 1``` podemos disminuir la velocidad del ratón, esto lo tienes que ir probando tu mismo, pero con >1 disminuimos y con <1 aumentamos la velocidad.


## Shortcuts
Una ventaja que tiene linux sobre windows es que puedes poner atajos de teclado para todo y esto es gracias a: **sxhkd**, no os preocupeis por el nombre os ireis acostumbrando :), el caso al instalar esta herramienta se nos creara un archivo en la ruta: ``~/.config/sxhkd/sxhkdrc``, aqui os saldra varias por defecto, yo os dejare un par que me han servido muchísimo.

##### Base para los shortcuts
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

#### Abrir terminal
```
super + Return
  /opt/kitty/bin/kitty
```

#### Tomar captura de pantalla
Para esto necesitareis **flameshot**, para ello instalaremos el paquete: ``sudo apt install flameshot``
```
super + shift + s # El mismo comando que usamos en windows
  flameshot gui 
```

#### Abrir Obsidian
```
super + shift + o
  obsidian
```

#### Abrir Google Chrome
```
super + shift + g
  google-chrome-stable
```

#### Centrarse en una aplicacion
```
super + g
  bspc node -s biggest.window
```



## Ejecutar comandos al inciar la terminal
Para esto tendremos que ir al archivo de configuración de nuestro usuario, esto lo podemos ver con: ``echo $SHELL``, en mi caso estoy usando una szh si nos vamos a ``cd ~ o cd`` y ejecutamos un ``ls -a `` podemos encontrar el nombre de nuestra terminal:

![image](https://github.com/Llo0zy/LinuxTips/assets/108870244/8db25c4b-9347-4e59-9ade-dda8fe254aba)

En este archivo podremos ejecutar comandos como si fuera una terminal normal y corriente, y cada vez que abramos una terminal, da igua que sea una ventana o una partición se ejecutara todos los comandos que escribas en este archivo.
Aquí también puedes meter funciones para agilizar tu proceso, yo os dejo una función que uso todos los dias al iniciar mi terminal:
```
function upgrade(){
    sudo apt update && parrot-upgrade -y && sudo apt --fix-broken  install
}
```

Ahora al poner **upgrade** se updateara el sistema, usara el comando **parrot-upgrade** (al usar parrot si uso simplemente **apt upgrade** puedo estropear el sistema) y **apt --fix-broken install**.

## Ejecutar comandos al inciar el sistema
uiero aclarar que no recomiendo esto, ya que no estoy seguro de si hay mejores formas de hacerlo o no. Pero esta es tu elección. En los archivos de configuración de **bspwm**, que se ejecutan al encender el ordenador, se pueden modificar y agregar los comandos que desees ejecutar, como en el archivo **.zshrc**, pero sin abrir la terminal.

Este archivo se encuentra en la ruta: `~/.config/bspwm/`, con el nombre: `bspwmrc`. En mi caso, en la primera línea del archivo ejecutable, suelo configurar las salidas, desplazamientos de las pantallas y algunas aplicaciones. El procedimiento es similar al apartado anterior, solo que cambiando el archivo.

## Sincronizar el horario
Si eres despistado, y en la instalación de tu linux has olvidado o te has equivocado cual es tu horario yo traigo tu segunda oportunidad.
Con el comando: `sudo ntpdate 0.es.poll.ntp.org` puedes conectarte al servidor que te proporcionará el horario de España, si quereis hacerlo manual también teneís el comando: 
`sudo date -s "año-mes-dia hora:minutos:segundos`

Aquí os dejo un listado con los servidores más famosos para sincronizar tu horario.

-América del Norte:
  0.north-america.pool.ntp.org
  1.north-america.pool.ntp.org
  2.north-america.pool.ntp.org
  3.north-america.pool.ntp.org
  
-Europa:
  0.europe.pool.ntp.org
  1.europe.pool.ntp.org
  2.europe.pool.ntp.org
  3.europe.pool.ntp.org

-Asia:
  0.asia.pool.ntp.org
  1.asia.pool.ntp.org
  2.asia.pool.ntp.org
  3.asia.pool.ntp.org
  
-Oceanía:
  0.oceania.pool.ntp.org
  1.oceania.pool.ntp.org
  2.oceania.pool.ntp.org
  3.oceania.pool.ntp.org

-Sudamérica:
  0.south-america.pool.ntp.org
  1.south-america.pool.ntp.org
  2.south-america.pool.ntp.org
  3.south-america.pool.ntp.org

PD: Podeís poner el acronímo de tu país, por ejemplo: españa -> es o rusia -> ru :)

## Subir y bajar el volumen
Seguramente os pase como a mi, y las teclas de manipulación del volumen esten desconfiguradas por eso os quiero dejar un par de scripts que he hecho en bash para poder subir y bajar el volumen todo sin problemas, lo dejare colgado en el repositorio para no ocupar mucho este archivo. :)

Aun asi, hay que añadir estas lineas de código en el archivo de configuración de la sxhkd:
```
#############################
# Volume/Brightness Changer #
#############################

# Volume up
F3
    /home/**tu_user**/.config/bin/volume_up.sh


# Volume up
F2
    /home/**tu_user**/.config/bin/volume_down.sh

# Toggle volume on/off
F1
    /home/**tu_user**/.config/bin/toggle_mute.sh
```

## Subir y bajar el brillo
Esto estará dentro de poco...
<hr>

Espero que esta pequeña guía te haya sido útil. La iré ampliando a medida que recuerde nuevos trucos de Linux que puedan ser útiles. ¡Muchas gracias!
