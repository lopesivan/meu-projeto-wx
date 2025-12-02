cmake_minimum_required(VERSION 3.16)
project(app)

# ----------------------------------------------------------------------
# Configurações básicas
# ----------------------------------------------------------------------
set(PROGRAM
    "app"
    CACHE STRING "Nome do executável")
# Define C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin)

# ----------------------------------------
# Opções de build para debug
# ----------------------------------------
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
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
add_executable(${PROGRAM} main.cpp)

# Linka com as bibliotecas do wxWidgets
target_link_libraries(${PROGRAM} ${wxWidgets_LIBRARIES})

add_custom_target(
  run
  COMMAND ./${PROGRAM}
  DEPENDS ${PROGRAM}
  WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

