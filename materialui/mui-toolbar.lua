--[[
    A loosely based Material UI module

    mui-toolbar.lua : This is for creating horizontal toolbars.

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

-- mui
local muiData = require( "materialui.mui-data" )

local mathFloor = math.floor
local mathMod = math.fmod
local mathABS = math.abs

local M = muiData.M -- {} -- for module array/table

function M.createToolbarButton( options )
    local x,y = 160, 240
    if options.x ~= nil then
        x = options.x
    end
    if options.y ~= nil then
        y = options.y
    end

    local barWidth = display.contentWidth
    if options.width ~= nil then
        barWidth = options.width
    end

    if options.index ~= nil and options.index == 1 then
        local rectBak = display.newRect( 0, 0, barWidth, options.buttonHeight )
        rectBak:setFillColor( unpack( options.backgroundColor ) )
        rectBak.x = options.x + barWidth * 0.5
        rectBak.y = y
        muiData.widgetDict[options.basename]["toolbar"]["rectBak"] = rectBak
        --button["mygroup"]:insert( rectBak, true ) -- insert and center bkgd
    end

    --muiData.widgetDict[options.name] = {}
    --muiData.widgetDict[options.name].basename = options.basename
    muiData.widgetDict[options.basename]["toolbar"][options.name] = {}
    muiData.widgetDict[options.basename]["toolbar"]["type"] = "ToolbarButton"

    local button =  muiData.widgetDict[options.basename]["toolbar"][options.name]
    button["mygroup"] = display.newGroup()
    button["mygroup"].x = x
    button["mygroup"].y = y
    button["touching"] = false

    -- label colors
    if options.labelColorOff == nil then
        options.labelColorOff = { 0, 0, 0 }
    end
    if options.labelColor == nil then
        options.labelColor = { 1, 1, 1 }
    end
    muiData.widgetDict[options.basename]["toolbar"]["labelColorOff"] = options.labelColorOff
    muiData.widgetDict[options.basename]["toolbar"]["labelColor"] = options.labelColor

    local radius = options.height * 0.2
    if options.radius ~= nil and options.radius < options.height and options.radius > 1 then
        radius = options.radius
    end

    local fontSize = options.height
    if options.fontSize ~= nil then
        fontSize = options.fontSize
    end
    fontSize = mathFloor(tonumber(fontSize))

    local font = native.systemFont
    if options.font ~= nil then
        font = options.font
    end

    local textColor = { 0, 0.82, 1 }
    if options.textColor ~= nil then
        textColor = options.textColor
    end

    local useBothIconAndText = false
    if options.text ~= nil and options.labelText ~= nil then
        useBothIconAndText = true
    end

    if useBothIconAndText == false and options.labelFont ~= nil and options.labelText ~= nil then
        font = options.labelFont
    end

    if useBothIconAndText == false and options.labelFont ~= nil and options.labelText ~= nil then
        options.text = options.labelText
    end

    local labelColor = { 0, 0, 0 }
    if options.labelColor ~= nil then
        labelColor = options.labelColor
    end

    local isChecked = false
    if options.isChecked ~= nil then
        isChecked = options.isChecked
    end
    if options.isActive ~= nil then
        isChecked = options.isActive
    end

    button["font"] = font
    button["fontSize"] = fontSize
    button["textMargin"] = textMargin

    -- scale font
    -- Calculate a font size that will best fit the given field's height
    local field = {contentHeight=options.buttonHeight * 0.60, contentWidth=options.buttonHeight * 0.60}
    local textToMeasure = display.newText( options.text, 0, 0, font, fontSize )
    local fontSize = fontSize * ( ( field.contentHeight ) / textToMeasure.contentHeight )
    local textWidth = textToMeasure.contentWidth
    textToMeasure:removeSelf()
    textToMeasure = nil

    local numberOfButtons = 1
    if options.numberOfButtons ~= nil then
        numberOfButtons = options.numberOfButtons
    end

    local buttonWidth = barWidth / numberOfButtons
    local rectangle = display.newRect( buttonWidth / 2, 0, buttonWidth, options.buttonHeight )
    rectangle:setFillColor( unpack(options.backgroundColor) )
    button["rectangle"] = rectangle
    button["rectangle"].value = options.value
    button["buttonWidth"] = rectangle.contentWidth
    button["buttonHeight"] = rectangle.contentHeight
    button["buttonOffset"] = rectangle.contentWidth / 2
    button["mygroup"]:insert( rectangle, true ) -- insert and center bkgd

    if options.index ~= nil and options.index == 1 and x < button["buttonWidth"] then
        button["mygroup"].x = rectangle.contentWidth / 2
    elseif options.index ~= nil and options.index > 1 then
        button["buttonOffset"] = 0
    end

    local textY = 0
    local textSize = fontSize
    if useBothIconAndText == true then
        textY = -rectangle.contentHeight * 0.18
        textSize = fontSize * 0.9
    end

    local options2 = 
    {
        --parent = textGroup,
        text = options.text,
        x = 0,
        y = textY,
        font = font,
        fontSize = textSize,
        align = "center"
    }

    button["myText"] = display.newText( options2 )
    button["myText"]:setFillColor( unpack(textColor) )
    button["myText"].isVisible = true
    if isChecked then
        button["myText"]:setFillColor( unpack(options.labelColor) )
        button["myText"].isChecked = isChecked
    else
        button["myText"]:setFillColor( unpack(options.labelColorOff) )
        button["myText"].isChecked = false
    end
    button["mygroup"]:insert( button["myText"], false )

    if useBothIconAndText == true then
        local options3 =
        {
            --parent = textGroup,
            text = options.labelText,
            x = 0,
            y = rectangle.contentHeight * 0.2,
            font = options.labelFont,
            fontSize = fontSize * 0.45,
            align = "center"
        }
        button["myText2"] = display.newText( options3 )
        button["myText2"]:setFillColor( unpack(textColor) )
        button["myText2"].isVisible = true
        if isChecked then
            button["myText2"]:setFillColor( unpack(options.labelColor) )
            button["myText2"].isChecked = isChecked
        else
            button["myText2"]:setFillColor( unpack(options.labelColorOff) )
            button["myText2"].isChecked = false
        end
        button["mygroup"]:insert( button["myText2"], false )
    end

    -- add the animated circle

    local circleColor = textColor
    if options.circleColor ~= nil then
        circleColor = options.circleColor
    end

    button["myCircle"] = display.newCircle( options.height, options.height, radius )
    button["myCircle"]:setFillColor( unpack(circleColor) )
    button["myCircle"].isVisible = false
    button["myCircle"].x = 0
    button["myCircle"].y = 0
    button["myCircle"].alpha = 0.3
    button["mygroup"]:insert( button["myCircle"], true ) -- insert and center bkgd

    local maxWidth = field.contentWidth - (radius * 2.5)
    local scaleFactor = ((maxWidth * 1.3) / radius) -- (since this is a radius of circle)

    thebutton = button["rectangle"]
    field = button["myText"]
    thebutton.name = options.name
    field.name = options.name

    function thebutton:touch (event)
        if muiData.widgetDict[options.basename]["toolbar"][options.name]["myText"].isChecked == true then
            return
        end

        M.addBaseEventParameters(event, options)

        if muiData.dialogInUse == true and options.dialogName == nil then return end
        if ( event.phase == "began" ) then
            muiData.interceptEventHandler = thebutton
            M.updateUI(event)
            if muiData.touching == false then
                muiData.touching = true
                if options.touchpoint ~= nil and options.touchpoint == true then
                    muiData.widgetDict[options.basename]["toolbar"][options.name]["myCircle"].x = event.x - muiData.widgetDict[options.basename]["radio"][options.name]["mygroup"].x
                    muiData.widgetDict[options.basename]["toolbar"][options.name]["myCircle"].y = event.y - muiData.widgetDict[options.basename]["toolbar"][options.name]["mygroup"].y
                    muiData.widgetDict[options.basename]["toolbar"][options.name]["myCircle"].isVisible = true
                    muiData.widgetDict[options.basename]["toolbar"][options.name].myCircleTrans = transition.to( muiData.widgetDict[options.basename]["toolbar"][options.name]["myCircle"], { time=300,alpha=0.2, xScale=scaleFactor, yScale=scaleFactor, transition=easing.inOutCirc, onComplete=M.subtleRadius } )
                end
                transition.to(field,{time=500, xScale=1.03, yScale=1.03, transition=easing.continuousLoop})
            end
        elseif ( event.phase == "ended" ) then
            if M.isTouchPointOutOfRange( event ) then
                event.phase = "offTarget"
                -- event.target:dispatchEvent(event)
                -- print("Its out of the button area")
            else
                event.phase = "onTarget"
                if muiData.interceptMoved == false then
                    --event.target = muiData.widgetDict[options.name]["rrect"]
                    transition.to(muiData.widgetDict[options.basename]["toolbar"]["slider"],{time=350, x=button["mygroup"].x, transition=easing.inOutCubic})

                    event.myTargetName = options.name
                    event.myTargetBasename = options.basename
                    event.altTarget = muiData.widgetDict[options.basename]["toolbar"][options.name]["myText"]
                    event.altTarget2 = muiData.widgetDict[options.basename]["toolbar"][options.name]["myText2"]
                    event.callBackData = options.callBackData

                    M.setEventParameter(event, "muiTargetValue", options.value)
                    M.setEventParameter(event, "muiTarget", muiData.widgetDict[options.basename]["toolbar"][options.name]["myText"])
                    M.setEventParameter(event, "muiTarget2", muiData.widgetDict[options.basename]["toolbar"][options.name]["myText2"])
                    M.actionForToolbar(options, event)
                end
                muiData.interceptEventHandler = nil
                muiData.interceptMoved = false
                muiData.touching = false
            end
        end
    end

    muiData.widgetDict[options.basename]["toolbar"][options.name]["rectangle"]:addEventListener( "touch", muiData.widgetDict[options.basename]["toolbar"][options.name]["rectangle"] )
end


function M.createToolbar( options )
    local x, y = options.x, options.y
    local buttonWidth = 1
    local buttonOffset = 0
    local activeX = 0

    if options.isChecked == nil then
        options.isChecked = false
    end

    if options.sliderColor == nil then
        options.sliderColor = { 1, 1, 1 }
    end

    if options.list ~= nil then
        local count = #options.list
        muiData.widgetDict[options.name] = {}
        muiData.widgetDict[options.name]["toolbar"] = {}
        muiData.widgetDict[options.name]["type"] = "Toolbar"
        for i, v in ipairs(options.list) do            
            M.createToolbarButton({
                index = i,
                name = options.name .. "_" .. i,
                basename = options.name,
                label = v.key,
                value = v.value,
                text = v.icon,
                textOn = v.icon,
                width = options.width,
                height = options.height,
                buttonHeight = options.buttonHeight,
                x = x,
                y = y,
                isChecked = v.isChecked,
                isActive = v.isActive,
                font = "MaterialIcons-Regular.ttf",
                labelText = v.labelText,
                labelFont = options.labelFont,
                labelFontSize = options.labelFontSize,
                textColor = options.labelColor,
                textColorOff = options.labelColorOff,
                textAlign = "center",
                labelColor = options.labelColor,
                backgroundColor = options.color,
                numberOfButtons = count,
                callBack = options.callBack,
                callBackData = options.callBackData
            })
            local button = muiData.widgetDict[options.name]["toolbar"][options.name.."_"..i]
            buttonWidth = button["buttonWidth"]
            if i == 1 then buttonOffset = button["buttonOffset"] end
            if options.layout ~= nil and options.layout == "horizontal" then
                x = x + button["buttonWidth"] + button["buttonOffset"]
            else
                y = y + button["buttonHeight"]
            end
            if v.isChecked == true or v.isActive == true then
                activeX = button["mygroup"].x
            end
        end

        -- slider highlight
        local sliderHeight = options.buttonHeight * 0.05
        muiData.widgetDict[options.name]["toolbar"]["slider"] = display.newRect( buttonOffset, display.contentHeight - (sliderHeight * 0.5), buttonWidth, sliderHeight )
        muiData.widgetDict[options.name]["toolbar"]["slider"]:setFillColor( unpack( options.sliderColor ) )
        transition.to(muiData.widgetDict[options.name]["toolbar"]["slider"],{time=0, x=activeX, transition=easing.inOutCubic})
    end
end

function M.actionForToolbar( options, e )
    local target = M.getEventParameter(e, "muiTarget")
    local target2 = M.getEventParameter(e, "muiTarget2")
    if target ~= nil then
        -- uncheck all then check the one that is checked
        local basename = M.getEventParameter(e, "basename")
        local foundName = false
        local list = muiData.widgetDict[basename]["toolbar"]

        if target.isChecked == true then
            return
        end
        for k, v in pairs(list) do
            if v["myText"] ~= nil then
                v["myText"]:setFillColor( unpack(muiData.widgetDict[basename]["toolbar"]["labelColorOff"]) )
                if v["myText2"] ~= nil then
                    v["myText2"]:setFillColor( unpack(muiData.widgetDict[basename]["toolbar"]["labelColorOff"]) )
                end
                v["myText"].isChecked = false
            end
        end

        target:setFillColor( unpack(muiData.widgetDict[basename]["toolbar"]["labelColor"]) )
        if target2 ~= nil then
            target2:setFillColor( unpack(muiData.widgetDict[basename]["toolbar"]["labelColor"]) )
        end
        target.isChecked = true
        assert( options.callBack )(e)
    end
end

function M.actionForToolbarDemo( event )
    -- note:
    -- event.<original attribute> remain untouched.
    -- event.muiDict will be the only added variable (less conflicting)
    --
    local muiTarget = M.getEventParameter(event, "muiTarget")
    local muiTargetValue = M.getEventParameter(event, "muiTargetValue")

    if muiTarget ~= nil then
        print("Toolbar button text: " .. muiTarget.text)
    end
    if muiTargetValue ~= nil then
        print("Toolbar button value: " .. muiTargetValue)
    end
end

return M
