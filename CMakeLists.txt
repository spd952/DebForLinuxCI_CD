cmake_minimum_required(VERSION 3.10)
project(tests VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Основное приложение
add_executable(tests src/main.cpp)

# Тесты
add_executable(test1 cicd/test1.cpp)
add_executable(test2 cicd/test2.cpp)
add_executable(test3 cicd/test3.cpp)

# Цель для запуска всех тестов
add_custom_target(test
    COMMAND test1
    COMMAND test2
    COMMAND test3
    DEPENDS test1 test2 test3
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Running all tests"
)

# Цель для сборки .deb (упрощённая)
add_custom_target(package
    COMMAND ${CMAKE_COMMAND} -E tar czf maxfinder_1.0.0_amd64.deb --format=gnutar -- 
    COMMAND echo "Create .deb manually or use a script"
    DEPENDS maxfinder
    COMMENT "Building .deb package"
)
