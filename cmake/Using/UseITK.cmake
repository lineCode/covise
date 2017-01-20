MACRO(USE_ITK)
SET(ITK_FIND_QUIETLY TRUE)
SET(ITK_FIND_REQUIRED FALSE)
COVISE_FIND_PACKAGE(ITK)
IF(ITK_FOUND)
  INCLUDE(${ITK_USE_FILE})
  IF(WIN32)
	#IF(CMAKE_BUILD_TYPE STREQUAL "Debug")
		SET(ITK_LIBRARIES_DEBUG )
		SET(ITK_LIBRARIES_TMP "${ITK_LIBRARIES}")
		SET(ITK_LIBRARIES_COMPLETE )
		WHILE(ITK_LIBRARIES_TMP)
		    LIST(GET ITK_LIBRARIES_TMP 0 ITK_LIBRARY)
			IF (${ITK_LIBRARY}_LIB_DEPENDS)
				LIST(APPEND ITK_LIBRARIES_COMPLETE ${${ITK_LIBRARY}_LIB_DEPENDS})
				LIST(APPEND ITK_LIBRARIES_TMP ${${ITK_LIBRARY}_LIB_DEPENDS})
			ENDIF (${ITK_LIBRARY}_LIB_DEPENDS)
			LIST(REMOVE_AT ITK_LIBRARIES_TMP 0)
		ENDWHILE(ITK_LIBRARIES_TMP)
		
		FOREACH(ITK_LIBRARY ${ITK_LIBRARIES_COMPLETE})
			STRING(REGEX REPLACE "[iI][tT][kK](.*)"
					"itk\\1d" ITK_LIBRARY_DEBUG
					"${ITK_LIBRARY}")
         IF(MINGW)
            LIST(APPEND ITK_LIBRARIES_DEBUG optimized ${ITK_LIBRARY} debug ${ITK_LIBRARY})
         ELSE()
            LIST(APPEND ITK_LIBRARIES_DEBUG optimized ${ITK_LIBRARY} debug ${ITK_LIBRARY_DEBUG})
         ENDIF()
		ENDFOREACH(ITK_LIBRARY)
		SET(ITK_LIBRARIES "${ITK_LIBRARIES_DEBUG}")
	#ENDIF(CMAKE_BUILD_TYPE STREQUAL "Debug")
  ENDIF(WIN32)
  if (CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
     SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-deprecated-register")
  endif()
ELSE(ITK_FOUND)
  USING_MESSAGE("Skipping since ITK was not found! Please set ITK_DIR if you have it.")
  RETURN()
ENDIF(ITK_FOUND)
ENDMACRO(USE_ITK)
