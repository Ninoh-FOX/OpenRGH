<p align="center"><img class="center" src ="https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/logo.png"></p>

# RG350 firmware "Rogue" edition<br>
### An independent fork of the OpenDingux project, focused on improving the user experience. 

Thanks to Tonyjin for toolchain (https://github.com/tonyjih)
Special Thanks to Pcercuei (https://github.com/pcercuei), Mthuurne (https://github.com/mthuurne) and opendingux (https://github.com/OpenDingux) for the original code base system.

### instrucciones en español más abajo.

## Goals:
- [X] exFAT support, auto-resize, constant sdcard mount point, show version - 1.7.5 branch
- [X] Add Esoteric how optional launcher - 1.7.9 branch
- [ ] Suspend capability - 1.8.x branch
- [ ] Kernel update -2.x branch
- [ ] Modernize 3D APIs - 2.1.x
- [ ] HDMI support - 2.2.x
- [ ] Vulkan?? - Future

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

### 1.7.9:<br>

1. Change boot logo (again), OpenDingux logo removed for respect to the original creator of the system.
2. All references to OpenDingux removed, except in the system information as thanks for the original base system.
3. Gmenu2x now read and write all from home.
4. Esoteric add how optional launcher in the system.
5. Update RG350Tests in sd_imagen (thanks to https://github.com/RafaVico).
6. Now sd_imagen too in opk file, you can now reflash the sdcard without open the console (this erase all).
7. Now work updates and flashers opks in another launchers.


### 1.7.8.2:<br>

1. change boot logo.<br>
![](https://raw.githubusercontent.com/Ninoh-FOX/RG350-ROGUE-CFW/master/logos/67d0e5b053de2d8c2d813fe0459d11a2o.jpg)
2. New name firmware.
3. Update some libs.
4. Gmenu2x now is mount in /local/home/.gmenu2x

### 1.7.8.1:<br>
1. boot partition now is mount too in /media/system in rw mode for recovery the system from pc if this is possible.
2. Gmenu2x now can link .opk and .dge files.
3. New boot logo.
4. New flasher sdcatd imagen (thanks to https://github.com/gcwnow/imager )

### 1.7.8:<br>
1. lazy_itable_init = 0 and lazy_journal_init = 0 support added to EXT4 file system.
2. Display version in System Info app.

![](https://fotos.subefotos.com/d74d4f1ba67f0d5f556aa7a43e7c7c84o.jpg)

### 1.7.7:<br>
1. exfAT support added - no more need to download a utility to format 64GB+ SD cards
2. Default SD card mount changed to /media/sdcard - No having to re-do paths when swapping SD cards
3. Auto swap file and partition resize - This takes a while, allow it to finish.  Progress will be shown on screen during first boot
4. Duplicate modules removed from modules.squashfs 
5. Fix the resize in old stock firmwares (bad ext4 partition)
6. Fixed power off and reboot error messages
7. Fixed slowdowns and stuttering during first 15 minutes after first boot
)8. Rebuild mininit-syspart from original opendingux code. (Thanks to https://github.com/OpenDingux/mininit)
9. Autoremove old configs of the system in the first boot.
10. Change file system table.
11. Restore USB-HID suport.
12. update libshake from original code: https://github.com/zear/libShake


## Instructions:<br>
### NOTE: If is your first install time for this cfw, the optimus is user sd_image.bin, afte, you can use alway the opks files for update. sd_image.bin erase all data in sdcard!! If you gone from another CFW is better that you make a backup of the folders local/home and local/app first.

## Instruction for update from OPK update file (Not need open the console):
1. Place the update opk file in /media/data/apps or /media/sdcard/apps.
2. Run from your prefer launcher.
3. allow process to complete.
4. Reboot.
5. If system fails to boot, press Y to boot to last working kernel, or X to boot to last working rootfs. X+Y will load your previous OS version.

## Instructions for  a clear update / fix internal sdcard:<br>
## NOTE: This metode erase all microsd, do a copy of all your files before.
1. Place the flasher opk file in /media/data/apps or /media/sdcard/apps.
2. Run from your prefer launcher.
3. allow process to complete.
4. Reboot.

## Instructions for change of internal sdcard:<br>
## NOTE: This metode erase all microsd, do a copy of all your files before.
1. Download a base system "sd_image.bin" from releases.

### **for Windows:<br>**
2. Format the new sdcard / internel sdcard with SD FORMATTER 5.0.1 ( https://www.sdcard.org/downloads/formatter/ ) two times.
3. Download Win32 disk imager ( https://sourceforge.net/projects/win32diskimager/ ) and flash (writer) the FW base imagen in the sdcard.
#### 4. NOT RESIZER THE EXT4 PARTITION IN WINDOWS!!<br> only put the internal sd in the console and follow the instructions.

### **for Linux:<br>**
2. Format the new sdcard / internel sdcard with gnome-disk-utility.
3. Flash the FW base imagen in the sdcard with gnome-disk-utility.
   Or type in a terminal:
   
   sudo dd if=sd_image.bin of=/dev/[sdcard mount point]
#### 4. Not resize!! Put the internal sd in the console and follow the instructions.

## intructions for recovery or external update:<br>

thanks to https://github.com/gcwnow wiki

This work for GMENUNX.

You can copy the kernel or rootfs to the internal SD card of the RG350 using FTP, SFTP or SCP. I recommend SCP since it is just one line on the command prompt. It does require setting up SSH keypair authentication though.

**for kernel**

scp vmlinuz.bin root@10.1.1.2:/media/system/<br>
scp modules.squashfs root@10.1.1.2:/media/system/update_m.bin

**for rootfs**

scp rootfs.squashfs root@10.1.1.2:/media/system/update_r.bin

Reboot the RG350 to activate the new kernel or rootfs. Don't use the reset button: part of the kernel or of the rootfs may not have been flushed from the write cache yet.

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
- [ ] Función de suspención real - 1.8.0 brach
- [ ] actualizacion del kernel -2.x branch
- [ ] actualizar 3D APIs - 2.1.x
- [ ] soporte HDMI - 2.2.x
- [ ] Vulkan?? - Future

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

### 1.7.9: <br> 
1. Cambie el logotipo de arranque (de nuevo), elimine el logotipo de OpenDingux por respeto al creador original del sistema. 
2. Se eliminaron todas las referencias a OpenDingux, excepto en la información del sistema como agradecimiento por el sistema base original.
3. Gmenu2x ahora lee y escribe todo desde HOME.
4. Esoteric añadido cómo lanzador opcional en el sistema.
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
### Nota: Si es la primera vez que actualizas este firmware, lo idoneo es que uses el archivo sd_image.bin, luego ya despues puedes seguir actualizando por opk. Impotante, sd_image.bin borra toda la sd, por lo que primero, y si vienes de otro FW tambien, es mejor que hagas copias de las carpetas /local/home y /local/apps antes de actualizar.

## Instrucciones por OPK (no es necesario abrir la consola):
1. Coloca el update en OPK /media/data/apps o /media/sdcard/apps
2. Arranca OS Update desde Gmenu2x (actualmente no funciona en Gmenunx)
3. Espera a que el proceso termine.
4. Reinicia
5. Si ves que el sistema falla al reiniciar, presiona Y para cargar el ultimo kernel que funcionó, o X para cargar el ultimo sistema de archivos que funcionó. X+Y para cargar la ultima version del sistema que funcionó. Esto es una carga temporar, pero te servirá para volver a intentarlo o para probar otro metodo de actualización.

## Instruciones para una actualizacion limpia o corregir tarjetas defectuosas
## Nota: este metodo borra la sd, has copia de tus datos antes.
1. Coloca el flasher en OPK en /media/data/apps o /media/sdcard/apps
2. Arranca Flasher desde el launcher que prefieras.
3. Espera a que el proceso termine.
4. Reinicia

## Instruciones para cambiar de microsd interna:<br>
## Nota: este metodo borra la sd, has copia de tus datos antes.

1. Descarga el sistema base "sd_image.bin" del release.

### **para Windows:<br>**
2. Formatea la microsd interna o nueva con SD FORMATTER 5.0.1 ( https://www.sdcard.org/downloads/formatter/ ) dos veces.
3. Descarga Win32 disk imager ( https://sourceforge.net/projects/win32diskimager/ ) y flashea (escribir) la imagen del cfw (sd_image.bin) en la microsd.
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

