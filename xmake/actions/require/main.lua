--!The Make-like Build Utility based on Lua
--
-- Licensed to the Apache Software Foundation (ASF) under one
-- or more contributor license agreements.  See the NOTICE file
-- distributed with this work for additional information
-- regarding copyright ownership.  The ASF licenses this file
-- to you under the Apache License, Version 2.0 (the
-- "License"); you may not use this file except in compliance
-- with the License.  You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
-- 
-- Copyright (C) 2015 - 2017, TBOOX Open Source Group.
--
-- @author      ruki
-- @file        main.lua
--

-- imports
import("core.base.option")
import("core.project.config")
import("core.project.project")
import("core.platform.platform")
import("package")
import("repository")

--
-- the default repositories:
--     xmake-repo https://github.com/tboox/xmake-repo.git
--
-- add other repositories:
--     xmake repo --add other-repo https://github.com/other/other-repo.git
-- or
--     add_repositories("other-repo https://github.com/other/other-repo.git")
--
-- add requires:
--
--     add_requires("tboox.tbox >=1.5.1", "zlib >=1.2.11")
--     add_requires("zlib master")
--     add_requires("xmake-repo@tboox.tbox >=1.5.1")
--     add_requires("https://github.com/tboox/tbox.git@tboox.tbox >=1.5.1")
--
-- add package dependencies:
--
--     target("test")
--         add_packages("tboox.tbox", "zlib")
--

-- load project
function _load_project()

    -- enter project directory
    os.cd(project.directory())

    -- load config
    config.load()

    -- load platform
    platform.load(config.plat())

    -- load project
    project.load()
end

-- install and update all outdated package dependencies
function _install(requires)

    -- install packages
    package.install_packages(requires)
end

-- clear all installed package caches
function _clear()

    -- clear all caches
    package.clear_caches()
end

-- search for the given packages from repositories
function _search(packages)
    -- TODO
end

-- show the given package info
function _info(packages)
    -- TODO
end

-- list all package dependencies
function _list()

    -- list all requires
    print("Tha package dependencies:")
    for packagename, requireinfo in pairs(package.load_requires(project.requires())) do
        print("    %s %s", packagename, requireinfo.version)
    end
end

-- main
function main()

    -- load project first
    _load_project()

    -- clear all installed packages cache
    if option.get("clear") then

        _clear(option.get("global"))

    -- search for the given packages from repositories
    elseif option.get("search") then

        _search(option.get("packages"))

    -- show the given package info
    elseif option.get("info") then

        _info(option.get("packages"))

    -- list all package dependencies
    elseif option.get("list") then

        _list()

    -- install and update all outdated package dependencies by default if no arguments
    else
        _install(option.get("requires"))
    end
end

