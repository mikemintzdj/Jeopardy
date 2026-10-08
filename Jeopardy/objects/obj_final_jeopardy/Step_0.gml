// =====================================================
// FINAL JEOPARDY INPUT
// =====================================================


// =====================================================
// INTRO SCREEN
// =====================================================

if (game_state == 0)
{
    if (mouse_check_button_pressed(mb_left))
    {
        // -------------------------------------------------
        // MAKE WAGERS
        // -------------------------------------------------

        if (point_in_rectangle(
            mouse_x,
            mouse_y,

            make_wagers_button_x -
            make_wagers_button_width / 2,

            make_wagers_button_y -
            make_wagers_button_height / 2,

            make_wagers_button_x +
            make_wagers_button_width / 2,

            make_wagers_button_y +
            make_wagers_button_height / 2
        ))
        {
            game_state = 1;
        }
    }
}


// =====================================================
// WAGER SCREEN
// =====================================================

else if (game_state == 1)
{
    if (mouse_check_button_pressed(mb_left))
    {
        // -------------------------------------------------
        // TEAM WAGER CONTROLS
        // -------------------------------------------------

        for (var t = 0; t < global.team_count; t++)
        {
            var draw_team_x = team_x;

            var draw_team_y =
                team_start_y +
                (t * team_spacing);


            // -------------------------------------------------
            // PLUS
            // -------------------------------------------------

            if (point_in_rectangle(
                mouse_x,
                mouse_y,

                draw_team_x +
                wager_button_offset -
                wager_button_size / 2,

                draw_team_y -
                wager_button_size / 2,

                draw_team_x +
                wager_button_offset +
                wager_button_size / 2,

                draw_team_y +
                wager_button_size / 2
            ))
            {
                var maximum_wager =
                    max(0, global.team_scores[t]);

                team_wagers[t] =
                    min(
                        team_wagers[t] + 100,
                        maximum_wager
                    );
            }


            // -------------------------------------------------
            // MINUS
            // -------------------------------------------------

            if (point_in_rectangle(
                mouse_x,
                mouse_y,

                draw_team_x -
                wager_button_offset -
                wager_button_size / 2,

                draw_team_y -
                wager_button_size / 2,

                draw_team_x -
                wager_button_offset +
                wager_button_size / 2,

                draw_team_y +
                wager_button_size / 2
            ))
            {
                team_wagers[t] =
                    max(
                        0,
                        team_wagers[t] - 100
                    );
            }
        }


        // -------------------------------------------------
        // SEE QUESTION
        // -------------------------------------------------

        if (point_in_rectangle(
            mouse_x,
            mouse_y,

            see_question_button_x -
            see_question_button_width / 2,

            see_question_button_y -
            see_question_button_height / 2,

            see_question_button_x +
            see_question_button_width / 2,

            see_question_button_y +
            see_question_button_height / 2
        ))
        {
            game_state = 2;
        }
    }
}


// =====================================================
// QUESTION SCREEN
// =====================================================

else if (game_state == 2)
{
    if (mouse_check_button_pressed(mb_left))
    {
        // -------------------------------------------------
        // REVEAL ANSWER
        // -------------------------------------------------

        if (point_in_rectangle(
            mouse_x,
            mouse_y,

            reveal_answer_button_x -
            reveal_answer_button_width / 2,

            reveal_answer_button_y -
            reveal_answer_button_height / 2,

            reveal_answer_button_x +
            reveal_answer_button_width / 2,

            reveal_answer_button_y +
            reveal_answer_button_height / 2
        ))
        {
            current_judging_team = 0;

            game_state = 3;
        }
    }
}


// =====================================================
// TEAM JUDGING
// =====================================================

else if (game_state == 3)
{
    if (mouse_check_button_pressed(mb_left))
    {
        // -------------------------------------------------
        // CORRECT
        // -------------------------------------------------

        if (point_in_rectangle(
            mouse_x,
            mouse_y,

            correct_button_x -
            judging_button_width / 2,

            judging_button_y -
            judging_button_height / 2,

            correct_button_x +
            judging_button_width / 2,

            judging_button_y +
            judging_button_height / 2
        ))
        {
            global.team_scores[current_judging_team] +=
                team_wagers[current_judging_team];

            team_judged[current_judging_team] = true;


            // -------------------------------------------------
            // NEXT TEAM
            // -------------------------------------------------

            current_judging_team++;

            if (current_judging_team >= global.team_count)
            {
                game_state = 4;
            }
        }


        // -------------------------------------------------
        // INCORRECT
        // -------------------------------------------------

        else if (point_in_rectangle(
            mouse_x,
            mouse_y,

            incorrect_button_x -
            judging_button_width / 2,

            judging_button_y -
            judging_button_height / 2,

            incorrect_button_x +
            judging_button_width / 2,

            judging_button_y +
            judging_button_height / 2
        ))
        {
            global.team_scores[current_judging_team] -=
                team_wagers[current_judging_team];

            team_judged[current_judging_team] = true;


            // -------------------------------------------------
            // NEXT TEAM
            // -------------------------------------------------

            current_judging_team++;

            if (current_judging_team >= global.team_count)
            {
                game_state = 4;
            }
        }
    }
}


// =====================================================
// FINAL SCORES
// =====================================================

else if (game_state == 4)
{
    // Nothing required here yet.
    // Final scores are simply displayed.
}