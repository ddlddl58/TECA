set(CTEST_SITE "Travis_CI")
set(CTEST_BUILD_NAME "Ubuntu_14.04_LTS_$ENV{TRAVIS_BRANCH}_$ENV{SHA}")
set(CTEST_DASHBOARD_ROOT "$ENV{DASHROOT}")
set(CTEST_BUILD_CONFIGURATION $ENV{BUILD_TYPE})
set(CTEST_TEST_ARGS PARALLEL_LEVEL 1)
set(CTEST_BUILD_FLAGS -j4)
set(CTEST_CMAKE_GENERATOR "Unix Makefiles")
set(CTEST_PROJECT_NAME "TECA")
set(CTEST_NOTES_FILES)
set(ALWAYS_UPDATE ON)
set(INCREMENTAL_BUILD OFF)
set(DASHBOARD_TRACK "Continuous")
set(DATA_ROOT "${CTEST_DASHBOARD_ROOT}/TECA_data")
set(CTEST_SOURCE_DIRECTORY "${CTEST_DASHBOARD_ROOT}")
set(CTEST_BINARY_DIRECTORY "${CTEST_DASHBOARD_ROOT}/build")
set(CTEST_TEST_TIMEOUT 600)
set(INITIAL_CACHE
"CMAKE_C_COMPILER=$ENV{CC}
CMAKE_CXX_COMPILER=$ENV{CXX}
CMAKE_Fortran_COMPILER=$ENV{FC}
CMAKE_BUILD_TYPE=$ENV{BUILD_TYPE}
BUILD_TESTING=ON
TECA_PYTHON_VERSION=2
TECA_DATA_ROOT=$ENV{DASHROOT}/TECA_data
TECA_TEST_CORES=2")
file(WRITE "${CTEST_BINARY_DIRECTORY}/CMakeCache.txt" ${INITIAL_CACHE})
ctest_start("${DASHBOARD_TRACK}")
ctest_configure()
ctest_read_custom_files("${CTEST_BINARY_DIRECTORY}")
ctest_build()
ctest_submit(PARTS Update Configure Build Notes RETRY_DELAY 15 RETRY_COUNT 10)
ctest_test()
ctest_submit(PARTS Test RETRY_DELAY 15 RETRY_COUNT 10)
