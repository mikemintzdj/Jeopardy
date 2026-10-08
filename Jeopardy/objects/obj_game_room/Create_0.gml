// =====================================================
// LOAD JEOPARDY DATA
// =====================================================

// Get the full Jeopardy library
global.jeopardy_library = scr_jeopardy_library();

// Get the selected Class, then the selected Unit
jeopardy_unit =
    global.jeopardy_library
    [$ global.selected_jeopardy_class]
    [$ global.selected_jeopardy_unit];

// Get the normal Jeopardy section
jeopardy_section =
    jeopardy_unit.Jeopardy;


// =====================================================
// BOARD POSITION
// =====================================================

board_x = room_width / 2;
board_y = room_height / 2;


// =====================================================
// BOARD LAYOUT
// =====================================================

// Unit title
unit_x = -400;
unit_y = -325;

// Section title
section_x = 350;
section_y = -300;

// Category headers
category_start_x = -375;
category_start_y = -210;
category_column_spacing = 187;

// Dollar values
value_start_x = -375;
value_start_y = -120;
value_column_spacing = 185;
value_row_spacing = 95;


// =====================================================
// TEAM SCORE POSITION
// =====================================================

team_score_x = board_x - 580;
team_start_y = board_y - 250;
team_spacing = 85;

team_next_button_x = team_score_x;
team_next_button_y =
    team_start_y +
    (global.team_count * team_spacing) +
    20;

team_next_button_width = 160;
team_next_button_height = 50;


// =====================================================
// TEAM SCORE CONTROLS
// =====================================================

team_score_button_size = 25;
team_score_button_offset = 50;


// =====================================================
// TEAM SCORES
// =====================================================

global.team_scores =
    array_create(global.team_count, 0);

// Team whose turn it currently is
global.current_team = 0;


// =====================================================
// GAME STATE
// =====================================================

// 0 = Board
// 1 = Question
// 2 = Answer

hovered_category = -1;
hovered_question = -1;


// =====================================================
// QUESTION TIMER
// =====================================================

question_timer_max =
    global.question_timer;

question_timer =
    question_timer_max;

question_timer_active = false;


// -----------------------------------------------------
// TIMER DISPLAY
// -----------------------------------------------------

question_timer_x = board_x;
question_timer_y = board_y + 150;


// =====================================================
// PLAYED QUESTIONS
// =====================================================

played_questions =
    array_create(5);

for (var column = 0; column < 5; column++)
{
    played_questions[column] =
        array_create(5, false);
}

questions_played = 0;


// =====================================================
// HOVER HIGHLIGHT SIZE
// =====================================================

hover_width = 160;
hover_height = 70;

game_state = 0;


// =====================================================
// CURRENT QUESTION
// =====================================================

// Currently selected question
selected_category = -1;
selected_question = -1;


// The actual question data
current_question = undefined;
current_answer = undefined;


// =====================================================
// ANSWER BUTTONS
// =====================================================

answer_button_y = board_y + 200;

answer_button_width = 180;
answer_button_height = 60;

correct_button_x = board_x - 110;
incorrect_button_x = board_x + 110;
pass_button_x = board_x;
pass_button_y = answer_button_y + 80;


// =====================================================
// TEST FINAL JEOPARDY BUTTON
// =====================================================

test_final_button_x = room_width - 180;
test_final_button_y = 60;

test_final_button_width = 280;
test_final_button_height = 50;