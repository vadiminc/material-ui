--[[
    A loosely based Material UI module

    mui-navbar.lua : This is for creating navigation bars.

    The MIT License (MIT)

    Copyright (C) 2016 Anedix Technologies, Inc.  All Rights Reserved.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    For other software and binaries included in this module see their licenses.
    The license and the software must remain in full when copying or distributing.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.

--]]--

-- corona
local widget = require( "widget" )

-- mui
local muiData = require( "materialui.mui-data" )

local mathFloor = math.floor
local mathMod = math.fmod
local mathABS = math.abs

local M = muiData.M -- {} -- for module array/table

function M.getNavbarSupportedTypes()
    return muiData.navbarSupportedTypes
end

function M.createNavbar( options )
    if options == nil then return end

    if muiData.widgetDict[options.name] ~= nil then return end

    if options.width == nil then
        options.width = display.contentWidth
    end

    if options.height == nil then
        options.height = M.getScaleVal(4)
    end

    local left,top = (display.contentWidth-options.width) * 0.5, display.contentHeight * 0.5
    if options.left ~= nil then
        left = options.left
    end

    if options.fillColor == nil then
        options.fillColor = { 0.06, 0.56, 0.15, 1 }
    end

    if options.top == nil then
        options.top = M.getScaleVal(80)
    end

    if options.padding == nil then
        options.padding = M.getScaleVal(10)
    end

    if options.top > display.contentHeight * 0.5 then
        muiData.navbarHeight = options.height
    end

    muiData.widgetDict[options.name] = {}
    muiData.widgetDict[options.name]["type"] = "Navbar"
    muiData.widgetDict[options.name]["list"] = {}
    muiData.widgetDict[options.name]["lastWidgetLeftX"] = 0
    muiData.widgetDict[options.name]["lastWidgetRightX"] = 0
    muiData.widgetDict[options.name]["padding"] = options.padding

    muiData.widgetDict[options.name]["container"] = widget.newScrollView(
        {
            top = options.top,
            left = 0,
            width = options.width,
            height = options.height,
            scrollWidth = options.width,
            scrollHeight = options.height,
            hideBackground = true,
            hideScrollBar = true,
            isLocked = true
        }
    )

    local newX = muiData.widgetDict[options.name]["container"].contentWidth * 0.5
    local newY = muiData.widgetDict[options.name]["container"].contentHeight * 0.5

    muiData.widgetDict[options.name]["rect"] = display.newRect( newX, newY, options.width, options.height )
    muiData.widgetDict[options.name]["rect"]:setFillColor( unpack(options.fillColor) )
    muiData.widgetDict[options.name]["container"]:insert( muiData.widgetDict[options.name]["rect"] )

end

function M.attachToNavBar(navbar_name, options )
    if navbar_name == nil or options == nil or options.widgetName == nil then return end
    local newX = 0
    local newY = 0 
    local widget = nil
    local widgetName = options.widgetName
    local nh = muiData.widgetDict[navbar_name]["container"].contentHeight
    local nw = muiData.widgetDict[navbar_name]["container"].contentWidth

    local isTypeSupported = false
    for i, widgetType in ipairs(muiData.navbarSupportedTypes) do
        if widgetType == options.widgetType then
            isTypeSupported = true
            break
        end
    end

    if isTypeSupported == false then
        if options.widgetType == nil then options.widgetType = "unknown widget" end
        print("Warning: attachToNavBar does not support type of "..options.widgetType)
        return
    end

    widget = M.getWidgetBaseObject(widgetName)
    newY = (nh - widget.contentHeight) * 0.5

    -- keep tabs on the toolbar objects
    muiData.widgetDict[navbar_name]["list"][widgetName] = options.widgetType

    if options.align == nil then
        options.align = "left"
    end

    if options.align == "left" then
        if muiData.widgetDict[navbar_name]["lastWidgetLeftX"] > 0 then
            if options.padding ~= nil then
                newX = newX + options.padding
            else
                newX = newX + muiData.widgetDict[navbar_name]["padding"]
            end
        end
        newX = newX + muiData.widgetDict[navbar_name]["lastWidgetLeftX"]
        widget.x = widget.contentWidth * 0.5 + newX
        widget.y = widget.contentHeight * 0.5 + newY
        muiData.widgetDict[navbar_name]["lastWidgetLeftX"] = widget.x + widget.contentWidth * 0.5
    else
        newX = nw
        if muiData.widgetDict[navbar_name]["lastWidgetRightX"] > 0 then
            if options.padding ~= nil then
                newX = newX - options.padding
            else
                newX = newX - muiData.widgetDict[navbar_name]["padding"]
            end
        end
        newX = newX - muiData.widgetDict[navbar_name]["lastWidgetRightX"]
        widget.x = newX - widget.contentWidth * 0.5
        widget.y = widget.contentHeight * 0.5 + newY
        muiData.widgetDict[navbar_name]["lastWidgetRightX"] = widget.x - widget.contentWidth * 0.5
    end
    muiData.widgetDict[navbar_name]["container"]:insert( widget, true )
end

return M
