#!/bin/bash

# Выход при любой ошибке
set -e

# Параметр: путь к выходному .deb файлу (например, "../latin-checker_1.0_amd64.deb")
OUTPUT_DEB="$1"

if [ -z "$OUTPUT_DEB" ]; then
    echo "Ошибка: не указан путь к выходному .deb файлу"
    echo "Использование: $0 <path/to/package.deb>"
    exit 1
fi

# Определяем корень репозитория (на уровень выше cicd)
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BINARY_PATH="$REPO_ROOT/usr/bin/latin-checker"

# Проверяем существование бинарника
if [ ! -f "$BINARY_PATH" ]; then
    echo "Ошибка: бинарник не найден по пути $BINARY_PATH"
    exit 1
fi

# Убеждаемся, что бинарник исполняемый
chmod +x "$BINARY_PATH"

# Создаём временную структуру пакета
PACKAGE_DIR="latin-checker_1.0_amd64"
mkdir -p "$PACKAGE_DIR/DEBIAN"
mkdir -p "$PACKAGE_DIR/usr/bin"

# Копируем бинарник
cp "$BINARY_PATH" "$PACKAGE_DIR/usr/bin/"

# Создаём control-файл
cat > "$PACKAGE_DIR/DEBIAN/control" <<EOF
Package: latin-checker
Version: 1.0
Architecture: amd64
Maintainer: Your Name <your.email@example.com>
Description: Latin text checker
 A tool for checking Latin texts.
EOF

# Собираем .deb пакет
dpkg-deb --build "$PACKAGE_DIR" "$OUTPUT_DEB"

echo "Пакет успешно создан: $OUTPUT_DEB"
