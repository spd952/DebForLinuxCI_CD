#!/bin/bash
set -e

# Параметры
PACKAGE_NAME="untitled1"
VERSION="1.0.0"
ARCH="amd64"
MAINTAINER="Your Name <your.email@example.com>"
DESCRIPTION="Program for finding maximum value in array"

# Пути
BUILD_DIR="build"                 # где лежит скомпилированный бинарник
BINARY_PATH="$BUILD_DIR/untitled1"
DEB_ROOT="deb_root"               # временная папка для сборки пакета

# ------------------------------------------------------------
# 1. Проверка наличия необходимых инструментов в системе
# ------------------------------------------------------------
echo "🔍 Проверка зависимостей сборки..."

MISSING_TOOLS=""

check_command() {
    if ! command -v "$1" &> /dev/null; then
        echo "  ❌ $1 не найден"
        MISSING_TOOLS="$MISSING_TOOLS $1"
    else
        echo "  ✅ $1 найден"
    fi
}

check_command cmake
check_command make
check_command dpkg-deb

# Проверка компилятора C++ (g++ или clang++)
if ! command -v g++ &> /dev/null && ! command -v clang++ &> /dev/null; then
    echo "  ❌ Компилятор C++ (g++ или clang++) не найден"
    MISSING_TOOLS="$MISSING_TOOLS g++"
else
    echo "  ✅ Компилятор C++ найден"
fi

if [ -n "$MISSING_TOOLS" ]; then
    echo ""
    echo "❌ Отсутствуют необходимые инструменты:$MISSING_TOOLS"
    echo "Пожалуйста, установите их:"
    echo "  Ubuntu/Debian: sudo apt install cmake make dpkg-dev g++"
    echo "  Fedora:        sudo dnf install cmake make dpkg gcc-c++"
    exit 1
fi

echo ""

# ------------------------------------------------------------
# 2. Проверка, что программа уже скомпилирована
# ------------------------------------------------------------
if [ ! -f "$BINARY_PATH" ]; then
    echo "⚠️  Бинарный файл не найден. Выполняется cmake и make..."
    if [ ! -d "$BUILD_DIR" ]; then
        mkdir -p "$BUILD_DIR"
        (cd "$BUILD_DIR" && cmake ..)
    else
        (cd "$BUILD_DIR" && cmake ..)
    fi
    (cd "$BUILD_DIR" && make)
    echo "✅ Сборка завершена"
fi

# ------------------------------------------------------------
# 3. Создание структуры пакета
# ------------------------------------------------------------
rm -rf "$DEB_ROOT"
mkdir -p "$DEB_ROOT/usr/local/bin"
mkdir -p "$DEB_ROOT/DEBIAN"

# Копирование программы
cp "$BINARY_PATH" "$DEB_ROOT/usr/local/bin/"
chmod 755 "$DEB_ROOT/usr/local/bin/untitled1"

# ------------------------------------------------------------
# 4. Создание control-файла с зависимостями
# ------------------------------------------------------------
cat > "$DEB_ROOT/DEBIAN/control" <<EOF
Package: $PACKAGE_NAME
Version: $VERSION
Section: utils
Priority: optional
Architecture: $ARCH
Depends: libc6 (>= 2.28), libstdc++6 (>= 9)
Maintainer: $MAINTAINER
Description: $DESCRIPTION
 This program reads an array of integers and outputs the maximum value.
 Built with CMake and packaged with dpkg-deb.
EOF

# ------------------------------------------------------------
# 5. Сборка .deb пакета
# ------------------------------------------------------------
DEB_FILENAME="${PACKAGE_NAME}_${VERSION}_${ARCH}.deb"
dpkg-deb --build "$DEB_ROOT" "$DEB_FILENAME"

# ------------------------------------------------------------
# 6. Информация о зависимостях и установке
# ------------------------------------------------------------
echo ""
echo "✅ Пакет создан: $DEB_FILENAME"
echo ""
echo "═══════════════════════════════════════════════════════════"
echo "📦 Зависимости пакета (будут автоматически установлены при необходимости):"
echo "   • libc6      (стандартная библиотека C)"
echo "   • libstdc++6 (стандартная библиотека GNU C++)"
echo ""
echo "▶️  Чтобы установить пакет на чистую систему:"
echo "   sudo dpkg -i $DEB_FILENAME"
echo "   sudo apt-get install -f   # для подтягивания недостающих зависимостей"
echo ""
echo "▶️  Или использовать apt напрямую:"
echo "   sudo apt install ./$DEB_FILENAME"
echo "═══════════════════════════════════════════════════════════"

# Очистка временной папки (опционально)
rm -rf "$DEB_ROOT"
