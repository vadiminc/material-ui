# Change Log

All notable changes to this project will be documented in this file.

## [0.1.16] - 2016-07-06
### Added
- Re-factored the layout of the modules. Widgets are now in separate .lua files to help with maintainability.  New files (.lua assumed): mui-button, mui-dialog, mui-navbar, mui-progressbar, mui-select, mui-slider, mui-switch, mui-tableview, mui-textinput, mui-toast, mui-toolbar
- Added mui-data.lua to be the internal global space.
- Ability to create additional modules using a simple template. mui-example.lua is the template.
- Ability to specify which modules are needed by a scene. Include a table ({}) in the mui.init() for the modules needed. If "none" are specified then all modules are loaded. See mui.lua for sample list.

### Change
- createDialog - fixed fadeOut when dialog is closed.

## [0.1.15] - 2016-07-03
### Added
- `onRowRenderDemo` - this is used to render the createTableView and add all the content on a row. 
- `attachToRow` - For createTableView it will attach a MUI widget to a row. Supports widget types: RRectButton, RectButton, IconButton, Slider, TextField. Additional widget types will be added. See onRowRenderDemo for an example.
- createTableView has option "rowAnimation = false" to turn off touchpoint and row fade.

### Change
- createSelect no longer needs onRowRender as param. It will handle rendering internally.
- improved removal of widgets

## [0.1.14] - 2016-07-02
### Added
- `createNavbar` - Create a navigation bar. Allows left and right alignment of attached widgets. See fun.lua for an example. Supports widget types: RRectButton, RectButton, IconButton, Slider, TextField. Additional widget types will be added.

### Change
- createTextField improved password field handling.
- createTextField background color can be set by fillColor. It was hard coded to be white.

## [0.1.13] - 2016-07-01
### Added
- `createSelect` - Create a select drop down list (dropdown list). Colors, dimensions and fonts can be specified.  See fun.lua for an example. Run the demo and tap "Switch Scene" button.

### Change
- createTextField supports inputType from Corona SDK. Example password fields.
- createTableView supports row colors, line separator and color and many bug fixes.

## [0.1.12] - 2016-06-30
### Added
- `createToast` - Create simple "toast" notifications on screen. Colors, dimensions and fonts can be specified.  See fun.lua for an example run the demo and tap "Switch Scene" button. Tap "Show Toast"

## [0.1.11] - 2016-06-30
### Change
- Fixed createSlider() event issue with not always firing the "ended" event.

## [0.1.10] - 2016-06-29
### Added
- `getEventParameter` - returns the event MUI widget parameters for the current widget.  Get the event target, widget name, widget value ( ex: getEventParameter(event, "muiTargetValue") ).  The value is set when creating a widget.  See menu.lua for setting the values and mui.lua callBacks for getting values (example would be actionForSwitch() method).
- All widgets support a "value" and can be accessed in the callBacks by getEventParameter() method. See mui.lua for examples.

## [0.1.9] - 2016-06-29
### Added
- "labelFont" option to createToolbar
- "labelText" option to createToolbar "list" of buttons. Allows a button to contain: Icon only, Text only or Icon with Text beneath.

### Change
- "x" option to createToolbar now works as expected. Set to 0 if wanting to use a toolbar that is 100% width of display.
- "width" option to createToolbar now works as expected. If width is omitted the toolbar width defaults to 100% or display.contentWidth
- "touchpoint" option to createToolbar now works as expected.
- "callBack" for createToolbar works as expected. It will do the animation and then call the user-defined callBack.

## [0.1.8] - 2016-06-28
### Added
- "labelFont" option to createToolbar
- "labelText" option to createToolbar "list" attribute. Allows the mix of Material icon font and text/word
font.  Label a button as "View" the button contain the text "View"

## [0.1.8] - 2016-06-27
### Added
- "easing" option to createDialog and use easing library built-in corona sdk.
- createSlider() - Create a slider for doing percentages 0..100. Calculate amount in call backs: callBackMove (call during movement) and callBack = at the end phase.  Values are in percent (0.20, 0.90 and 1 for 100%). Limitations: horizontal only and no labels (both to be addressed).  See fun.lua for two examples (2nd scene). See mui.lua and method sliderCallBackMove() to get current value of slider.

### Change
- dialogClose() has a new method closeDialog() which will phase out dialogClose() in later releases.

## [0.1.7] - 2016-06-26
### Added
- "clickAnimation" options to createRect and createRRect methods to fadeOut darken background when button is tapped. Choose darker color and when the button is tapped it will highlight in that color and fadeOut See menu.lua for an example.

### Change
- README documentation updated.

## [0.1.6] - 2016-06-25
### Added
- createDialog() - Create a dialog window with content. Supports up to two buttons (Okay, Cancel) with callbacks. See menu.lua for an example.

### Change
- Fixed some bugs and refactored parts of the code

## [0.1.5] - 2016-06-23
### Added
- getWidgetByName("name_of_widget") - Returns the array of a named widget.
- getWidgetBaseObject("name_of_widget") returns the base object of a named widget from one of the create methods. It can be inserted into another container, group, scrollview, etc.
- More documentation on methods and helper methods.

### Changed
- Re-factored the event handling. There will be another round of refactoring.
- Renamed method "removeWidgetSwitch" to "removeWidgetToggleSwitch"

## [0.1.4] - 2016-06-22
### Added
- scrollView support to widgets. Specify it in the parameters as: scrollView = scroll_view
- createToggleSwitch() - Create toggle switch. See menu.lua for an example.

### Changed
- Fixed issue where scrollView widgets (like buttons) would not work when added to scrollView.
- Fixed bug when releasing memory for createProgressBar when not using a label.

## [0.1.3] - 2016-06-21
### Added
- createProgressBar() - An animated progress bar using "determinate" from Material Design. Please see menu.lua for an example. Includes linear call back (callBack) and later will support a repeating call back (repeatCallBack). It has a number of options.

## [0.1.2] - 2016-06-18
### Changed
- Fixed method createRRectButton()
- Renamed method createRRectButton() parameter "gradientColor1 to "gradientShadowColor1"
- Renamed method createRRectButton() parameter "gradientColor2 to "gradientShadowColor2"
- Fixed parameter "radius" for method createRRectButton()

### Added
- Added parameters "strokeWidth" and "strokeColor" to method createRRectButton().
- This CHANGELOG file

## [0.1.1] - 2016-06-01
### Added
- This project to GitHub
