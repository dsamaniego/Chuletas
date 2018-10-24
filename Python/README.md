# Python

### Problemas con el encoding en Python.

Lo mejor es tener el LOCALE o el LANG a en_US.UTF-8, si no, se puede exportar una variable en el profile que es la que busca el Python cuando se ejecuta:
export PYTHONIOENCODING="UTF-8"

Otra forma, en el código:
```Python
# -*- coding: utf-8 -*-
… (otros imports)
import sys
reload(sys)
sys.setdefaultencoding('utf-8')
```

#### Eliminar mensajes de warning en Python por SSL
```bash
export PYTHONWARNINGS="ignore:Certificate has no, ignore:A true SSLContext object is not available"
```

### Lista de ficheros:

* plantilla.py - Una plantilla para ficheros python

