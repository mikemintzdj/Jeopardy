// =====================================================
// ONLY DRAW IN SETUP ROOM
// =====================================================

if (room != room_setup)
    exit;


// =====================================================
// DRAW SETTINGS
// =====================================================

draw_set_halign(fa_center);
draw_set_valign(fa_middle);


// =====================================================
// CLASS SELECTION
// =====================================================

if (menu_stage == 0)
{
    // -------------------------------------------------
    // SELECT CLASS
    // -------------------------------------------------

    draw_set_color(c_white);

    draw_text(
        room_width / 2,
        150,
        "SELECT CLASS"
    );


    // -------------------------------------------------
    // CLASS LIST
    // -------------------------------------------------

    for (var i = 0; i < array_length(class_names); i++)
    {
        var draw_y =
            class_select_y +
            (i * class_select_spacing);


        if (i == hovered_class)
        {
            draw_set_color(c_lime);
        }
        else if (i == selected_class)
        {
            draw_set_color(c_lime);
        }
        else
        {
            draw_set_color(c_white);
        }


        draw_text(
            class_select_x,
            draw_y,
            class_names[i]
        );
    }


    draw_set_color(c_white);


    // -------------------------------------------------
    // INSTRUCTION
    // -------------------------------------------------

    draw_text(
        room_width / 2,
        400,
        "ARROW KEYS TO SELECT"
    );


    draw_text(
        room_width / 2,
        430,
        "SPACE TO CONTINUE"
    );
}


// =====================================================
// UNIT SELECTION
// =====================================================

else if (menu_stage == 1)
{
    // -------------------------------------------------
    // SELECT UNIT
    // -------------------------------------------------

    draw_set_color(c_white);

    draw_text(
        room_width / 2,
        150,
        "SELECT UNIT"
    );


    // -------------------------------------------------
    // SELECTED CLASS
    // -------------------------------------------------

    draw_text(
        room_width / 2,
        180,
        class_names[selected_class]
    );


    // -------------------------------------------------
    // UNIT LIST
    // -------------------------------------------------

    var page_start =
        unit_page * units_per_page;

    var page_end =
        min(
            page_start + units_per_page,
            array_length(unit_names)
        );


    for (var i = page_start; i < page_end; i++)
    {
        var display_index =
            i - page_start;


        var draw_y =
            unit_select_y +
            (display_index * unit_select_spacing);


        if (i == hovered_unit)
        {
            draw_set_color(c_lime);
        }
        else if (i == selected_unit)
        {
            draw_set_color(c_lime);
        }
        else
        {
            draw_set_color(c_white);
        }


        draw_text(
            unit_select_x,
            draw_y,
            unit_names[i]
        );
    }


    draw_set_color(c_white);


    // -------------------------------------------------
    // PAGE NAVIGATION
    // -------------------------------------------------

    // BACK ARROW

    if (unit_page > 0)
    {
        if (point_in_rectangle(
            mouse_x,
            mouse_y,
            unit_back_x - 50,
            unit_page_y - 25,
            unit_back_x + 50,
            unit_page_y + 25
        ))
        {
            draw_set_color(c_lime);
        }
        else
        {
            draw_set_color(c_white);
        }
    }
    else
    {
        draw_set_color(c_gray);
    }


    draw_text(
        unit_back_x,
        unit_page_y,
        "< BACK"
    );


    // -------------------------------------------------
    // PAGE NUMBER
    // -------------------------------------------------

    draw_set_color(c_white);

    draw_text(
        unit_page_number_x,
        unit_page_y,
        "PAGE " +
        string(unit_page + 1) +
        " OF " +
        string(unit_page_count)
    );


    // -------------------------------------------------
    // NEXT ARROW
    // -------------------------------------------------

    if (unit_page < unit_page_count - 1)
    {
        if (point_in_rectangle(
            mouse_x,
            mouse_y,
            unit_next_x - 50,
            unit_page_y - 25,
            unit_next_x + 50,
            unit_page_y + 25
        ))
        {
            draw_set_color(c_lime);
        }
        else
        {
            draw_set_color(c_white);
        }
    }
    else
    {
        draw_set_color(c_gray);
    }


    draw_text(
        unit_next_x,
        unit_page_y,
        "NEXT >"
    );


    draw_set_color(c_white);


    // -------------------------------------------------
    // INSTRUCTIONS
    // -------------------------------------------------

    draw_text(
        room_width / 2,
        550,
        "ARROW KEYS TO SELECT"
    );


    draw_text(
        room_width / 2,
        580,
        "SPACE TO START GAME"
    );
}


