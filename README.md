<p align="center"><img class="center" src ="https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/logos/logo.png"></p>

# RG350 firmware "Rogue" edition<br>
### An independent fork of the OpenDingux project, focused on improving the user experience. 

Thanks to Tonyjin for toolchain (https://github.com/tonyjih).
Special Thanks to Pcercuei (https://github.com/pcercuei), Mthuurne (https://github.com/mthuurne) and OpenDingux (https://github.com/OpenDingux) for the original code base system.

### instrucciones en español más abajo.

## Goals:
- [X] exFAT support, auto-resize internal sdcard, constant sdcard mount point, show version - 1.7.5 branch
- [X] Add Esoteric as an optional launcher - 1.7.9 branch
- [ ] Kernel update and Suspend capability - 2.x branch
- [ ] Modernize 3D APIs - 2.1.x
- [ ] HDMI support - 2.2.x

# update firmware 1.7.9.8: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.8

# update firmware 1.7.9.7: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.7

# update firmware 1.7.9.6: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.6

# update firmware 1.7.9.5: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.5

# update firmware 1.7.9.4: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.4

# update firmware 1.7.9.3: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.3

# update firmware 1.7.9.2 fix: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.2fix

# update firmware 1.7.9.2: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.9.2

# update firmware 1.7.9.1: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.9.1

# update firmware 1.7.9: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.9

# update firmware 1.7.8.2: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.8.2

# update firmware 1.7.8.1: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.8.1

# update firmware 1.7.8: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.8

# update firmware 1.7.7: <br>
https://drive.google.com/file/d/13iNEBQlbFkueCSAsnWpv8cVGKJv8ihpX/view

# update firmware 1.7.6: <br>
https://drive.google.com/file/d/1kMVWTWTym6TfN3_nrM9N2QSFf2dUxxjp/view

## Changelog:<br>

### 1.7.9.8:<br>

1. Add Rogue Update Manager (thanks to Rafa Vico).<br>
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/screenshots/screenshot013.png)
2. Fixed dpad-analog emulator.
3. Update linux-firmware package to the last version (16-03-2020)

### 1.7.9.7:<br>

1. Add ext2 suport.

### 1.7.9.6:<br>

1. Fixed button order in DinguxCommander.
2. Fixed buttons and colors in GCW-Connect and changed name to ROGUE Connect.
3. Added script to format the external sdcard as ext4.
4. kernel update for USB WiFi drivers.

### 1.7.9.5:<br>

1. Fixed and updated SDL2 libraries.
2. Insert Scriptrunner app, you can now format the external sdcard in fat32, exfat or ext3 in the console.
3. Fixed errors in games that won't run.
4. Fixed Gmenu2x duplicating icons upon editing.

### 1.7.9.4:<br>

1. Fixed the clocks hour resetting when the console is powered off.
2. Gmenu2x can now show two types of previews (put in /(romsdir)/.previews/).
3. RG350 test is now inside of the system, not in the opk.

### 1.7.9.3:<br>

1. updated the file system again, repartition and expander scripts.
2. Gmenu2x analog stick control is removed.
3. Better battery accuracy.
4. Stock clock app updated with a new redesign. Thanks to Rafa Vico (https://github.com/RafaVico).
5. Text editor opk buttons fixed. Thanks to Rafa Vico (https://github.com/RafaVico).

### 1.7.9.2 fix:<br>

Fixed the last library, ncurses 5 from the buildroot code (this is now ncurses 6.1 in the toolchain GitHub https://github.com/tonyjih/RG350_buildroot/commit/f167487b5a0450cebd99256400ded18734f2f25d and now old emulators might not work). This is necessary for some older emulators.

### 1.7.9.2:<br>

1. Optimized update opk script for the check and repair boot partition.
2. Fixed the flasher script, no more error segmentation fault, but now the flasher will take about 15 minutes, all is automized, so you don't need do anything.
3. Gmenu2x updated, you can now edit the opk icons, name, description and files filter.
4. Gmenu2x you can now turn the screen on and off with the power button, no more "ghost wakeups". Thanks to Rafa Vico (https://github.com/RafaVico).
5. RG350 test updated, you can now see the SD card's free space. Thanks to Rafa Vico (https://github.com/RafaVico).
6. Updated Esotoric to the lastest version. Thanks to Podulator (https://github.com/podulator/esoteric).

### 1.7.9.1:<br>

1. Optimized the first boot set partition and format file system, this no is rewrite anymore, only with flasher installation.
2. Optimized the file check at boot.
3. Optimized the flasher.
4. Gmenu2X now has a document reader (.txt). Thanks to Rafa Vico (https://github.com/RafaVico).
5. Gmenu2x will now show the percentage of the battery.
6. Gmenu2x can now change the CPU of the console between MAX and MIN freqencies to save battery (for example for GBC emulation).<br>
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/screenshots/cpucontrol1.png)
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/screenshots/cpucontrol2.png)
7. Optimized the kernel control in-screen Hz. Thanks to Pcercuei (https://boards.dingoonity.org/retro-game-350rg-350/screen-now-going-bad/msg191784/#msg191784).

### 1.7.9:<br>

1. Changed the boot logo (again), OpenDingux logo removed with respect to the original creator of the system.<br>
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/logo_rg350.jpg)
2. All references to OpenDingux have been removed, except in the system information as a thank you for the original software.<br>
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/system_info.png)
3. Gmenu2x can now read and write all from the home screen.
4. Esoteric added as an optional launcher for the system. Thanks to Podulator (https://github.com/podulator/esoteric).
5. Updated the RG350 tests app in sd_image. Thanks to Rafa Vico (https://github.com/RafaVico).
6. Now sd_image too in .opk file, you can now reflash the sdcard without open the console (note: this erases everything on the internal sdcard).
7. The update and flash .opk files now work in other launchers as well.


### 1.7.8.2:<br>

1. Changed the boot logo.<br>
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/logos/67d0e5b053de2d8c2d813fe0459d11a2o.jpg)
2. Renamed the firmware.
3. Updated some libraries.
4. Gmenu2x is now mounted in /local/home/.gmenu2x .

### 1.7.8.1:<br>
1. The boot partition is now mounted in /media/system in RW mode for recovering the system from a PC whenever possible.
2. Gmenu2x can now link .opk and .dge files.
3. New boot logo.
4. New SD card flash image. Thanks to the GCW Zero Image Generation Tools (https://github.com/gcwnow/imager).

### 1.7.8:<br>
1. lazy_itable_init = 0 and lazy_journal_init = 0 support added to EXT4 file system.
2. The firmware will now display versions in the System Info app.

![](https://fotos.subefotos.com/d74d4f1ba67f0d5f556aa7a43e7c7c84o.jpg)

### 1.7.7:<br>
1. exFAT support added - there is now no need to download a utility to format 64GB+ SD cards.
2. Default SD card mount changed to /media/sdcard - you don't have to re-do paths when swapping SD cards anymore.
3. Auto swap files and partition resize added - this takes a while, allow it to finish. The progress will be shown on screen during the first boot.
4. Duplicate modules have removed from modules.squashfs .
5. Fixed the resize process in old stock firmwares (Bad ext4 partition).
6. Fixed power off and reboot error messages.
7. Fixed slowdowns and stuttering during first 15 minutes after first boot.
8. Rebuilt mininit-syspart from original opendingux code. Thanks to OpenDingux's Mininit (https://github.com/OpenDingux/mininit).
9. Autoremove old system configs at the first boot.
10. Changed file system table.
11. Restored USB-HID support.
12. Updated libshake from the original code. (https://github.com/zear/libShake)


## Instructions:<br>
### NOTE: If is your first time installing this CFW, the file to use is sd_image.bin or flasher opk, afterwards you can use always use opk update files for future releases. Using the sd_image.bin or flasher opk erases all data on the sdcard!! If you're updating from another CFW you may want to make a backup of the folders local/home and local/app first to preserve emulators/apps, their settings, and your game saves. (It is recommended to always make backups!)

## Instructions for updating from an OPK update file (No need to open the console):
1. Place the update .opk file in /media/data/apps or /media/sdcard/apps.
2. Run the .opk from GMENU2X.
3. Allow the process to complete.
4. Reboot.
5. If the system fails to boot, press Y to boot to the last working kernel, or X to boot to the last working rootfs. X+Y will load your previous OS version.

## Instructions for a clean update / fix internal sdcard:<br>
## NOTE: This method erases the microSD, so backup of all your files beforehand as mentioned above.
1. Place the flasher .opk file in /media/sdcard/apps.
2. Run the .opk from GMENU2X.
3. Allow the process to complete.
4. Reboot.

## Instructions when changing the internal sdcard, i.e. using a bigger/new sdcard:<br>
## NOTE: This method erases the microsd, so backup of all your files beforehand as mentioned above.
1. Download the base system "sd_image.bin" from the Releases page.

### **for Windows:<br>**
2. Format the new sdcard / internal sdcard with SD FORMATTER 5.0.1 ( https://www.sdcard.org/downloads/formatter/ ) two times.
3. Download Win32 disk imager ( https://sourceforge.net/projects/win32diskimager/ ) and flash (write) the FW base image to the sdcard.
If Win32 Disk Imager didn't work, you can try Etcher ( https://www.balena.io/etcher/ ).
#### 4. DO NOT RESIZE THE EXT4 PARTITION IN WINDOWS OR LINUX!!<br> Just put the sdcard inside the console and follow the on-screen instructions.

### **for Linux:<br>**
2. Format the new SD card / internel SD card with gnome-disk-utility.
3. Flash the FW base image in the SD card with gnome-disk-utility.
   Or type in a terminal:
   
   sudo dd if=sd_image.bin of=/dev/[SD card mount point]
#### 4. Do not resize the partitions!! Just put the internal SD card inside the console and follow the on-screen instructions.

## Intructions for recovery or external update:<br>

Thanks to gcwnow's wiki (https://github.com/gcwnow).

This works for GMENUNX.

You can copy the kernel or rootfs to the internal SD card of the RG350 using FTP, SFTP or SCP. I recommend SCP since it is just one line on the command prompt. It does require setting up SSH keypair authentication beforehand though.

**for the kernel**

scp vmlinuz.bin root@10.1.1.2:/media/system/<br>
scp modules.squashfs root@10.1.1.2:/media/system/update_m.bin

**for the rootfs**

scp rootfs.squashfs root@10.1.1.2:/media/system/update_r.bin

Reboot the RG350 to activate the new kernel or rootfs. Don't use the reset button as part of the kernel or of the rootfs may not have been flushed from the write cache yet.

You can use:

ssh root@10.1.1.2
RG350:media/data/local/home# reboot

# RG350 firmware "Rogue" edition<br>
### Una bifurcación independiente del proyecto OpenDingux, enfocada en mejorar la experiencia del usuario.

Gracias a Tonyjih por el toolchain (https://github.com/tonyjih)
Agradecimiento especial para Pcercuei (https://github.com/pcercuei), Mthuurne (https://github.com/mthuurne) y opendingux (https://github.com/OpenDingux) por el codigo del sistema base.

## Metas:
- [X] Soporte exFAT, auto-redimensionado, sdcard es montada siempre como sdcard, muestra de la version - 1.7.5 branch
- [X] Agregar Esotérico como lanzador opcional - 1.7.9 branch
- [ ] actualizacion del kernel y Función de suspención real - 2.x branch
- [ ] actualizar 3D APIs - 2.1.x
- [ ] soporte HDMI - 2.2.x

# update firmware 1.7.9.8: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.8

# update firmware 1.7.9.7: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.7

# update firmware 1.7.9.6: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.6

# update firmware 1.7.9.5: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.5

# update firmware 1.7.9.4: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.4

# update firmware 1.7.9.3: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.3

# update firmware 1.7.9.2 fix: <br>
https://github.com/Ninoh-FOX/RG350-ROGUE-CFW/releases/tag/1.7.9.2fix

# update firmware 1.7.9.1: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.9.1

# update firmware 1.7.9: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.9

# update firmware 1.7.8.2: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.8.2

# update firmware 1.7.8.1: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.8.1

# update firmware 1.7.8: <br>
https://github.com/Ninoh-FOX/OpenRGH/releases/tag/1.7.8

# update firmware 1.7.7: <br>
https://drive.google.com/file/d/13iNEBQlbFkueCSAsnWpv8cVGKJv8ihpX/view

# update firmware 1.7.6: <br>
https://drive.google.com/file/d/1kMVWTWTym6TfN3_nrM9N2QSFf2dUxxjp/view

## Lista de cambios:<br>

### 1.7.9.8:<br>

1. Añadido Rogue Update Manager (Gracias a Rafa Vico).<br>
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/screenshots/screenshot013.png)
2. Corregido la emulacion del analogico como dpad.
3. actualizado el paquete linux-firmware a la ultima version (16-03-2020)

### 1.7.9.7:<br>

1. Añadido soporte a EXT2.

### 1.7.9.6:<br>

1. Corregido el orden de botones en DinguxCommander.
2. Corregido botones y sus colores en GCW-Connect y cambiado el nombre a ROGUE Connect.
3. Añadido script para formatear la sd externa como ext4.
4. Actualizados y añadidos nuevos modulos WIFI en el kernel.

### 1.7.9.5:<br>

1. Corregidas y actualizadas las librerias SDL2.
2. Insertado el opk Scriptrunner, ahora puedes formatear la sdcard externa en fat32, exfat o ext3 desde la consola.
3. Corregido los juegos que no cargaban.

### 1.7.9.4:<br>

1. Corregido la nueva aplicacion de reloj/calendario, ya no se resetea la hora.
2. Gmenu2x ahora puede mostrar dos tipos de muestra de imagen de juego (poner en /(directorio roms)/.previews/).
3. RG350test ahora es parte del sistema, ya no más en opk.

### 1.7.9.3:<br>

1. Revisado y actualizado otra vez los script del sistema de archivos, reparticion y expansion.
2. El control analogico ha sido removido de Gmenu2x.
3. Ajustada la bateria.
4. El reloj de serie ha sido actualizado con un nuevo rediseño. Gracias a Rafa Vico (https://github.com/RafaVico)
5. Corregido los botones del editor de texto. Gracias a Rafa Vico (https://github.com/RafaVico)

### 1.7.9.2 fix:<br>

Añadida la libreria perdida ncurses v5, necesaria para antiguos emuladores, debido a los ultimos cambios del buildroot por la actualizacion de esta a la version 6.1.

### 1.7.9.2:<br>

1. Optimizado el scrip del opk update para que checkee la particion boot tras hacer los cambios.
2. Corregido el script del frasher, no mas errores de "segmentation fualt", pero ahora el flasheo por opk tomará un tiempo de unos 15min, todo esta automatizado, por lo que no necesitas hacer nada.
3. Gmenu2x actualizado, ahora puedes editar los OPK, tanto nombre, descripcion, icono, manual y tipos de archivos.
4. Gmenu2x ahora puede apagar y encender la pantalla con el boton power, no más "activaciones fantasmas". Gracias a Rafa Vico (https://github.com/RafaVico)
5. RG350 test actualizado, ahora puedes ver el espacio libre en ambas tarjetas SD, gracias a Rafa Vico (https://github.com/RafaVico)
6. Actualizado Esoteric a la ultima version. Gracias a Podulator (https://github.com/podulator/esoteric)

### 1.7.9.1:<br>

1. Optimizado la creacion del sistema de particiones y de archivo en el primer arranque, este ya no se sobreescribirá más, solo con flasher.
2. Optimizado el checkeo de archivos en los arranques.
3. Optimizado la instalación por flasher.
4. Gmenu2x ahora tiene Docs, un lector de TXTs, gracias a Rafa Vico (https://github.com/RafaVico)
5. Gmenu2x ahora muestra el porcentaje de la bateria tambien.
6. Gmenu2x puede cambiar ahora la frecuencia de cpu entre MAX y Min para ahorrar bateria (por ejemplo para GBC emu)<br>
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/screenshots/cpucontrol1.png)
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/screenshots/cpucontrol2.png)
7. Optimizado los Hz de la pantalla en el kernel (Gracias a pcercuei https://boards.dingoonity.org/retro-game-350rg-350/screen-now-going-bad/msg191784/#msg191784)

### 1.7.9: <br> 
1. Cambie el logotipo de arranque (de nuevo), elimine el logotipo de OpenDingux por respeto al creador original del sistema. <br>
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/logo_rg350.jpg)
2. Se eliminaron todas las referencias a OpenDingux, excepto en la información del sistema como agradecimiento por el sistema base original.
3. Gmenu2x ahora lee y escribe todo desde HOME.
4. Esoteric añadido cómo lanzador opcional en el sistema. (gracias a Podulator https://github.com/podulator/esoteric).
5. Actualización de RG350test en sd_imagen (gracias a https://github.com/RafaVico).
6. Ahora sd_imagen también en archivo opk, ahora puede actualizar la tarjeta sd sin abrir la consola (esto borra todo).
7. Ahora funcionan las opks de actualizaciones y flashes en otros lanzadores.

### 1.7.8.2:<br>

1. Cambio del logo de carga.<br>
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/logos/67d0e5b053de2d8c2d813fe0459d11a2o.jpg)
2. Nuevo nombre del firmware.
3. Actualizada algunas librerias.
4. Gmenu2x ahora es linkeado en /local/home/.gmenu2x

### 1.7.8.1:<br>
1. la particion boot ahora es tambien montada en /media/system en modo escritura, para poder recuperar la consola sin abrirla en caso de fallo dentro de lo posible.
2. Gmenu2x ahora puede enlazar archivos .opk y .dge.
3. Nuevo logo de carga.
4. Nueva imagen de la tarjeta MicroSD (Gracias a https://github.com/gcwnow/imager )

### 1.7.8:<br>
1. lazy_itable_init = 0 and lazy_journal_init = 0 se ha añadido al sistema de archivo del sistema ext4.
2. Se muestra la version del sistema en System Info app.

![](https://fotos.subefotos.com/d74d4f1ba67f0d5f556aa7a43e7c7c84o.jpg)

### 1.7.7:<br>
1. exFAT añadido - ya no es necesario decargar herramientas para formatear en FAT32 microsd de 64GB+.
2. El directorio por defecto para la microsd es ahora /media/sdcard - ya no habra problemas con microsds con diferentes etiquetas.
3. Modo automatico de expansion del las particiones de la sdcard y creacion de la memoria swap - esto puede tardar un poco, pero esta preparado para que solo suceda en el primer arranque tras actualizar si es necesario.
4. Borrado modulos duplicados de modules.squashfs 
5. Corregido la expansion de particiones en stock firmwares viejos (las imagenes sd tienen mal el sistema ext4)
6. Corregido mensajes de error al apagar o reiniciar
7. Corregido relentizaciones que se producian tras los primeros 15min de que la consola estuviera encendida.
8. Rehecho mininit-syspart desde el codigo original de opendingux (Gracias a https://github.com/OpenDingux/mininit)
9. Removidas configuraciones residuales en el primer arranque.
10. Cambiada el sistema de particiones.
11. Resturado el soporto USB-HID (OTG).
12. Actualizado libshake desde el codigo original: https://github.com/zear/libShake


## Instrucciones:<br>
### Nota: Si es la primera vez que actualizas este firmware, lo idoneo es que uses el archivo sd_image.bin o el flasher opk, luego ya despues puedes seguir actualizando por opk. Impotante, sd_image.bin y flasher opk borra toda la sd, por lo que primero, y si vienes de otro FW tambien, es mejor que hagas copias de las carpetas /local/home y /local/apps antes de actualizar.

## Instrucciones por OPK (no es necesario abrir la consola):
1. Coloca el update en OPK /media/data/apps o /media/sdcard/apps
2. Arranca OS Update desde Gmenu2x (actualmente no funciona en Gmenunx)
3. Espera a que el proceso termine.
4. Reinicia
5. Si ves que el sistema falla al reiniciar, presiona Y para cargar el ultimo kernel que funcionó, o X para cargar el ultimo sistema de archivos que funcionó. X+Y para cargar la ultima version del sistema que funcionó. Esto es una carga temporar, pero te servirá para volver a intentarlo o para probar otro metodo de actualización.

## Instruciones para una actualizacion limpia o corregir tarjetas defectuosas
## Nota: este metodo borra la sd, has copia de tus datos antes.
1. Coloca el flasher en OPK en /media/sdcard/apps
2. Arranca Flasher desde GMENU2X.
3. Espera a que el proceso termine.
4. Reinicia

## Instruciones para cambiar de microsd interna:<br>
## Nota: este metodo borra la sd, has copia de tus datos antes.

1. Descarga el sistema base "sd_image.bin" del release.

### **para Windows:<br>**
2. Formatea la microsd interna o nueva con SD FORMATTER 5.0.1 ( https://www.sdcard.org/downloads/formatter/ ) dos veces.
3. Descarga Win32 disk imager ( https://sourceforge.net/projects/win32diskimager/ ) y flashea (escribir) la imagen del cfw (sd_image.bin) en la microsd.
si no funcion W32DI pruebe este https://www.balena.io/etcher/
#### 4. NO EXTIENDAS LA PARTICION EXT4 EN WINDOWS!!<br> solo pon la microsd dentro de la consola, enciendela y sigue las instrucciones.

### **para Linux:<br>**
2. Formatea la microsd interna o nueva con gnome-disk-utility. (da igual el formato)
3. flashea la microsd (reescribir imagen de disco) con gnome-disk-utility.
   O escribe en el terminal:
   
   sudo dd if=sd_image.bin of=/dev/[punto de montaje de la microsd]
#### 4. NO EXTIENDAS LA EXTENSION!! solo pon la microsd dentro de la consola, enciendela y sigue las instrucciones.

## Instrucciones para recuperarla o actualizar desde USB:<br>

Gracias al wiki de https://github.com/gcwnow

Este metodo funciona tambien en GMENUNX.

Puede copiar el kernel o rootfs a la tarjeta SD interna del RG350 usando FTP, SFTP o SCP. Recomiendo SCP ya que es solo una línea en el símbolo del sistema. Sin embargo, requiere configurar la autenticación de par de claves SSH.

**para el kernel**

scp vmlinuz.bin root@10.1.1.2:/media/system/<br>
scp modules.squashfs root@10.1.1.2:/media/system/update_m.bin

**para rootfs**

scp rootfs.squashfs root@10.1.1.2:/media/system/update_r.bin

Reinicie el RG350 para activar el nuevo kernel o rootfs. No use el botón de reinicio: parte del kernel o de los rootfs pueden no haberse eliminado aún de la caché de escritura.

Puedes usar el comando reboot:

ssh root@10.1.1.2
RG350:media/data/local/home# reboot

