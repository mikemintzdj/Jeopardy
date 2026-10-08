// =====================================================
// DRAW SETTINGS
// =====================================================

draw_set_halign(fa_center);
draw_set_valign(fa_middle);


// =====================================================
// BOARD
// =====================================================

if (game_state == 0)
{
    // -------------------------------------------------
    // DRAW BOARD
    // -------------------------------------------------

    draw_sprite(
        spr_board,
        0,
        board_x,
        board_y
    );


    // -------------------------------------------------
    // UNIT TITLE
    // -------------------------------------------------

    draw_set_color(c_white);

    draw_text(
        board_x + unit_x,
        board_y + unit_y,
        global.selected_jeopardy_unit
    );


    // -------------------------------------------------
    // SECTION TITLE
    // -------------------------------------------------

    draw_text(
        board_x + section_x,
        board_y + section_y,
        "Jeopardy"
    );


    // -------------------------------------------------
    // CATEGORY HEADERS
    // -------------------------------------------------

    for (var i = 0; i < 5; i++)
    {
        var category =
            jeopardy_section.categories[i];

        var category_name =
            category.name;

        var words =
            string_split(category_name, " ");

        var line_1 = "";
        var line_2 = "";

        for (var w = 0; w < array_length(words); w++)
        {
            if (string_length(line_1) == 0)
            {
                line_1 = words[w];
            }
            else if (string_length(line_1 + " " + words[w]) <= 12)
            {
                line_1 += " " + words[w];
            }
            else
            {
                line_2 +=
                    (string_length(line_2) > 0 ? " " : "")
                    + words[w];
            }
        }


        draw_text(
            board_x +
            category_start_x +
            (i * category_column_spacing),
            board_y +
            category_start_y -
            12,
            line_1
        );


        if (line_2 != "")
        {
            draw_text(
                board_x +
                category_start_x +
                (i * category_column_spacing),
                board_y +
                category_start_y +
                12,
                line_2
            );
        }
    }


    // -------------------------------------------------
    // HOVER HIGHLIGHT
    // -------------------------------------------------

    if (hovered_category != -1 &&
        hovered_question != -1)
    {
        var highlight_x =
            board_x +
            value_start_x +
            (hovered_category * value_column_spacing);

        var highlight_y =
            board_y +
            value_start_y +
            (hovered_question * value_row_spacing);

        draw_set_color(c_yellow);

        draw_rectangle(
            highlight_x - hover_width / 2,
            highlight_y - hover_height / 2,
            highlight_x + hover_width / 2,
            highlight_y + hover_height / 2,
            true
        );

        draw_set_color(c_white);
    }


    // -------------------------------------------------
    // DOLLAR VALUES
    // -------------------------------------------------

    for (var column = 0; column < 5; column++)
    {
        for (var row = 0; row < 5; row++)
        {
            var draw_x =
                board_x +
                value_start_x +
                (column * value_column_spacing);

            var draw_y =
                board_y +
                value_start_y +
                (row * value_row_spacing);


            // Played questions are gray
            if (played_questions[column][row])
            {
                draw_set_color(c_gray);
            }
            else
            {
                draw_set_color(c_white);
            }


            draw_text(
                draw_x,
                draw_y,
                "$" + string((row + 1) * 100)
            );

            draw_set_color(c_white);
        }
    }
}


// =====================================================
// QUESTION / ANSWER SCREEN
// =====================================================

