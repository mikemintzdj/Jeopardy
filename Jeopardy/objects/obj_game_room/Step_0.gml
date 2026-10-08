// =====================================================
// JEOPARDY GAME INPUT
// =====================================================


// =====================================================
// BOARD
// =====================================================

if (game_state == 0)
{
    // -------------------------------------------------
    // MOUSE HOVER
    // -------------------------------------------------

    hovered_category = -1;
    hovered_question = -1;


    for (var column = 0; column < 5; column++)
    {
        for (var row = 0; row < 5; row++)
        {
            // Skip questions that have already been played
            if (played_questions[column][row])
                continue;


            var hover_x =
                board_x +
                value_start_x +
                (column * value_column_spacing);


            var hover_y =
                board_y +
                value_start_y +
                (row * value_row_spacing);


            if (point_in_rectangle(
                mouse_x,
                mouse_y,
                hover_x - hover_width / 2,
                hover_y - hover_height / 2,
                hover_x + hover_width / 2,
                hover_y + hover_height / 2
            ))
            {
                hovered_category = column;
                hovered_question = row;
            }
        }
    }


    // -------------------------------------------------
    // CLICK DOLLAR VALUE
    // -------------------------------------------------

    if (mouse_check_button_pressed(mb_left))
    {
        if (hovered_category != -1 &&
            hovered_question != -1)
        {
            selected_category = hovered_category;
            selected_question = hovered_question;


            // Mark this question as played
            played_questions[selected_category][selected_question] = true;


            // Count the question
            questions_played++;


            // Get the selected question
            current_question =
                jeopardy_section
                .categories[selected_category]
                .questions[selected_question];


            // Get the correct answer
            current_answer =
                current_question.answer;


            // -------------------------------------------------
            // START QUESTION TIMER
            // -------------------------------------------------

            question_timer =
                question_timer_max;

            question_timer_active = true;


            // Go to question screen
            game_state = 1;
        }
    }
}


// =====================================================
// QUESTION
// =====================================================

else if (game_state == 1)
{
    // -------------------------------------------------
    // QUESTION TIMER
    // -------------------------------------------------

    if (question_timer_active)
    {
        question_timer -= 1 / room_speed;


        // -------------------------------------------------
        // TIME'S UP
        // -------------------------------------------------

        if (question_timer <= 0)
        {
            question_timer = 0;

            question_timer_active = false;

            // Time is up, but stay on the question
        }
    }


    // -------------------------------------------------
    // REVEAL ANSWER
    // -------------------------------------------------

    if (mouse_check_button_pressed(mb_left))
    {
        question_timer_active = false;

        // Reveal answer
        game_state = 2;
    }
}

// =====================================================
// ANSWER
// =====================================================

else if (game_state == 2)
{
    if (mouse_check_button_pressed(mb_left))
    {
        // -------------------------------------------------
        // CORRECT
        // -------------------------------------------------

        if (point_in_rectangle(
            mouse_x,
            mouse_y,
            correct_button_x - answer_button_width / 2,
            answer_button_y - answer_button_height / 2,
            correct_button_x + answer_button_width / 2,
            answer_button_y + answer_button_height / 2
        ))
        {
            global.team_scores[global.current_team] +=
                current_question.value;


            // -------------------------------------------------
            // FINAL QUESTION?
            // -------------------------------------------------

            if (questions_played >= 25)
            {
                room_goto(room_final_jeopardy);
            }
            else
            {
                // Return to board
                game_state = 0;
            }
        }


        // -------------------------------------------------
        // INCORRECT
        // -------------------------------------------------

        else if (point_in_rectangle(
            mouse_x,
            mouse_y,
            incorrect_button_x - answer_button_width / 2,
            answer_button_y - answer_button_height / 2,
            incorrect_button_x + answer_button_width / 2,
            answer_button_y + answer_button_height / 2
        ))
        {
            global.team_scores[global.current_team] -=
                current_question.value;


            // -------------------------------------------------
            // NEXT TEAM
            // -------------------------------------------------

            global.current_team++;

            if (global.current_team >= global.team_count)
            {
                global.current_team = 0;
            }


            // -------------------------------------------------
            // FINAL QUESTION?
            // -------------------------------------------------

            if (questions_played >= 25)
            {
                room_goto(room_final_jeopardy);
            }
            else
            {
                // Return to board
                game_state = 0;
            }
        }


        // -------------------------------------------------
        // PASS
        // -------------------------------------------------

        else if (point_in_rectangle(
            mouse_x,
            mouse_y,
            pass_button_x - answer_button_width / 2,
            pass_button_y - answer_button_height / 2,
            pass_button_x + answer_button_width / 2,
            pass_button_y + answer_button_height / 2
        ))
        {
            // No points gained or lost
            // Current team keeps control


            // -------------------------------------------------
            // FINAL QUESTION?
            // -------------------------------------------------

            if (questions_played >= 25)
            {
                room_goto(room_final_jeopardy);
            }
            else
            {
                // Return to board
                game_state = 0;
            }
        }
    }
}

// =====================================================
// NEXT TEAM BUTTON
// =====================================================

if (mouse_check_button_pressed(mb_left))
{
    if (point_in_rectangle(
        mouse_x,
        mouse_y,
        team_next_button_x - team_next_button_width / 2,
        team_next_button_y - team_next_button_height / 2,
        team_next_button_x + team_next_button_width / 2,
        team_next_button_y + team_next_button_height / 2
    ))
    {
        global.current_team++;

        if (global.current_team >= global.team_count)
        {
            global.current_team = 0;
        }
    }
}


// =====================================================
// TEAM SCORE CONTROLS
// =====================================================

if (mouse_check_button_pressed(mb_left))
{
    for (var t = 0; t < global.team_count; t++)
    {
        var team_x = team_score_x;

        var team_y =
            team_start_y +
            (t * team_spacing);


        // -------------------------------------------------
        // UP / PLUS
        // -------------------------------------------------

        if (point_in_rectangle(
            mouse_x,
            mouse_y,
            team_x + team_score_button_offset - team_score_button_size / 2,
            team_y - team_score_button_size / 2,
            team_x + team_score_button_offset + team_score_button_size / 2,
            team_y + team_score_button_size / 2
        ))
        {
            global.team_scores[t] += 100;
        }


        // -------------------------------------------------
        // DOWN / MINUS
        // -------------------------------------------------

        if (point_in_rectangle(
            mouse_x,
            mouse_y,
            team_x - team_score_button_offset - team_score_button_size / 2,
            team_y - team_score_button_size / 2,
            team_x - team_score_button_offset + team_score_button_size / 2,
            team_y + team_score_button_size / 2
        ))
        {
            global.team_scores[t] -= 100;
        }
    }
}


// =====================================================
// TEST FINAL JEOPARDY BUTTON
// =====================================================

if (mouse_check_button_pressed(mb_left))
{
    if (point_in_rectangle(
        mouse_x,
        mouse_y,
        test_final_button_x - test_final_button_width / 2,
        test_final_button_y - test_final_button_height / 2,
        test_final_button_x + test_final_button_width / 2,
        test_final_button_y + test_final_button_height / 2
    ))
    {
        room_goto(room_final_jeopardy);
    }
}