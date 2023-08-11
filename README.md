# LinuxTips
Este no será un post como otro cualquiera, os voy a dar un par de truquicos por si eres nuevo en los entornos de linux y vienes de estar toda tu vida con Windows. Seguro que hay alguien que se esta pensando pasarse a un linux nativo (como sistema operativo principal) pues esta es tu señal, si yo pude, tu también.

Yo tendre como distro a Parrot Security Edition, ya que me resulta más fácil tener todas las herramientas instaladas por defecto, dicho esto, espero que os guste mucho y empecemos!!!

## Doble Pantalla
Al pasarse a nativo el primer error que te vas a encontrar va a ser que no detecta bien las pantallas extenernas (si usas portatil) o pantallas extras que pongas con ordenador de mesa, esto sirve principalmente para 2 pantallas, pero también lo puedes aplicar con 3 o las que quieras.

Usaremos todo el rato el comando ``xrandr``, comenzaremos viendo que pantallas nos esta detectando el sistema, para esto usaremos: ``xrandr --listactivemonitors``

![image](https://github.com/Llo0zy/LinuxTips/assets/108870244/ece6c062-2bde-4324-862b-dbd789822241)

Aquí observamos que tenemos como pantalla principal la interna (eDP-1) y como secundaria la externa (HMDI-1)

Una vez que tenemos la lista de las pantallas activas podemos indicar cual queremos que sea la principal, con el comando: ``xrandr --output eDP-1 --primary``

![image](https://github.com/Llo0zy/LinuxTips/assets/108870244/fe410f9b-6182-4b26-a493-1027ddf4c147)

También podemos cambiar las posiciones de las pantallas, imaginate que tu tienes tu pantalla principal en la izquierda y la secundaria en la derecha, pero el sistema te lo detecta al reves, perfectamente podemos usar el comando: ``xrandr --output eDP-1 --left-of HDMI-1``, tanto left como right, bottom o top, podmeos usar para cambiar el orden de las pantallas, como vemos tampoco es algo muy complicado.

Otra opción menos común, son las pantallas verticales, aquí os dejo un comando para poder rotar la orientación de la pantalla y que la resolución se adapte mejor: ``randr --output HDMI-1 --rotate left``, como en otros comando puede ser: left, right, bottom, top y para dejarla por defecto ponemos: normal

Quiero añadir que si estas usando la polybar en los archivos: ``~/.config/polybar/current.ini`` y ``~/.config/polybar/workspace.ini`` tienen el argumento **monitor=** que suele estar vacio o con la variable: ``${env:PRIMARY_MONITOR}``, podemos añadir los nombres de las pantallas (también llamados: IDs).