else
{
    // -------------------------------------------------
    // ANSWER TILE
    // -------------------------------------------------

    draw_sprite(
        spr_answer_tile,
        0,
        board_x,
        board_y
    );


    // -------------------------------------------------
    // CATEGORY
    // -------------------------------------------------

    draw_text(
        board_x,
        board_y - 250,
        jeopardy_section
        .categories[selected_category]
        .name
    );


    // -------------------------------------------------
    // DOLLAR VALUE
    // -------------------------------------------------

    draw_text(
        board_x,
        board_y - 210,
        "$" + string((selected_question + 1) * 100)
    );


    // =================================================
    // QUESTION
    // =================================================

    if (game_state == 1)
    {
        // -------------------------------------------------
        // WRAP QUESTION AT 80 CHARACTERS
        // -------------------------------------------------

        var question_text = current_question.question;

        var question_words = string_split(question_text, " ");
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


        // -------------------------------------------------
        // QUESTION LINE 1
        // -------------------------------------------------

        draw_text(
            board_x,
            board_y - 25,
            question_line_1
        );


        // -------------------------------------------------
        // QUESTION LINE 2
        // -------------------------------------------------

        if (question_line_2 != "")
        {
            draw_text(
                board_x,
                board_y + 25,
                question_line_2
            );
        }


        // -------------------------------------------------
        // QUESTION TIMER
        // -------------------------------------------------

        draw_set_color(c_white);

        draw_text(
            question_timer_x,
            question_timer_y,
            string(ceil(question_timer))
        );


        // -------------------------------------------------
        // TIME'S UP
        // -------------------------------------------------

        if (question_timer <= 0)
        {
            draw_set_color(c_red);

            draw_text(
                question_timer_x,
                question_timer_y + 40,
                "TIME'S UP!"
            );
        }


        // -------------------------------------------------
        // REVEAL INSTRUCTION
        // -------------------------------------------------

        draw_text(
            board_x,
            board_y + 250,
            "CLICK TO REVEAL ANSWER"
        );
    }


    // =================================================
    // ANSWER
    // =================================================

    else if (game_state == 2)
    {
        // -------------------------------------------------
        // WRAP ANSWER AT 80 CHARACTERS
        // -------------------------------------------------

        var answer_text = current_answer;

        var answer_words = string_split(answer_text, " ");
        var answer_line_1 = "";
        var answer_line_2 = "";

        for (var w = 0; w < array_length(answer_words); w++)
        {
            var test_line =
                answer_line_1 == ""
                ? answer_words[w]
                : answer_line_1 + " " + answer_words[w];


            if (string_length(test_line) <= 80)
            {
                answer_line_1 = test_line;
            }
            else
            {
                answer_line_2 +=
                    (answer_line_2 == "" ? "" : " ")
                    + answer_words[w];
            }
        }


        // -------------------------------------------------
        // ANSWER LINE 1
        // -------------------------------------------------

        draw_text(
            board_x,
            board_y - 25,
            answer_line_1
        );


        // -------------------------------------------------
        // ANSWER LINE 2
        // -------------------------------------------------

        if (answer_line_2 != "")
        {
            draw_text(
                board_x,
                board_y + 25,
                answer_line_2
            );
        }


        // =================================================
        // CORRECT / INCORRECT BUTTONS
        // =================================================

        // -------------------------------------------------
        // CORRECT BUTTON
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
            draw_set_color(c_lime);
        }
        else
        {
            draw_set_color(c_green);
        }


        draw_rectangle(
            correct_button_x - answer_button_width / 2,
            answer_button_y - answer_button_height / 2,
            correct_button_x + answer_button_width / 2,
            answer_button_y + answer_button_height / 2,
            false
        );


        draw_set_color(c_white);


        draw_text(
            correct_button_x,
            answer_button_y,
            "CORRECT"
        );


        // -------------------------------------------------
        // INCORRECT BUTTON
        // -------------------------------------------------

        if (point_in_rectangle(
            mouse_x,
            mouse_y,
            incorrect_button_x - answer_button_width / 2,
            answer_button_y - answer_button_height / 2,
            incorrect_button_x + answer_button_width / 2,
            answer_button_y + answer_button_height / 2
        ))
        {
            draw_set_color(c_lime);
        }
        else
        {
            draw_set_color(c_red);
        }


        draw_rectangle(
            incorrect_button_x - answer_button_width / 2,
            answer_button_y - answer_button_height / 2,
            incorrect_button_x + answer_button_width / 2,
            answer_button_y + answer_button_height / 2,
            false
        );


        draw_set_color(c_white);


        draw_text(
            incorrect_button_x,
            answer_button_y,
            "INCORRECT"
        );


        // -------------------------------------------------
        // PASS BUTTON
        // -------------------------------------------------

        if (point_in_rectangle(
            mouse_x,
            mouse_y,
            pass_button_x - answer_button_width / 2,
            pass_button_y - answer_button_height / 2,
            pass_button_x + answer_button_width / 2,
            pass_button_y + answer_button_height / 2
        ))
        {
            draw_set_color(c_lime);
        }
        else
        {
            draw_set_color(c_gray);
        }


        draw_rectangle(
            pass_button_x - answer_button_width / 2,
            pass_button_y - answer_button_height / 2,
            pass_button_x + answer_button_width / 2,
            pass_button_y + answer_button_height / 2,
            false
        );


        draw_set_color(c_white);


        draw_text(
            pass_button_x,
            pass_button_y,
            "PASS"
        );
    }
}


// =====================================================
// TEAM SCORES
// DRAW LAST = ALWAYS ON TOP
// =====================================================

for (var t = 0; t < global.team_count; t++)
{
    var team_x =
        team_score_x;

    var team_y =
        team_start_y +
        (t * team_spacing);


    // -------------------------------------------------
    // CURRENT TEAM HIGHLIGHT
    // -------------------------------------------------

    if (t == global.current_team)
    {
        draw_set_color(c_lime);

        draw_rectangle(
            team_x - 90,
            team_y - 30,
            team_x + 90,
            team_y + 30,
            true
        );
    }


    // -------------------------------------------------
    // TEAM NAME
    // -------------------------------------------------

    draw_set_color(c_white);

    draw_text(
        team_x,
        team_y - 10,
        "TEAM " + string(t + 1)
    );


    // -------------------------------------------------
    // SCORE
    // -------------------------------------------------

    draw_text(
        team_x,
        team_y + 15,
        "$" + string(global.team_scores[t])
    );


    // -------------------------------------------------
    // SCORE ADJUSTMENT BUTTONS
    // -------------------------------------------------

    draw_set_color(c_white);


    // Minus
    draw_text(
        team_x - team_score_button_offset,
        team_y,
        "-"
    );


    // Plus
    draw_text(
        team_x + team_score_button_offset,
        team_y,
        "+"
    );
}


// =====================================================
// NEXT TEAM BUTTON
// =====================================================

var mouse_over_next_team =
    point_in_rectangle(
        mouse_x,
        mouse_y,
        team_next_button_x - team_next_button_width / 2,
        team_next_button_y - team_next_button_height / 2,
        team_next_button_x + team_next_button_width / 2,
        team_next_button_y + team_next_button_height / 2
    );


if (mouse_over_next_team)
{
    draw_set_color(c_lime);
}
else
{
    draw_set_color(c_white);
}


draw_rectangle(
    team_next_button_x - team_next_button_width / 2,
    team_next_button_y - team_next_button_height / 2,
    team_next_button_x + team_next_button_width / 2,
    team_next_button_y + team_next_button_height / 2,
    false
);


draw_set_color(c_black);


draw_text(
    team_next_button_x,
    team_next_button_y,
    "NEXT TEAM"
);


// =====================================================
// RESET DRAW SETTINGS
// =====================================================

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);