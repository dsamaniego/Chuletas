#!/usr/bin/python
# -*- coding: utf-8 -*-
#
# <Comentarios del programa>
#

import argparse
import logging

# ARGUMENTOS (aquí ponemos lo que mostraremos en la ayuda).
parser = argparse.ArgumentParser(description='Takes a rundeck YAML inventory and creates one with only the specified envirnment')
parser.add_argument('-f', '--file', help='Source Inventory file', required=True)
parser.add_argument('-e', '--environment', help='Environment destination', required=True)
args = parser.parse_args()


# LOGGING (nivel:INFO, ERROR, DEBUG)
logging.basicConfig(filename= <fichero_con_ruta>, format='%(levelname)s: %(message)s', filemode='w', level=logging.<NIVEL>) 
