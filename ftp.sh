#!/bin/bash

#Se pide al usuario que desea hacer. La opción de configuración solo debe ser
#seleccionada la primera vez.
# echo "Seleccione una acción: (C)Configuración - (I)Inicio servidor "
# read sel

if [[ $1 == "--config" || $1 == "config" ]]; then
    echo "Configuración"

    echo "Escriba el sistema operativo donde está ejecutando este programa"
    echo "  (U)Ubuntu20-Linux"
    echo "  (C)CentOS7-Linux"
    echo "  (M)MAC"
    read so   
    if [[ $so == "U" || $so == "u" ]]; then
        echo "Configurando Sistema Ubuntu-LINUX"
        #Configuración de puertos del FW
        sudo ufw allow 2121/tcp
        sudo ufw allow 5890:5900/tcp

        sudo apt install python3-pip
        pip3 install pyftpdlib

        #Ejecutando inicio del programa
        ftp-uniandes/ftp.sh start

    elif [[ $so == "C" || $so == "c" ]]; then
        echo "Configurando Sistema CentOS-LINUX"

        #Configuración de puertos del FW
        sudo firewall-cmd --zone=public --permanent --add-port=2121/tcp
        sudo firewall-cmd --zone=public --permanent --add-port=5890-5900/tcp

        #Instalación de librerias
        sudo yum install python3-pip -y
        pip3 install pyftpdlib 

        #Inicio del programa
        ftp-uniandes/ftp.sh --start
        

    elif [[ $so == "M" || $so == "m" ]]; then
        echo "Configurando Sistema MAC"

        #Instalación de librerias
        pip3 install pyftpdlib –-user

        #Inicio del programa
        ftp-uniandes/ftp.sh --start
       
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
