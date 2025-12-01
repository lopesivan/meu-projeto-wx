cmake_minimum_required(VERSION 3.10)

project(wx_app LANGUAGES CXX)

# ----------------------------------------------------------------------
# Configurações básicas
# ----------------------------------------------------------------------
set(PROGRAM
    "app"
    CACHE STRING "Nome do executável")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin)

# ----------------------------------------
# Opções de build para debug
# ----------------------------------------
set(CMAKE_VERBOSE_MAKEFILE ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Encontrar wxWidgets
find_package(wxWidgets REQUIRED COMPONENTS core base)

# Incluir macros do wxWidgets (somente se não usar modo CONFIG)
if(wxWidgets_USE_FILE)
  include(${wxWidgets_USE_FILE})
endif()

# ----------------------------------------------------------------------
# Flags de compilação
# ----------------------------------------------------------------------
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall")
set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")
set(CMAKE_CXX_FLAGS_RELEASE "-O3")

add_executable(${PROGRAM} main.cpp)
target_link_libraries(${PROGRAM} ${wxWidgets_LIBRARIES})

add_custom_target(
  run
  COMMAND ./${PROGRAM}
  DEPENDS ${PROGRAM}
  WORKING_DIRECTORY ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
