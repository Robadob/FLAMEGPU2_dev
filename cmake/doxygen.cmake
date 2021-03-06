# Doxygen
find_package(Doxygen OPTIONAL_COMPONENTS mscgen dia dot)
if(DOXYGEN_FOUND)
	option(BUILD_DOCUMENTATION "Enable building documentation (requires Doxygen)" ON)
else()
	if(CMAKE_CUDA_COMPILER STREQUAL NOTFOUND)
		message(FATAL_ERROR 
			" Doxygen: NOT FOUND!\n"
			" Documentation project cannot be generated.\n"
			" Please install Doxygen and re-run configure.")
	
	else()
		message( 
			" Doxygen: NOT FOUND!\n"
			" Documentation project cannot be generated.\n"
			" Please install Doxygen and re-run configure if required.")
	endif()
endif()

macro(create_doxygen_target DOXY_OUT_DIR)
	if(BUILD_DOCUMENTATION)
		if(DOXYGEN_FOUND)
			# Modern method which generates unique doxyfile
			# These args taken from readme.md at time of commit
			set(DOXYGEN_OUTPUT_DIRECTORY "${DOXY_OUT_DIR}")
			set(DOXYGEN_PROJECT_NAME "FLAMEGPU 2.0")
			set(DOXYGEN_PROJECT_NUMBER "")
			set(DOXYGEN_PROJECT_BRIEF "Expansion of FLAMEGPU to provide middle-ware for complex systems simulations to utilise CUDA.")
			set(DOXYGEN_GENERATE_LATEX        NO)
			set(DOXYGEN_EXTRACT_ALL           YES)
			set(DOXYGEN_CLASS_DIAGRAMS        YES)
			set(DOXYGEN_HIDE_UNDOC_RELATIONS  NO)
			set(DOXYGEN_CLASS_GRAPH           YES)
			set(DOXYGEN_COLLABORATION_GRAPH   YES)
			set(DOXYGEN_UML_LOOK              YES)
			set(DOXYGEN_UML_LIMIT_NUM_FIELDS  50)
			set(DOXYGEN_TEMPLATE_RELATIONS    YES)
			set(DOXYGEN_DOT_GRAPH_MAX_NODES   100)
			set(DOXYGEN_MAX_DOT_GRAPH_DEPTH   0)
			set(DOXYGEN_DOT_TRANSPARENT       NO)
			set(DOXYGEN_CALL_GRAPH            YES)
			set(DOXYGEN_CALLER_GRAPH          YES)
			set(DOXYGEN_GENERATE_TREEVIEW     YES)
			set(DOXYGEN_HTML_OUTPUT           docs)
			set(DOXYGEN_DOT_IMAGE_FORMAT      png) # can be  svg, but the add --> DOXYGEN_INTERACTIVE_SVG      = YES
			set(DOXYGEN_EXTRACT_PRIVATE       YES)
			set(DOXYGEN_EXTRACT_STATIC        YES)
			set(DOXYGEN_EXTRACT_LOCAL_METHODS NO)
			# These are required for expanding FGPUException definition macros to be documented
			set(DOXYGEN_ENABLE_PREPROCESSING  YES)
			set(DOXYGEN_MACRO_EXPANSION       YES)
			set(DOXYGEN_EXPAND_ONLY_PREDEF    YES)
			set(DOXYGEN_PREDEFINED            "DERIVED_FGPUException(name,default_msg)=class name: public FGPUException { public: explicit name(const char *format = default_msg)\; }")
			# Create doxygen target
			doxygen_add_docs("docs" 
				"${FLAMEGPU_ROOT}/include;${FLAMEGPU_ROOT}/src;${FLAMEGPU_ROOT}/README.md" 
			)
			set_target_properties("docs" PROPERTIES EXCLUDE_FROM_ALL TRUE)
			if(COMMAND CMAKE_SET_TARGET_FOLDER)
				# Put within FLAMEGPU filter
				CMAKE_SET_TARGET_FOLDER("docs" "FLAMEGPU")
			endif()
		endif()
    endif()    
endmacro()
