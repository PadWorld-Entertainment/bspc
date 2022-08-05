cmake_minimum_required(VERSION 3.12)

project(bspcwop C)

set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)

set(SRCS
	deps/expat-2.2.10/xmlparse.c
	deps/expat-2.2.10/xmltok.c
	deps/expat-2.2.10/xmlrole.c

	deps/botlib/be_aas_bspq3.c
	deps/botlib/be_aas_cluster.c
	deps/botlib/be_aas_move.c
	deps/botlib/be_aas_optimize.c
	deps/botlib/be_aas_reach.c
	deps/botlib/be_aas_sample.c
	deps/botlib/l_libvar.c
	deps/botlib/l_precomp.c
	deps/botlib/l_script.c
	deps/botlib/l_struct.c

	deps/qcommon/cm_load.c
	deps/qcommon/cm_patch.c
	deps/qcommon/cm_test.c
	deps/qcommon/cm_trace.c
	deps/qcommon/md4.c
	deps/qcommon/unzip.c

	code/aas_areamerging.c
	code/aas_cfg.c
	code/aas_create.c
	code/aas_edgemelting.c
	code/aas_facemerging.c
	code/aas_file.c
	code/aas_gsubdiv.c
	code/aas_map.c
	code/aas_prunenodes.c
	code/aas_store.c
	code/be_aas_bspc.c
	code/brushbsp.c
	code/bspc.c
	code/csg.c
	code/glfile.c
	code/l_bsp_ent.c
	code/l_bsp_q3.c
	code/l_cmd.c
	code/l_log.c
	code/l_math.c
	code/l_mem.c
	code/l_poly.c
	code/l_qfiles.c
	code/l_threads.c
	code/l_utils.c
	code/leakfile.c
	code/map.c
	code/map_q3.c
	code/nodraw.c
	code/portals.c
	code/textures.c
	code/tree.c
)
if (UNIX)
	add_compile_options(-Wall -Wextra -pedantic -Wno-sign-compare -Wno-unused-parameter -Wno-format-overflow -Wno-cast-function-type)
endif()
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -g -O3 -ffast-math -DNDEBUG")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g -O0 -ffast-math -DDEBUG")

add_executable(${PROJECT_NAME} ${SRCS})
target_include_directories(${PROJECT_NAME} PRIVATE code deps deps/expat-2.2.10)
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads m)
target_compile_definitions(${PROJECT_NAME} PRIVATE -DMAC_STATIC= -DQDECL= -DBSPC -D_FORTIFY_SOURCE=2 -Dstricmp=strcasecmp -DCom_Memcpy=memcpy -DCom_Memset=memset)
if (APPLE)
	target_compile_definitions(${PROJECT_NAME} PRIVATE -DHAVE_ARC4RANDOM -DLINUX)
elseif(UNIX)
	target_compile_definitions(${PROJECT_NAME} PRIVATE -DHAVE_GETRANDOM -DLINUX)
endif()
