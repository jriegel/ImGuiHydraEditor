cmake_minimum_required(VERSION 3.12)

project(ImGuiHydraEditor VERSION 0.0.1 DESCRIPTION "ImGui Hydra Editor")


set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(pxr REQUIRED)
find_package(OpenGL REQUIRED)
find_package(imgui CONFIG REQUIRED)
find_package(imguizmo CONFIG REQUIRED)
find_package(glfw3 CONFIG REQUIRED)
find_package(GLEW CONFIG REQUIRED)



if(WIN32)
	message("Building for Windows: disabling min/max macros from minwin.h which collide with OpenUSD max member function in robin_growth_policy.h")
	add_compile_definitions(NOMINMAX)
	add_compile_definitions(USE_STD_FILESYSTEM)
endif()

file(GLOB SRC_CPP
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  "src/*.cpp"
  "src/layouts/*.cpp"
  "src/models/*.cpp"
  "src/sceneindices/*.cpp"
  "src/style/*.cpp"
  "src/views/*.cpp"
  "src/filedialog/*.cpp"
  "src/texteditor/*.cpp"
  "src/backends/*.cpp"
)

file(GLOB SRC_H
  RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
  "src/*.h"
  "src/layouts/*.h"
  "src/models/*.h"
  "src/sceneindices/*.h"
  "src/style/*.h"
  "src/views/*.h"
  "src/backends/*.h"
  "src/filedialog/*.h"
  "src/texteditor/*.h"
)


add_executable(ImGuiHydraEditor ${SRC_CPP} ${SRC_H})

target_include_directories(ImGuiHydraEditor
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

target_link_libraries(ImGuiHydraEditor
    PRIVATE
        imgui::imgui
        imguizmo::imguizmo
        
        OpenGL::GL
        glfw
        GLEW::GLEW
        ar
	    arch
	    gf
	    js
	    kind
	    #ndr
	    pcp
	    plug
	    sdf
	    sdr
	    tf
	    trace
	    usd
	    usdGeom
	    usdHydra
	    usdLux
	    usdMedia
	    usdPhysics
	    usdRender
	    usdShade
	    usdSkel
	    usdUI
	    usdUtils
	    usdVol
        usdProc
        usdRi
        usdSkel
	    vt
	    work
		hd
		hdx
		glf
		garch 
		hio
        hf
		hgiGL
		hgiInterop
		hdar
		hdGp
		usdImaging
		usdImagingGL
		usdRiPxrImaging
		usdProcImaging

)

include_directories(ImGuiHydraEditor PRIVATE ${pxr_INCLUDE_DIRS} ${imgui_INCLUDE_DIRS})

add_custom_command(TARGET ImGuiHydraEditor
	POST_BUILD

	#### Copy the required plugins to the binary directory. ####
	#### Mandatory for the application to run. ####
	COMMAND ${CMAKE_COMMAND} -E make_directory "${CMAKE_BINARY_DIR}/${TargetName}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:RelWithDebInfo>:RelWithDebInfo>$<$<CONFIG:Release>:/Release>/usd/"
	COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different "${CMAKE_BINARY_DIR}/vcpkg_installed/x64-windows/bin/usd" "${CMAKE_BINARY_DIR}/${TargetName}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:RelWithDebInfo>:RelWithDebInfo>$<$<CONFIG:Release>:/Release>/usd/"
	COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different "${CMAKE_BINARY_DIR}/vcpkg_installed/x64-windows/plugin/usd" "${CMAKE_BINARY_DIR}/${TargetName}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:RelWithDebInfo>:RelWithDebInfo>$<$<CONFIG:Release>:/Release>/usd/"
	
	#base plugin file
	COMMAND ${CMAKE_COMMAND} -E copy_if_different "${CMAKE_BINARY_DIR}/vcpkg_installed/x64-windows/lib/usd/plugInfo.json" "${CMAKE_BINARY_DIR}/${TargetName}/$<$<CONFIG:Debug>:Debug>$<$<CONFIG:RelWithDebInfo>:RelWithDebInfo>$<$<CONFIG:Release>:/Release>/usd/"
	

)