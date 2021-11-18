import os
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer


def main():
    user = input("Ingrese el nombre de usuario: ")
    passw = input("Ingrese la contraseña: ")
    path = input("Indique la ruta del directorio a compartir: ")
    # Instantiate a dummy authorizer for managing 'virtual' users
    authorizer = DummyAuthorizer()

    # Se define un usuario con permisos de escritura y lectura sobre el directorio
 
    authorizer.add_user(user,passw,path, perm='elradfmwMT')


    # Configuraciones del servidor FTP
    handler = FTPHandler
    handler.authorizer = authorizer
    handler.banner = "On the Fly FTP server UniAndes."
    handler.use_sendfile = True
    handler.passive_ports = range(5890, 5900)

    # Creación del servicio FTP   
    address = ('', 2121)
    server = FTPServer(address, handler)

    # Imponer un limite de conexiones
    server.max_cons = 5
    server.max_cons_per_ip = 2

    # Inicio del servidor FTP
    server.serve_forever()

if __name__ == '__main__':
    main()