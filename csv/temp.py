import json
import csv

cuadro = 'Censo 2010-cuadros por muni frac y radio'

with open('../utils/department.json', encoding='utf-8') as depJSON:
    depData = json.load(depJSON)

with open('../utils/survey.json', encoding='utf-8') as themeJSON:
    themeData = json.load(themeJSON)

with open('../utils/titles.json', encoding='utf-8') as titJSON:
    titData = json.load(titJSON)

department_data = []  # Lista para almacenar información de los departmentos

for name in depData['departments']:
    nameDep = name['value']
    themes_data = []  # Lista para almacenar información de los temas por departmento

    for theme in themeData['modules']:
        idTheme = theme['id']
        theme_info = {
            'theme_id': idTheme,
            'files': []  # Un solo objeto para almacenar archivos xls y pdf
        }

        for quadro in theme['tema']:
            for element in quadro['array']:
                xls_filename = f"{element}{idTheme}-FR-{nameDep}.xls"
                pdf_filename = f"{element}{idTheme}-FR-{nameDep}.pdf"
                theme_info['files'].append({'xls': xls_filename, 'pdf': pdf_filename})

        themes_data.append(theme_info)

    department_info = {
        'department_name': nameDep,
        'themes': themes_data
    }

    department_data.append(department_info)
print(department_data)


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
count = 1
for dep in depData['departments']:
    for titles in insertTitle:
        print(f"{count};{dep['value']};{titles['id']}")
        count +=1
count = 1

dataRegister = {
    "register": []
}

def nombreDep(id):
    for dep in depData['departments']:
        if dep['id'] == id:
            return dep['value']

with open('department_has_censo.csv', 'r', encoding='utf-8') as archivo_csv:
    csv_reader = csv.reader(archivo_csv)
    for row in csv_reader:
        for element in row:
            data = element.split(';')
            if data[1] == '2010':
                for titles in insertTitle:
                    dataRegister['register'].append({
                        "id" : count,
                        "Titulo_cuadro_id_registro": titles['id'],
                        "Censo_has_departamento_id_registro": data[0],
                        "url_cuadro_xlsx": f"{titles['id_title']}{titles['id_theme']}-FR-{nombreDep(data[2])}.xlsx"
                    })
                    count+=1


with open('../utils/register.json', 'w', encoding='utf-8') as archivo_json:
    json.dump(dataRegister, archivo_json, ensure_ascii=False, indent=4)

with open("register.csv", mode='w', newline='', encoding='utf-8') as archivo:
        for element in dataRegister['register']:
            linea = f"{element['id']};{element['Titulo_cuadro_id_registro']};{element['Censo_has_departamento_id_registro']};{element['url_cuadro_xlsx']}\n"
            archivo.write(linea)