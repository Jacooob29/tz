# ТЗ1: Bash-скрипт для копирования файлов

Этот скрипт на bash позволяет переместить файлы из входной директории в выходную без сохранения иерархии, пронумеровав файлы с одинкаовыми названиями. *Если выходной директории не существует, то скрипт выведет ошибку.*

## Использование

1. **Клонирование репозитория:**

    ```bash
    git clone https://github.com/Jacooob29/tz_1.git
    ```

2. **Запуск скрипта:**

    Перейдите в каталог с клонированным репозиторием и выполните:

    ```bash
    bash copy.sh <входная_директория> <выходная_директория>
    ```
    
3. **Пример:**

   ```bash
    bash copy.sh /path/to/input_directory /path/to/output_directory
    ```
## Тестирование
В репозитории содержится папка, которая имитирует сложную файловую структуру.
Здесь в директории inp_dir содержатся папки a, b, c. Где папка a пустая, папка b содержит 3.txt, 5.txt, папка c содержит 3.txt. Также вне этих папок в самой директории присутствуют файлы 1.txt, 4.txt.
```
inp_dir:
1.txt
4.txt
a:
b:
    3.txt
    5.txt
c:
    3.txt
```
После запуска 

```bash
bash copy.sh ./inp_dir ./out_dir
```
В директорию out_dir скопируются файл как показано ниже:

```
out_dir:
1.txt
3.txt
3-1.txt
4.txt
5.txt
```

## Решение
```Bash
#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_dir> <output_dir>"
    exit 1
fi

input_dir="$1"
output_dir="$2"

if [ ! -d "$input_dir" ]; then
    echo "Source directory does not exist: $input_dir"
    exit 1
fi

if [ ! -d "$output_dir" ]; then
    echo "Output directory does not exist: $output_dir"
    exit 1
fi

files=$(find "$input_dir" -maxdepth 1 -type f)

dirs=$(find "$input_dir" -mindepth 1 -type d)

all_files=$(find "$input_dir" -type f)

find "$input_dir" -type f | \
    while read -r file; do
        file_extension=$(echo "$file" | awk -F. '{print $NF}')
        file_basename=$(basename "$file")
        cp "$file" "$output_dir/$file_basename"
        echo "Copied $file to $output_dir/$file_basename"
    done

echo "Files moved successfully."
```

## Автор

Князев Яков (ВШЭ, бизнес-информатика, 1 курс, 232)
