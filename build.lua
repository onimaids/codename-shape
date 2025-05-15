local lfs = require("lfs")
local zip = require("brimworks.zip")

local payload_dir = "src"
local build_dir = "build"
local love2d_build = build_dir .. "love2d"

local love2d_dir = "love2d"
local love2d_out = "codenameshape.love"
local payload = "payload"
local output = "codenameshape"

local buildType = "Debug"
local platform = os.getenv("OS") or io.popen("uname"):read("*l") print(buildEnv)

function build_love2d()
	os.execute("git submodule update --init --recursive")
	os.execute("cmake love2d -B build -DCMAKE_BUILD_TYPE=" .. buildType)
	os.execute("cmake --build build")
end

function generate_payload()
end

function concat()
end

function build(buildEnv)
	--if(buildEnv != "Windows_NT")
	--then
	build_love2d()
	generate_payload()
	concat()
	--end
end

function main()
	lfs.rmdir(build_dir)
	local success,err = lfs.mkdir(build_dir)

	if not success then
		print("Error: " .. err)
	end

	build(platform)
end

main()
