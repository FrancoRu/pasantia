import json


cuadro = 'Censo 2010-cuadros por muni frac y radio'

with open('../utils/department.json', encoding='utf-8') as depJSON:
    depData = json.load(depJSON)

with open('../utils/survey.json', encoding='utf-8') as themeJSON:
    themeData = json.load(themeJSON)

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
                theme_info['files'].append({'xls': xls_filename})

        themes_data.append(theme_info)

    department_info = {
        'department_name': nameDep,
        'themes': themes_data
    }

    department_data.append(department_info)
print(department_data)

