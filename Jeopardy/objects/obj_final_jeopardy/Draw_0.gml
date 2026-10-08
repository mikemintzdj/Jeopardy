// =====================================================
// DRAW SETTINGS
// =====================================================

draw_set_halign(fa_center);
draw_set_valign(fa_middle);


// =====================================================
// FINAL JEOPARDY BACKGROUND
// =====================================================

draw_sprite(
    spr_answer_tile,
    0,
    board_x,
    board_y
);


// =====================================================
// STATE 0
// FINAL JEOPARDY INTRO
// =====================================================

if (game_state == 0)
{
    draw_set_color(c_white);


    // -------------------------------------------------
    // TITLE
    // -------------------------------------------------

    draw_text(
        title_x,
        title_y,
        "FINAL JEOPARDY"
    );


    // -------------------------------------------------
    // CATEGORY
    // -------------------------------------------------

    draw_text(
        category_x,
        category_y,
        "CATEGORY: " + final_category
    );


    // -------------------------------------------------
    // MAKE WAGERS BUTTON
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
        draw_set_color(c_lime);
    }
    else
    {
        draw_set_color(c_green);
    }


    draw_rectangle(
        make_wagers_button_x -
        make_wagers_button_width / 2,

        make_wagers_button_y -
        make_wagers_button_height / 2,

        make_wagers_button_x +
        make_wagers_button_width / 2,

        make_wagers_button_y +
        make_wagers_button_height / 2,

        false
    );


    draw_set_color(c_white);

    draw_text(
        make_wagers_button_x,
        make_wagers_button_y,
        "MAKE WAGERS"
    );
}


// =====================================================
// STATE 1
// WAGER SCREEN
// =====================================================

else if (game_state == 1)
{
    draw_set_color(c_white);


    // -------------------------------------------------
    // TITLE
    // -------------------------------------------------

    draw_text(
        title_x,
        title_y,
        "FINAL JEOPARDY"
    );


    // -------------------------------------------------
    // WAGERING TITLE
    // -------------------------------------------------

    draw_text(
        wager_title_x,
        wager_title_y,
        "PLACE YOUR WAGERS"
    );


    // -------------------------------------------------
    // TEAM WAGERS
    // -------------------------------------------------

    for (var t = 0; t < global.team_count; t++)
    {
        var draw_team_x = team_x;

        var draw_team_y =
            team_start_y +
            (t * team_spacing);


        draw_set_color(c_white);


        // TEAM NAME

        draw_text(
            draw_team_x,
            draw_team_y - 15,
            "TEAM " + string(t + 1)
        );


        // CURRENT SCORE

        draw_text(
            draw_team_x,
            draw_team_y + 15,
            "SCORE: $" +
            string(global.team_scores[t])
        );


        // WAGER

        draw_text(
            draw_team_x,
            draw_team_y + 45,
            "WAGER: $" +
            string(team_wagers[t])
        );


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
            draw_set_color(c_lime);
        }
        else
        {
            draw_set_color(c_white);
        }


        draw_text(
            draw_team_x -
            wager_button_offset,

            draw_team_y,

            "-"
        );


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
            draw_set_color(c_lime);
        }
        else
        {
            draw_set_color(c_white);
        }


        draw_text(
            draw_team_x +
            wager_button_offset,

            draw_team_y,

            "+"
        );
    }


    // -------------------------------------------------
    // SEE QUESTION BUTTON
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
        draw_set_color(c_lime);
    }
    else
    {
        draw_set_color(c_green);
    }


    draw_rectangle(
        see_question_button_x -
        see_question_button_width / 2,

        see_question_button_y -
        see_question_button_height / 2,

        see_question_button_x +
        see_question_button_width / 2,

        see_question_button_y +
        see_question_button_height / 2,

        false
    );


    draw_set_color(c_white);

    draw_text(
        see_question_button_x,
        see_question_button_y,
        "SEE QUESTION"
    );
}


// =====================================================
// STATE 2
// QUESTION SCREEN
// =====================================================

