
# This must be set before the project() call
# see: https://cmake.org/cmake/help/latest/variable/CMAKE_OSX_DEPLOYMENT_TARGET.html
# FORCE must be set, see https://stackoverflow.com/a/44340246
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.14" CACHE STRING "Support macOS down to Mojave" FORCE)

# Audio Units must include an x86_64 slice to load in Intel hosts or hosts
# running under Rosetta on Apple Silicon. Release/packaging keeps this ON;
# dev/test builds can pass -DPAMPLEJUCE_UNIVERSAL=OFF to skip the x86_64 slice
# and roughly halve compile time on Apple Silicon.
option(PAMPLEJUCE_UNIVERSAL "Build universal arm64+x86_64 macOS binaries" ON)
if (APPLE AND NOT (CMAKE_SYSTEM_NAME STREQUAL "iOS"))
    if (PAMPLEJUCE_UNIVERSAL)
        message("Building universal macOS binaries for Apple Silicon and x86_64")
        set(CMAKE_OSX_ARCHITECTURES arm64 x86_64 CACHE STRING "Build universal macOS binaries" FORCE)
    else ()
        message("Building single-arch (host) macOS binaries — dev mode")
    endif ()
endif ()

# By default we don't want Xcode schemes to be made for modules, etc
set(CMAKE_XCODE_GENERATE_SCHEME OFF)
