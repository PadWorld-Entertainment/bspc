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

	aas_areamerging.c
	aas_cfg.c
	aas_create.c
	aas_edgemelting.c
	aas_facemerging.c
	aas_file.c
	aas_gsubdiv.c
	aas_map.c
	aas_prunenodes.c
	aas_store.c
	be_aas_bspc.c
	brushbsp.c
	bspc.c
	csg.c
	glfile.c
	l_bsp_ent.c
	l_bsp_hl.c
	l_bsp_q1.c
	l_bsp_q2.c
	l_bsp_q3.c
	l_bsp_sin.c
	l_cmd.c
	l_log.c
	l_math.c
	l_mem.c
	l_poly.c
	l_qfiles.c
	l_threads.c
	l_utils.c
	leakfile.c
	map.c
	map_hl.c
	map_q1.c
	map_q2.c
	map_q3.c
	map_sin.c
	nodraw.c
	portals.c
	textures.c
	tree.c
)
if (UNIX)
	add_compile_options(-Wall -Wextra -pedantic -Wno-unused-parameter -Wno-format-overflow -Wno-cast-function-type)
endif()
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -g -O3 -ffast-math -DNDEBUG")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g -O0 -ffast-math -DDEBUG")

add_executable(${PROJECT_NAME} ${SRCS})
target_include_directories(${PROJECT_NAME} PRIVATE . deps deps/expat-2.2.10)
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads m)
target_compile_definitions(${PROJECT_NAME} PRIVATE -DMAC_STATIC= -DQDECL= -DBSPC -D_FORTIFY_SOURCE=2 -Dstricmp=strcasecmp -DCom_Memcpy=memcpy -DCom_Memset=memset)
if (APPLE)
	target_compile_definitions(${PROJECT_NAME} PRIVATE -DHAVE_ARC4RANDOM -DLINUX)
else(UNIX)
	target_compile_definitions(${PROJECT_NAME} PRIVATE -DHAVE_GETRANDOM -DLINUX)
endif()