else if (game_state == 2)
{
    draw_set_color(c_white);


    // -------------------------------------------------
    // TITLE
    // -------------------------------------------------

    draw_text(
        title_x,
        title_y,
        "FINAL JEOPARDY"
    );


    // -------------------------------------------------
    // CATEGORY
    // -------------------------------------------------

    draw_text(
        category_x,
        category_y,
        "CATEGORY: " + final_category
    );


// -------------------------------------------------
// QUESTION
// -------------------------------------------------

var question_words =
    string_split(current_question, " ");

var question_line_1 = "";
var question_line_2 = "";

for (var w = 0; w < array_length(question_words); w++)
{
    var test_line =
        question_line_1 == ""
        ? question_words[w]
        : question_line_1 + " " + question_words[w];

    if (string_length(test_line) <= 80)
    {
        question_line_1 = test_line;
    }
    else
    {
        question_line_2 +=
            (question_line_2 == "" ? "" : " ")
            + question_words[w];
    }
}


draw_text(
    question_x,
    question_y - 25,
    question_line_1
);


if (question_line_2 != "")
{
    draw_text(
        question_x,
        question_y + 25,
        question_line_2
    );
}

    // -------------------------------------------------
    // REVEAL ANSWER BUTTON
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
        draw_set_color(c_lime);
    }
    else
    {
        draw_set_color(c_green);
    }


    draw_rectangle(
        reveal_answer_button_x -
        reveal_answer_button_width / 2,

        reveal_answer_button_y -
        reveal_answer_button_height / 2,

        reveal_answer_button_x +
        reveal_answer_button_width / 2,

        reveal_answer_button_y +
        reveal_answer_button_height / 2,

        false
    );


    draw_set_color(c_white);

    draw_text(
        reveal_answer_button_x,
        reveal_answer_button_y,
        "REVEAL ANSWER"
    );
}


// =====================================================
// STATE 3
// TEAM JUDGING
// =====================================================

else if (game_state == 3)
{
    draw_set_color(c_white);


    // -------------------------------------------------
    // TITLE
    // -------------------------------------------------

    draw_text(
        title_x,
        title_y,
        "FINAL JEOPARDY"
    );


    // -------------------------------------------------
    // ANSWER
    // -------------------------------------------------

    draw_text(
        answer_x,
        answer_y,
        current_answer
    );


    // -------------------------------------------------
    // CURRENT TEAM
    // -------------------------------------------------

    draw_text(
        judging_team_x,
        judging_team_y,
        "TEAM " +
        string(current_judging_team + 1)
    );


    // -------------------------------------------------
    // WAGER
    // -------------------------------------------------

    draw_text(
        judging_wager_x,
        judging_wager_y,
        "WAGER: $" +
        string(
            team_wagers[current_judging_team]
        )
    );


    // -------------------------------------------------
    // CORRECT BUTTON
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
        draw_set_color(c_lime);
    }
    else
    {
        draw_set_color(c_green);
    }


    draw_rectangle(
        correct_button_x -
        judging_button_width / 2,

        judging_button_y -
        judging_button_height / 2,

        correct_button_x +
        judging_button_width / 2,

        judging_button_y +
        judging_button_height / 2,

        false
    );


    draw_set_color(c_white);

    draw_text(
        correct_button_x,
        judging_button_y,
        "CORRECT"
    );


    // -------------------------------------------------
    // INCORRECT BUTTON
    // -------------------------------------------------

    if (point_in_rectangle(
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
        draw_set_color(c_lime);
    }
    else
    {
        draw_set_color(c_red);
    }


    draw_rectangle(
        incorrect_button_x -
        judging_button_width / 2,

        judging_button_y -
        judging_button_height / 2,

        incorrect_button_x +
        judging_button_width / 2,

        judging_button_y +
        judging_button_height / 2,

        false
    );


    draw_set_color(c_white);

    draw_text(
        incorrect_button_x,
        judging_button_y,
        "INCORRECT"
    );
}


// =====================================================
// STATE 4
// FINAL SCORES
// =====================================================

else if (game_state == 4)
{
    draw_set_color(c_white);


    // -------------------------------------------------
    // TITLE
    // -------------------------------------------------

    draw_text(
        final_score_title_x,
        final_score_title_y,
        "FINAL SCORES"
    );


    // -------------------------------------------------
    // TEAM SCORES
    // -------------------------------------------------

    for (var t = 0; t < global.team_count; t++)
    {
        var draw_team_y =
            final_score_start_y +
            (t * final_score_spacing);


        draw_text(
            final_score_x,
            draw_team_y,

            "TEAM " +
            string(t + 1) +
            "     $" +
            string(global.team_scores[t])
        );
    }
}


// =====================================================
// RESET DRAW SETTINGS
// =====================================================

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);