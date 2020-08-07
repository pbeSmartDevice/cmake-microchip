#=============================================================================
# Copyright 2020 Trifork
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file COPYING.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake-Microchip,
#  substitute the full License text for the above reference.)

# This module is loaded during the search for a C compiler
# to provide the information necessary to find one.

include(MicrochipPathSearch)
MICROCHIP_PATH_SEARCH(MICROCHIP_XC8_PATH xc8
    CACHE "the path to a Microchip XC8 installation"
)

if(NOT MICROCHIP_XC8_PATH)
    message(FATAL_ERROR
        "No Microchip XC8 compiler was found. Please provide the path"
        " to an XC8 installation on the command line, for example:\n"
        "    cmake -DMICROCHIP_XC8_PATH=/opt/microchip/xc8/v2.00 .."
    )
endif()

set(CMAKE_FIND_ROOT_PATH "${MICROCHIP_XC8_PATH}/avr")


# skip compiler search and just use XC8
find_program(CMAKE_C_COMPILER "avr-gcc"
    PATHS "${MICROCHIP_XC8_PATH}"
    PATH_SUFFIXES "bin"
)

if(NOT CMAKE_C_COMPILER)
    message(FATAL_ERROR
        "The avr-gcc compiler executable was not found, but what looks"
        " like an XC8 installation was found at:\n"
        "    ${MICROCHIP_XC8_PATH}\n"
        "Please provide the path to a working XC8 installation on the"
        " command line, for example:\n"
        "    cmake -DMICROCHIP_XC8_PATH=/opt/microchip/xc8/v2.00 .."
    )
endif()

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
