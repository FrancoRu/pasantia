import json
import csv

with open('../utils/department.json', encoding='utf-8') as depJSON:
    depData = json.load(depJSON)

with open('../utils/survey.json', encoding='utf-8') as themeJSON:
    themeData = json.load(themeJSON)

with open('../utils/titles.json', encoding='utf-8') as titJSON:
    titData = json.load(titJSON)

with open('../utils/censos.json', encoding='utf-8') as cenJSON:
    cenData = json.load(cenJSON)

#Creacion de csv con titulos de la forma id_cuadro,id_titulo,id_tematica,titulo

insertTitle = []
themes = themeData['modules']
tittles = titData['temas']
id_max = 0

def idMax():
    count = 1
    for element in insertTitle:
        if element['id'] >= count:
            count = element['id'] + 1
    return count

for theme in themes:
    for quadro in theme['tema']:
        for element in quadro['array']:
            for title in tittles:
                if theme['value'] == title['value']:
                    for tit in title['array']:
                        if tit['id'] == element:
                            insertTitle.append({
                                "id": idMax(),
                                "id_quadro": quadro['id_quadro'],
                                "id_title": tit['id'],
                                "title": tit['value'],
                                "id_theme": theme['id']
                            })

with open("titles.csv", mode='w', newline='', encoding='utf-8') as archivo:
        for titles in insertTitle:
            linea = f"{titles['id']};{titles['id_title']};{titles['id_quadro']};{titles['id_theme']};{titles['title']}\n"
            archivo.write(linea)

#Creacion de csv para las provincias

with open("department.csv", mode='w', newline='', encoding='utf-8') as archivo:
        for element in depData['departments']:
            linea = f"{element['id']};{element['value']}\n"
            archivo.write(linea)

#Creacion de csv para los censos

with open("censos.csv", mode='w', newline='', encoding='utf-8') as archivo:
        for cen in cenData['censos']:
            linea = f"{cen['anio']};{cen['desc']}\n"
            archivo.write(linea)

#Creacion de csv para las tematicas de la forma id_tematica, desc

insertTheme = {}

for name in depData['departments']:
    for theme in themeData['modules']:
        idTheme = theme['id']
        insertTheme[theme['value']] = {
            'id': idTheme,
            'desc': theme['value']
        }

with open("tematica.csv", mode='w', newline='', encoding='utf-8') as archivo:
        for clave, data in insertTheme.items():
            linea = f"{data['id']};{data['desc']}\n"
            archivo.write(linea)

#Creacion de csv para los cuadros de la forma id_cuadro, descripcion

insertQuadro = {}

for name in depData['departments']:
    nameDep = name['value']
    themes_data = []  
    for theme in themeData['modules']:
        idTheme = theme['id']
        for quadro in theme['tema']:
            insertQuadro[quadro['id_quadro']] = {
                'desc' : quadro['value']
                }

with open("cuadro.csv", mode='w', newline='', encoding='utf-8') as archivo:
        for id_quadro, data in insertQuadro.items():
            linea = f"{id_quadro};{data['desc']}\n"
            archivo.write(linea)

#Creacion de csv relacion de muchos a muchos entre cuadro y tema, en la forma id_cuadro, id_tema

cuadro_has_tem = []

def appendQuadro(idTheme, quadro):
    cuadro_has_tem.append({
            'id_theme' : idTheme,
            'id_quadro' : quadro['id_quadro']
        })

index = 0

for theme in themeData['modules']:
    idTheme = theme['id']
    for quadro in theme['tema']:
        if index == 0 : appendQuadro(idTheme, quadro)
        i = 1

with open("cuadro_has_tematica.csv", mode='w', newline='', encoding='utf-8') as archivo:
        for element in cuadro_has_tem:
            linea = f"{element['id_quadro']};{element['id_theme']}\n"
            archivo.write(linea)

#Creacion del csv de relaciones entre censo y departmentos
count = 1
with open("department_has_censo.csv", mode='w', newline='', encoding='utf-8') as archivo:
        for element in cenData['censos']:
            for dep in depData['departments']:
                linea = f"{count};{element['anio']};{dep['id']}\n"
                archivo.write(linea)
                count += 1

data = {
     "register": []
}

