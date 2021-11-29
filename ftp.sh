#!/bin/bash
#Se pide al usuario que desea hacer. La opción de configuración solo debe ser
#seleccionada la primera vez.
# echo "Seleccione una acción: (C)Configuración - (I)Inicio servidor "
# read sel
#echo "Escriba el sistema operativo donde está ejecutando este programa"

                         
                                                                                                                                                                         

if [[ $1 == "--config" || $1 == "config" ]]; then
    echo " ===================================================================================================="
    echo "   ___|                    _|  _)                                              |                     "
    echo "  |        _ \    __ \    |     |    _' |   |   |    __|    _' |   __ \     _' |    _ \              "
    echo "  |       (   |   |   |   __|   |   (   |   |   |   |      (   |   |   |   (   |   (   |             "
    echo " \____|  \___/   _|  _|  _|    _|  \__, |  \__,_|  _|     \__,_|  _|  _|  \__,_|  \___/   _)  _)  _) "
    echo "                                   |___/                                                             "
    echo " ===================================================================================================="
                   
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

        if [ -d "~/ftp-uniandes/" ] then
            #Inicio del programa
            ~/ftp-uniandes/ftp.sh --start
        else echo "No se encontro el direcorio ~/ftp-uniandes/, puedes buscar este directorio e iniciar el programa con el comando ./ftp.sh --start"
        fi

    elif [[ $so == "C" || $so == "c" ]]; then
        echo "Configurando Sistema CentOS-LINUX"

        #Configuración de puertos del FW
        sudo firewall-cmd --zone=public --permanent --add-port=2121/tcp
        sudo firewall-cmd --zone=public --permanent --add-port=5890-5900/tcp

        #Instalación de librerias
        sudo yum install python3-pip -y
        pip3 install pyftpdlib 

        if [ -d "~/ftp-uniandes/" ] then
            #Inicio del programa
            ~/ftp-uniandes/ftp.sh --start
        else echo "No se encontro el direcorio ~/ftp-uniandes/, puedes buscar este directorio e iniciar el programa con el comando ./ftp.sh --start"
        fi
        

    elif [[ $so == "M" || $so == "m" ]]; then
        echo "Configurando Sistema MAC"

        #Instalación de librerias
        pip3 install pyftpdlib –-user

        

        if [ -d "~/ftp-uniandes/" ] then
            #Inicio del programa
            ~/ftp-uniandes/ftp.sh --start
        else echo "No se encontro el direcorio ~/ftp-uniandes/, puedes buscar este directorio e iniciar el programa con el comando ./ftp.sh --start"
        fi
       
    else echo "Opción no valida"
    fi

elif [[ $1 == "--start" || $1 == "start" ]]; then

    echo " ======================================================================================"
    echo "  ____|  __ __|    _ \       |   |          _)      \                  |               "
    echo "  |         |     |   |      |   |   __ \    |     _ \     __ \     _' |    _ \    __| "
    echo "  __|       |     ___/       |   |   |   |   |    ___ \    |   |   (   |    __/  \__ \ "
    echo " _|        _|    _|         \___/   _|  _|  _|  _/    _\  _|  _|  \__,_|  \___|  ____/ "
    echo " ======================================================================================"
                                                                                        

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
