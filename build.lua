local lfs = require("lfs")

local payload_dir = "src"
local build_dir = "build"
local love2d_dir = "love2d"

local love2d_bin = build_dir .. "/bin/love"
local payload = "codenameshape.love"
local output = "codenameshape"

local buildType = "Debug"
local platform = os.getenv("OS") or io.popen("uname"):read("*l")

print(platform)

function build_love2d()
	os.execute("git submodule update --init --recursive")
	os.execute("cmake love2d -B build -DCMAKE_BUILD_TYPE=" .. buildType)
	os.execute("cmake --build build")
end

function generate_payload(buildEnv)
	if(buildEnv == "Windows_NT")
	then
		print("Please zip the src/ folder as " .. payload .. " for now")
	end
	local cmd = string.format('cd %s && zip -r ../%s .', payload_dir, payload)
	os.execute(cmd)
end

function concat(buildEnv)
	if(buildEnv == "FreeBSD")
	then
		love2d_bin = io.popen("which love"):read("*l") print(love2d_bin)
	end

	local in1 = assert(io.open(love2d_bin, "rb"))
	local in2 = assert(io.open(payload, "rb"))
	local out = assert(io.open(output, "wb"))

	out:write(in1:read("*a"))
	out:write(in2:read("*a"))

	in1:close()
	in2:close()
	out:close()
end

function build(buildEnv)
	generate_payload(buildEnv)
	if(buildEnv ~= "FreeBSD") -- FreeBSD requires some fixing for now
	then
		build_love2d()
	end
	concat(buildEnv)
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
