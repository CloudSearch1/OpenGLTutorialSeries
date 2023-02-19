workspace "OpenGLTourial"
	startproject "OpenGLTourial"
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
IncludeDir["Glad"] = "OpenGLTourial/vendor/Glad/include"
IncludeDir["GLFW"] = "OpenGLTourial/vendor/GLFW/include"
IncludeDir["glm"] = "OpenGLTourial/vendor/glm"


group "Dependencies"
	include "OpenGLTourial/vendor/Glad"
	include "OpenGLTourial/vendor/GLFW"
group ""

project "OpenGLTourial"
	location "OpenGLTourial"
	kind "ConsoleApp"
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

