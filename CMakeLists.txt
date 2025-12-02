cmake_minimum_required(VERSION 3.16)
project(app)

# Configurações básicas
set(PROGRAM "app" CACHE STRING "Nome do executável")
set(WX_VERSION "3.3.1" CACHE STRING "Versão do wxWidgets")
set(WX_DIR "$ENV{HOME}/.local/wxwidgets/linux-cmake-wx-${WX_VERSION}" CACHE PATH "Diretório do wxWidgets")

# Padrão C++
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin)

# ----------------------------------------
# Opções de build para debug
# ----------------------------------------
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Verificar wx-config
set(WX_CONFIG "${WX_DIR}/bin/wx-config")
if(NOT EXISTS ${WX_CONFIG})
    message(FATAL_ERROR "wx-config não encontrado: ${WX_CONFIG}")
endif()

# Obter configurações do wxWidgets
execute_process(COMMAND
    ${WX_CONFIG} --cxxflags
    OUTPUT_VARIABLE WX_CXXFLAGS
    OUTPUT_STRIP_TRAILING_WHITESPACE)
execute_process(COMMAND
    ${WX_CONFIG} --libs core,base
    OUTPUT_VARIABLE WX_LIBS
    OUTPUT_STRIP_TRAILING_WHITESPACE)

# Configurar flags de compilação
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${WX_CXXFLAGS} -Wall")
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

# RPATH para encontrar libs do wxWidgets
set(CMAKE_BUILD_RPATH   "${WX_DIR}/lib")
set(CMAKE_INSTALL_RPATH "${WX_DIR}/lib")

# Criar executável
file(GLOB SRCS "*.cpp")
add_executable(${PROGRAM} ${SRCS})
target_link_libraries(${PROGRAM} ${WX_LIBS})

# Target para executar
add_custom_target(
    run COMMAND ./${PROGRAM}
    DEPENDS ${PROGRAM}
    WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})

# ----------------------------------------------------------------------
# Status
# ----------------------------------------------------------------------
message(STATUS "Programa: ${PROGRAM}")
message(STATUS "Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "wxWidgets: ${WX_DIR}")


