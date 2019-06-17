cmake_minimum_required(VERSION 3.1)

find_package(ECM REQUIRED NO_MODULE)

# Needed by find_package(KF5Plasma) below.
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH} ${ECM_KDE_MODULE_DIR} ${CMAKE_MODULE_PATH})

# Locate plasma_install_package macro.
find_package(KF5Plasma REQUIRED)

# Add target ("make install").
plasma_install_package(plasmoid org.shelladdicted.holestats)

# Add target ("make show")
add_custom_target(show COMMAND plasmoidviewer --applet . WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/plasmoid)