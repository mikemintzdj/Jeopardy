// =====================================================
// JEOPARDY LIBRARY
// =====================================================

global.jeopardy_library = scr_jeopardy_library();


// =====================================================
// CLASS SELECTION
// =====================================================

// Get the available Classes from the library
class_names =
    variable_struct_get_names(global.jeopardy_library);

// Start on the first Class
selected_class = 0;

// No mouse selection yet
hovered_class = -1;


// =====================================================
// CLASS SELECTION POSITION
// =====================================================

class_select_x = room_width / 2;
class_select_y = 200;

// Spacing between Classes
class_select_spacing = 50;

menu_stage = 0;

// =====================================================
// UNIT SELECTION
// =====================================================

// The selected Class's Units will be loaded
unit_names = [];

// Start on the first Unit
selected_unit = 0;

// No mouse selection yet
hovered_unit = -1;


// =====================================================
// UNIT PAGINATION
// =====================================================

// Maximum number of Units shown on one page
units_per_page = 5;

// Current Unit page
unit_page = 0;

// Total number of Unit pages
unit_page_count = 1;


// =====================================================
// UNIT SELECTION POSITION
// =====================================================

unit_select_x = room_width / 2;
unit_select_y = 200;

// Spacing between Units
unit_select_spacing = 50;


// =====================================================
// UNIT PAGE CONTROLS
// =====================================================

// Position of page navigation
unit_page_y = 500;

// Back arrow
unit_back_x = room_width / 2 - 150;

// Next arrow
unit_next_x = room_width / 2 + 150;

// Page number
unit_page_number_x = room_width / 2;


// =====================================================
// TEAM COUNT
// =====================================================

// Default number of teams
team_count = 2;

// Vertical position of team selector
team_count_y = 700;


// =====================================================
// TEAM DEBUG
// =====================================================

hovered_team = -1;
debug_message = "Waiting for input...";


// =====================================================
// QUESTION TIMER
// =====================================================

question_timer = 15;

question_timer_min = 10;
question_timer_max = 60;

// Timer island on the LEFT
timer_adjust_x = 150;
timer_adjust_y = 400;

timer_button_size = 30;
timer_button_offset = 100;

// =====================================================
// START GAME BUTTON
// =====================================================

start_clicked = false;

start_button_x = room_width / 2;
start_button_y = 600;

start_button_width = 300;
start_button_height = 60;