#!/bin/bash

#Se pide al usuario que desea hacer. La opción de configuración solo debe ser
#seleccionada la primera vez.
# echo "Seleccione una acción: (C)Configuración - (I)Inicio servidor "
# read sel

if [[ $1 == "--config" || $1 == "config" ]]; then
    echo "Configuración"

    echo "Escriba donde está ejecutando este programa (L)Ubuntu-Linux (M)MAC: "
    read so   
    if [[ $so == "L" || $so == "l" ]]; then
        echo "Configurando Sistema LINUX"
        #Configuración de puertos del FW
        ufw allow 2121/tcp
        ufw allow 5890:5900/tcp

        sudo apt install python3-pip
        pip3 install pyftpdlib

        #Ejecutando inicio del programa
        ./ftp.sh start

        #Copia del programa del servidor FTP
        # git clone https://github.com/ArnoldLara/ftp-uniandes

    elif [[ $so == "M" || $so == "m" ]]; then
        echo "Configurando Sistema MAC"

        #Instalación de librerias
        pip3 install pyftpdlib –-user

        #Inicio del programa
        ./ftp.sh start
        #Copia del programa del servidor FTP
        # git clone https://github.com/ArnoldLara/ftp-uniandes
    else echo "Opción no valida"
    fi

elif [[ $1 == "--start" || $1 == "start" ]]; then
    echo "Inicio"

    echo "Ingrese el nombre de usuario: "
    read user
    echo "Ingrese la contraseña: "
    read pass
    echo "Indique la ruta del directorio a compartir: "
    read dir
    
    if [ -d "$dir" ]
    then
        echo "Puedes acceder al servicio en esta dirección IP "
        hostname -I
        echo "Usando el puerto 2121"
        python3 -m pyftpdlib -i 0.0.0.0 -p 2121 -r 5890-5900 -u $user -P $pass -d $dir

    else
        echo "El directorio $dir no existe, verifica la ruta."
    fi


else echo "Opcion no valida. Debes seleccionar alguna opción entre --start o --config"
fi
