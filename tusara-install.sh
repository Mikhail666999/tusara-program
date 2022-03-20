#!/bin/bash

build(){
    echo """#!/bin/bash
echo \"Если вы в консоли с root правами, то пожалуйста введите exit и запустите заново.\"
read

# Введите всё теже файлы только с расширением .class и в томже порядке и через ПРОБЕЛ \" \"
# var2=\"\"

read -p \"Назовите окончательный билд(на англ)(без расширения)(и без пробелов): \" name
 
cd bin
jar cvmf manifest.mf \"\$name\".jar Main.class >> log.txt
# jar cvmf manifest.mf \"\$name\".jar Main.class \"\$var2\" >> log.txt
if [ \$? -eq 0 ]; then
    java -jar \"\$name\".jar
else
    echo \"Возможно вы не запускали проект и класс просто не существует\"
fi""" >> build.sh

	chmod +x build.sh
}

Main(){
	echo "import java.util.*;" >> Main.java
    echo " " >> Main.java
    echo "class Main{" >> Main.java
	echo "    public static void main(String[] args){" >> Main.java
	echo "        System.out.println(\"Hello, world!\");" >> Main.java
	echo "    }" >> Main.java
	echo "}" >> Main.java
}

start(){
	echo """#!/bin/bash
echo \"Если вы в консоли с root правами, то пожалуйста введите exit и запустите заново.\"
read
clear
# Введите всё файлы .java и в нужном порядке и через ПРОБЕЛ " "
# var=\"\"
# Введите всё теже файлы только с расширением .class и в томже порядке и через ПРОБЕЛ " "
# var2=\"\"

cd scr
javac Main.java 
# javac Main.java \"\$var\"
if [ $? -eq 0 ]; then
    # mv Main.class \"\$var2\" ../bin/
    mv Main.class ../bin/
    cd ../bin/
    java Main
fi
""" >> start.sh

	chmod +x start.sh
}

manifest(){
	echo "main-class: Main" >> manifest.mf
	echo "class-pach: bin/" >> manifest.mf
}

java_creat(){
	echo "#!/bin/bash" >> tusara.sh
    echo "echo \"Если вы в консоли с root правами, то пожалуйста введите exit и запустите заново.\"" >> tusara.sh
    echo "read" >> tusara.sh
	echo " " >> tusara.sh
	echo "project_name_id=\"\"" >> tusara.sh
	echo "project_pach_id=\"\"" >> tusara.sh
	echo " " >> tusara.sh
	echo " " >> tusara.sh
	echo "clear" >> tusara.sh
	echo " " >> tusara.sh
	echo "read -p \"Имя проекта(на англ): \" project_name_id" >> tusara.sh
	echo "read -e -p \"Введите путь к файлу: \" -i \"/home/\"\$USER\"/1MyAll1/projects/java\" project_pach_id" >> tusara.sh
	echo "" >> tusara.sh
	echo "cd \"\$project_pach_id\"" >> tusara.sh
	echo "mkdir \"\$project_name_id\"" >> tusara.sh
	echo "cd \"\$project_name_id\"" >> tusara.sh
	echo "mkdir bin" >> tusara.sh
	echo "mkdir scr" >> tusara.sh
	echo " " >> tusara.sh
	echo "cp -p /home/\"\$USER\"/*tusara*/pattern/Main.java \"\$project_pach_id\"/\"\$project_name_id\"/scr" >> tusara.sh
	echo "cp -p /home/\"\$USER\"/*tusara*/pattern/manifest.mf \"\$project_pach_id\"/\"\$project_name_id\"/bin" >> tusara.sh
	echo "cp -p /home/\"\$USER\"/*tusara*/pattern/start.sh \"\$project_pach_id\"/\"\$project_name_id\"" >> tusara.sh
	echo "cp -p /home/\"\$USER\"/*tusara*/pattern/build.sh \"\$project_pach_id\"/\"\$project_name_id\"" >> tusara.sh
    echo "cp -p /home/\"\$USER\"/*tusara*/pattern/readme.txt \"\$project_pach_id\"/\"\$project_name_id\"" >> tusara.sh
	echo "echo \"\" > \"\$project_pach_id\"/\"\$project_name_id\"/bin/log.txt" >> tusara.sh
	
	chmod +x tusara.sh
}


uninstall(){
	echo "#!/bin/bash" >> uninstall.sh
	echo " " >> uninstall.sh
	echo "if test -f \"pattern/01001100111.txt\"; then" >> uninstall.sh
	echo "    cd .." >> uninstall.sh
	echo "    rm -R tusara*" >> uninstall.sh
	echo "    echo Программа удалена" >> uninstall.sh
	echo "else " >> uninstall.sh
	echo "    echo Не та папка" >> uninstall.sh
	echo "fi" >> uninstall.sh

	echo "" > pattern/01001100111.txt
	chmod +x uninstall.sh
}

readme(){
    echo """Если вы работаете с не одним файлом то строчки 11, 4, 6, 13 раскоментируйте их.
А 14, 11 закоментируйте

В build.sh разкоментируйте 12, 6
А закоментируйте 11

Для того чтобы добавить свои java файлы закидываете его к Main.java возвращаетесь к start.sh и build.sh.
Заходите в start.sh и в var (не var2) записываете все файлы через пробел.
В var2 записываете все таже имена но расширение меняете на .class

Идете в файл build.sh и записываете в var2 все теже файлы с расширением .class""" >> readme.txt
}

name_folder="tusara-2.0"
project_pach_id=""

# echo "Если вы в консоли с root правами, то пожалуйста введите exit и запустите заново."
read -e -p "Введите путь к директории в которую будет установлена программа: " project_pach_id

cd $project_pach_id

if [ $? -eq 0 ]; then
	if [ -e "$name_folder" ]; then
		echo "У вас уже установлена tusara (Возможно у вас просто есть папка с тем же именем)"
	else
		mkdir "$name_folder"
		cd "$name_folder"
		mkdir bin
		mkdir pattern
		uninstall
		cd pattern
		Main
		build
		start
		manifest
        readme
		cd ..
		cd bin
		java_creat
	fi
fi

