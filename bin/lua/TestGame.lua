require "Application"
require "Scene"
require "Entity"

require "MainCamera"
require "MonaModel"
require "MantisModel"
require "MainLight"
require "FloorModel"
require "SkyBox"
require "ThirdPersonController"

local scene = {}    
local MainCamera = {}

App({name="Test", width = 1280, height = 720,
    onInit = function ()
        global.app:loadAsset("mantis/mantis.json")
        global.app:loadAsset("skybox/skybox.json")
        global.app:loadAsset("sand_cube/sand_cube.json")
        scene = Scene.new("LuaTestGame")
        MainCamera = CreateThirdPersonCamera(scene, 1280, 720)
        local main_camera_id = MainCamera.id
        CreateMantisModel(scene, main_camera_id)
        CreateSkyBox(scene, main_camera_id)
        local floor = CreateFloor(scene, main_camera_id)
        local MainLight = CreateMainLight(scene)
        local SubLight = CreateSubLight(scene)
        createPointLight(scene, glm.vec3(0, 1, 1), glm.vec3(0.5, 0.5, 0), 1)
        createPointLight(scene, glm.vec3(1, 0, 1), glm.vec3(-0.5, 0.5, 0), 2)
        scene:initScene()
    end,
    beforeUpdate = function()
        scene:beforeUpdate()
    end ,
    onUpdate = function(duration)
        scene:onUpdate(duration)
    end,
    afterUpdate = function()
        scene:afterUpdate()
        collectgarbage()
    end,
    onStop = function()
        scene:onStop()
        print("Lua : onStop")
    end,
    onWindowResize = function(width, height)
        if width == 0 or height == 0 then
            return
        end
        local camera = MainCamera:getComponent(PerspectiveCamera)
        camera:setAspect(width / height)
    end
})