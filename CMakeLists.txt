cmake_minimum_required(VERSION 3.16)
project(app)

# Define C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Caminho para a instalação do wxWidgets
#set(wxWidgets_ROOT_DIR "$ENV{HOME}/.local/wxwidgets/linux-cmake-wx-3.3.1")

# Define o caminho do wxWidgets_CONFIG_EXECUTABLE
set(wxWidgets_CONFIG_EXECUTABLE "${wxWidgets_ROOT_DIR}/bin/wx-config")

# Encontra o wxWidgets
find_package(wxWidgets REQUIRED COMPONENTS core base)

if(wxWidgets_FOUND)
    message(STATUS "wxWidgets encontrado!")
    message(STATUS "  Versão: ${wxWidgets_VERSION}")
    message(STATUS "  Libs: ${wxWidgets_LIBRARIES}")
    message(STATUS "  Include dirs: ${wxWidgets_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "wxWidgets não encontrado!")
endif()

# Inclui os diretórios do wxWidgets
include(${wxWidgets_USE_FILE})

# Adiciona o executável
add_executable(app main.cpp)

# Linka com as bibliotecas do wxWidgets
target_link_libraries(app ${wxWidgets_LIBRARIES})
