// =====================================================
// LOAD JEOPARDY DATA
// =====================================================

global.jeopardy_library = scr_jeopardy_library();

jeopardy_unit =
    global.jeopardy_library
    [$ global.selected_jeopardy_class]
    [$ global.selected_jeopardy_unit];

final_jeopardy =
    jeopardy_unit[$ "Final Jeopardy"];


// =====================================================
// BOARD POSITION
// =====================================================

board_x = room_width / 2;
board_y = room_height / 2;


// =====================================================
// GAME STATE
// =====================================================

// 0 = Final Jeopardy Intro
// 1 = Wagers
// 2 = Question
// 3 = Team Judging
// 4 = Final Scores

game_state = 0;


// =====================================================
// WAGERS
// =====================================================

team_wagers = array_create(global.team_count, 0);


// =====================================================
// TEAM JUDGING
// =====================================================

team_judged = array_create(global.team_count, false);

current_judging_team = 0;


// =====================================================
// FINAL JEOPARDY QUESTION / ANSWER
// =====================================================

current_question =
    final_jeopardy.question;

current_answer =
    final_jeopardy.answer;

final_category =
    final_jeopardy.category;


// =====================================================
// FINAL JEOPARDY LAYOUT
// =====================================================


// =====================================================
// INTRO SCREEN
// =====================================================


// -----------------------------------------------------
// TITLE
// -----------------------------------------------------

title_x = board_x;
title_y = 70;


// -----------------------------------------------------
// CATEGORY
// -----------------------------------------------------

category_x = board_x;
category_y = 115;


// -----------------------------------------------------
// MAKE WAGERS BUTTON
// -----------------------------------------------------

make_wagers_button_x = board_x;
make_wagers_button_y = 200;

make_wagers_button_width = 300;
make_wagers_button_height = 60;


// =====================================================
// WAGER SCREEN
// =====================================================


// -----------------------------------------------------
// WAGERING TITLE
// -----------------------------------------------------

wager_title_x = board_x;
wager_title_y = 100;


// -----------------------------------------------------
// TEAM COLUMN
// -----------------------------------------------------

team_x = 680;
team_start_y = 200;
team_spacing = 80;


// -----------------------------------------------------
// TEAM TEXT POSITIONS
// -----------------------------------------------------

team_score_y_offset = -15;
team_wager_y_offset = 15;


// -----------------------------------------------------
// WAGER +/- BUTTONS
// -----------------------------------------------------

wager_button_size = 30;
wager_button_offset = 100;


// -----------------------------------------------------
// SEE QUESTION BUTTON
// -----------------------------------------------------

see_question_button_x = board_x;
see_question_button_y = room_height - 70;

see_question_button_width = 300;
see_question_button_height = 60;


// =====================================================
// QUESTION SCREEN
// =====================================================


// -----------------------------------------------------
// QUESTION
// -----------------------------------------------------

question_x = board_x;
question_y = board_y - 30;


// -----------------------------------------------------
// ANSWER
// -----------------------------------------------------

answer_x = board_x;
answer_y = board_y - 50;


// -----------------------------------------------------
// QUESTION INSTRUCTION
// -----------------------------------------------------

question_instruction_x = board_x;
question_instruction_y = board_y + 180;


// -----------------------------------------------------
// REVEAL ANSWER BUTTON
// -----------------------------------------------------

reveal_answer_button_x = board_x;
reveal_answer_button_y = room_height - 70;

reveal_answer_button_width = 300;
reveal_answer_button_height = 60;


// =====================================================
// JUDGING SCREEN
// =====================================================


// -----------------------------------------------------
// CURRENT TEAM
// -----------------------------------------------------

judging_team_x = board_x;
judging_team_y = 220;


// -----------------------------------------------------
// CURRENT TEAM WAGER
// -----------------------------------------------------

judging_wager_x = board_x;
judging_wager_y = 270;


// -----------------------------------------------------
// CORRECT / INCORRECT BUTTONS
// -----------------------------------------------------

correct_button_x = board_x - 120;
incorrect_button_x = board_x + 120;

judging_button_y = 380;

judging_button_width = 180;
judging_button_height = 60;


// =====================================================
// FINAL SCORE SCREEN
// =====================================================


// -----------------------------------------------------
// TITLE
// -----------------------------------------------------

final_score_title_x = board_x;
final_score_title_y = 150;


// -----------------------------------------------------
// SCORES
// -----------------------------------------------------

final_score_x = board_x;
final_score_start_y = 250;
final_score_spacing = 75;