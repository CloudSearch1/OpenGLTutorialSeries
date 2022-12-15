workspace "OpenGLTourial"
	startproject "Sandbox"
	architecture "x64"


	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include dirs relative to root folder (solution dir)
IncludeDir = {}
IncludeDir["GLFW"] = "OpenGLTourial/vendor/GLFW/include"
IncludeDir["Glad"] = "OpenGLTourial/vendor/Glad/include"
IncludeDir["glm"] = "OpenGLTourial/vendor/glm"

group "Dependencies"
	include "OpenGLTourial/vendor/GLFW"
	include "OpenGLTourial/vendor/Glad"

group ""

project "OpenGLTourial"
	location "OpenGLTourial"
	kind "StaticLib"
	cppdialect "C++17"
	language "C++"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	-- pchheader "gzpch.h"
	-- pchsource "Gazel/src/gzpch.cpp"

	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl"
	}

	includedirs{
		"%{prj.name}/src",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.glm}"
	}
	
	links{
		"GLFW",
		"Glad",
		"opengl32.lib"
	}

	filter "system:windows"
		systemversion "latest"
		
		defines
		{
			"OT_PLATFORM_WINDOWS",
			"OT_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}
		
	filter "configurations:Debug"
		defines "OT_DEBUG"
		buildoptions"/MDd"
		symbols "on"

	filter "configurations:Release"
		defines "OT_RELEASE"
		buildoptions"/MD"
		optimize "on"

	filter "configurations:Dist"
		defines "OT_DIST"
		buildoptions"/MD"
		optimize "on" 

project"Sandbox"
	location"Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime"on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
		
	}

	includedirs{
		"OpenGLTourial/src",
		"OpenGLTourial/vendor",
		"%{IncludeDir.glm}"
	}

	links{
		"OpenGLTourial"
	}

	filter "system:windows"
	
		staticruntime "On"
		systemversion "latest"
		
		defines
		{
			"OT_PLATFORM_WINDOWS"
		}
		
	filter "configurations:Debug"
		defines "OT_DEBUG"
		buildoptions"/MDd"
		symbols "on"

	filter "configurations:Release"
		defines "OT_RELEASE"
		buildoptions"/MD"
		optimize "on"

	filter "configurations:Dist"
		defines "OT_DIST"
		buildoptions"/MD"
		optimize "on"