// =====================================================
// NUMBER OF TEAMS
// =====================================================

draw_set_color(c_white);

draw_text(
    room_width / 2,
    team_count_y - 35,
    "NUMBER OF TEAMS"
);


// =====================================================
// TEAM COUNT BUTTONS
// =====================================================

for (var t = 1; t <= 6; t++)
{
    var team_x =
        room_width / 2 - 150 + ((t - 1) * 60);

    var team_y =
        team_count_y + 10;


    // -------------------------------------------------
    // Button color
    // -------------------------------------------------

    if (t == team_count)
    {
        draw_set_color(c_lime);
    }
    else if (t == hovered_team)
    {
        draw_set_color(c_yellow);
    }
    else
    {
        draw_set_color(c_white);
    }


    // -------------------------------------------------
    // Button outline
    // -------------------------------------------------

    draw_rectangle(
        team_x - 25,
        team_y - 25,
        team_x + 25,
        team_y + 25,
        true
    );


    // -------------------------------------------------
    // Team number
    // -------------------------------------------------

    draw_text(
        team_x,
        team_y,
        string(t)
    );
}


draw_set_color(c_white);


// =====================================================
// QUESTION TIMER
// =====================================================

draw_set_halign(fa_center);
draw_set_valign(fa_middle);


// -----------------------------------------------------
// TIMER TITLE
// -----------------------------------------------------

draw_set_color(c_white);

draw_text(
    timer_adjust_x,
    timer_adjust_y - 40,
    "QUESTION TIMER"
);


// -----------------------------------------------------
// MINUS BUTTON
// -----------------------------------------------------

if (point_in_rectangle(
    mouse_x,
    mouse_y,

    timer_adjust_x -
    timer_button_offset -
    timer_button_size / 2,

    timer_adjust_y -
    timer_button_size / 2,

    timer_adjust_x -
    timer_button_offset +
    timer_button_size / 2,

    timer_adjust_y +
    timer_button_size / 2
))
{
    draw_set_color(c_lime);
}
else
{
    draw_set_color(c_white);
}

draw_text(
    timer_adjust_x -
    timer_button_offset,

    timer_adjust_y,

    "-"
);


// -----------------------------------------------------
// CURRENT TIMER
// -----------------------------------------------------

draw_set_color(c_white);

draw_text(
    timer_adjust_x,
    timer_adjust_y,

    string(question_timer) + " SECONDS"
);


// -----------------------------------------------------
// PLUS BUTTON
// -----------------------------------------------------

if (point_in_rectangle(
    mouse_x,
    mouse_y,

    timer_adjust_x +
    timer_button_offset -
    timer_button_size / 2,

    timer_adjust_y -
    timer_button_size / 2,

    timer_adjust_x +
    timer_button_offset +
    timer_button_size / 2,

    timer_adjust_y +
    timer_button_size / 2
))
{
    draw_set_color(c_lime);
}
else
{
    draw_set_color(c_white);
}

draw_text(
    timer_adjust_x +
    timer_button_offset,

    timer_adjust_y,

    "+"
);


// =====================================================
// START GAME BUTTON
// =====================================================

var mouse_over_start =
    mouse_x >= start_button_x - start_button_width / 2 &&
    mouse_x <= start_button_x + start_button_width / 2 &&
    mouse_y >= start_button_y - start_button_height / 2 &&
    mouse_y <= start_button_y + start_button_height / 2;


if (mouse_over_start)
{
    draw_set_color(c_lime);
}
else
{
    draw_set_color(c_red);
}


draw_rectangle(
    start_button_x - start_button_width / 2,
    start_button_y - start_button_height / 2,
    start_button_x + start_button_width / 2,
    start_button_y + start_button_height / 2,
    false
);


draw_set_color(c_white);


draw_text(
    start_button_x,
    start_button_y,
    "START GAME"
);


// =====================================================
// RESET DRAW SETTINGS
// =====================================================

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);