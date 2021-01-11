f1 = open('family.ged', 'r', encoding="utf8")
f2 = open('family.pl', 'w', encoding="utf8")
f2.close()
f2 = open('family.pl', 'a', encoding="utf8")

fam = []
amount = 0

ID = [] 
name = []
#sex = []
part = 0
number = 0
wife = '-'; husb = '-'; child = '-'
no = 0

for line in f1:
    if part == 0 and line[0] == '0' and line[2] == '@' and line[25] == 'F':
        part = 1

    if part == 0:
        if line[0] == '0' and line[2] == '@':
            ID.insert(number, '')
            for i in range(19):
                ID[number] = ID[number] + line[i + 4]
        
        if line[0] == '1' and line[2] == 'N':
            name.insert(number, '')
            i = 0
            while line[i + 7] !=  '\n':
                if line[i + 7] != '/': name[number] = name[number] + line[i + 7]
                i = i + 1
            number = number + 1
    
 #       if line[0] == '1' and line[2] == 'S' and line[3] == 'E':
 #           sex.insert(number, line[6])
 #           number = number + 1

    elif line[0] == '1':
        if line[2] == 'W':
            wife_ = ''
            for i in range(19):
                wife_ = wife_ + line[i + 9]
            t = 0
            while t >= 0:
                if ID[t] == wife_: 
                    wife = name[t] 
                    fam.insert(amount, wife_) # эту
                    amount = amount + 1 # эту 
                    t = -2
                t = t + 1

        if line[2] == 'H':
            husb_ = ''
            for i in range(19):
                husb_ = husb_ + line[i + 9]
            t = 0
            while t >= 0:
                if ID[t] == husb_: 
                    husb = name[t] 
                    fam.insert(amount, husb_) # эту
                    amount = amount + 1 # и эту часть кода добавила для 3 пункта
                    t = -2
                t = t + 1

        if line[2] == 'C':
            child_ = ''
            for i in range(19):
                child_ = child_ + line[i + 9]
            t = 0
            while t >= 0:
                if ID[t] == child_: 
                    child = name[t] 
                    t = -2
                t = t + 1
            
            if wife == '-': wife = 'null' + str(no); no = no + 1
            if husb == '-': husb = 'null' + str(no); no = no + 1
            f2.write('parent(\'')
            f2.write(child)
            f2.write('\',\'')
            f2.write(husb)
            f2.write('\',\'')
            f2.write(wife)
            f2.write('\').\n')

    elif line[0] == '0' and line [2] == '@':
        wife = '-'
        husb = '-'
        child = '-'

f1.close()
f1 = open('family.ged', 'r', encoding="utf8")

index = ''
match = 0
for line in f1:
    if line[0] == '0' and line[2] == '@' and line[25] != 'F':
        index = ''
        for i in range(19):
            index = index + line[i + 4]
        
        match = 0
        t = 0
        while match == 0 and t < amount:
            if index == fam[t]:
                match = 1
            else:
                match = 0
            t = t + 1

    if line[0] == '1' and line[2] == 'S' and line[3] == 'E' and line[6] == 'F' and match == 0:
        n = ''
        t = 0
        while t >= 0:
            if index == ID[t]:
                n = name[t]
                t = -2
            t = t + 1
        
        f2.write('parent(\'null')
        f2.write(str(no))
        no = no + 1
        f2.write('\',\'') 
        f2.write('null')
        f2.write(str(no))
        no = no + 1
        f2.write('\',\'')
        f2.write(n)
        f2.write('\').\n')

    if line[0] == '1' and line[2] == 'S' and line[3] == 'E' and line[6] == 'M' and match == 0:
        n = ''
        t = 0
        while t >= 0:
            if ID[t] == index:
                n = name[t]
                t = -2
            t = t + 1
        
        f2.write('parent(\'null')
        f2.write(str(no))
        no = no + 1
        f2.write('\',\'') 
        f2.write(n)
        f2.write('\',\'null')
        f2.write(str(no))
        no = no + 1
        f2.write('\').\n')


f1.close()
f2.close()
