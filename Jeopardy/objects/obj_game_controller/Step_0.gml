// =====================================================
// ONLY RUN IN SETUP ROOM
// =====================================================

if (room != room_setup)
    exit;


// =====================================================
// CLASS SELECTION
// =====================================================

if (menu_stage == 0)
{
    // -------------------------------------------------
    // KEYBOARD CLASS SELECTION
    // -------------------------------------------------

    if (keyboard_check_pressed(vk_up))
    {
        selected_class--;

        if (selected_class < 0)
            selected_class = array_length(class_names) - 1;
    }


    if (keyboard_check_pressed(vk_down))
    {
        selected_class++;

        if (selected_class >= array_length(class_names))
            selected_class = 0;
    }


    // -------------------------------------------------
    // CLASS MOUSE HOVER
    // -------------------------------------------------

    hovered_class = -1;

    for (var i = 0; i < array_length(class_names); i++)
    {
        var hover_y =
            class_select_y +
            (i * class_select_spacing);


        if (point_in_rectangle(
            mouse_x,
            mouse_y,
            class_select_x - 200,
            hover_y - 20,
            class_select_x + 200,
            hover_y + 20
        ))
        {
            hovered_class = i;
        }
    }


    // -------------------------------------------------
    // CLASS MOUSE SELECTION
    // -------------------------------------------------

    if (mouse_check_button_pressed(mb_left))
    {
        if (hovered_class != -1)
        {
            selected_class = hovered_class;


            // Get the selected Class
            var selected_class_name =
                class_names[selected_class];


            var selected_class_data =
                global.jeopardy_library
                [$ selected_class_name];


            // Get the Units belonging to that Class
            unit_names =
                variable_struct_get_names(selected_class_data);


            // Start on first Unit
            selected_unit = 0;


            // Start on first page
            unit_page = 0;


            // Calculate number of pages
            unit_page_count =
                ceil(
                    array_length(unit_names) /
                    units_per_page
                );


            // Move to Unit selection
            menu_stage = 1;
        }
    }


    // -------------------------------------------------
    // CONTINUE TO UNIT SELECTION
    // -------------------------------------------------

    if (keyboard_check_pressed(vk_space))
    {
        // Get the selected Class
        var selected_class_name =
            class_names[selected_class];


        var selected_class_data =
            global.jeopardy_library
            [$ selected_class_name];


        // Get the Units belonging to that Class
        unit_names =
            variable_struct_get_names(selected_class_data);


        // Start on first Unit
        selected_unit = 0;


        // Start on first page
        unit_page = 0;


        // Calculate number of pages
        unit_page_count =
            ceil(
                array_length(unit_names) /
                units_per_page
            );


        // Move to Unit selection
        menu_stage = 1;
    }
}


// =====================================================
// UNIT SELECTION
// =====================================================

else if (menu_stage == 1)
{
    // -------------------------------------------------
    // NUMBER OF UNITS ON CURRENT PAGE
    // -------------------------------------------------

    var page_start =
        unit_page * units_per_page;

    var page_end =
        min(
            page_start + units_per_page,
            array_length(unit_names)
        );


    // -------------------------------------------------
    // KEYBOARD UNIT SELECTION
    // -------------------------------------------------

    if (keyboard_check_pressed(vk_up))
    {
        selected_unit--;

        if (selected_unit < page_start)
            selected_unit = page_end - 1;
    }


    if (keyboard_check_pressed(vk_down))
    {
        selected_unit++;

        if (selected_unit >= page_end)
            selected_unit = page_start;
    }


    // -------------------------------------------------
    // UNIT MOUSE HOVER
    // -------------------------------------------------

    hovered_unit = -1;

    for (var i = page_start; i < page_end; i++)
    {
        var display_index =
            i - page_start;


        var hover_y =
            unit_select_y +
            (display_index * unit_select_spacing);


        if (point_in_rectangle(
            mouse_x,
            mouse_y,
            unit_select_x - 200,
            hover_y - 20,
            unit_select_x + 200,
            hover_y + 20
        ))
        {
            hovered_unit = i;
        }
    }


    // -------------------------------------------------
    // UNIT MOUSE SELECTION
    // -------------------------------------------------

    if (mouse_check_button_pressed(mb_left))
    {
        if (hovered_unit != -1)
        {
            selected_unit = hovered_unit;
        }
    }


    // -------------------------------------------------
    // BACK TO CLASS SELECTION
    // -------------------------------------------------

    if (mouse_check_button_pressed(mb_left))
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
            menu_stage = 0;

            hovered_unit = -1;
        }
    }


    // -------------------------------------------------
    // NEXT PAGE
    // -------------------------------------------------

    if (mouse_check_button_pressed(mb_left))
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
            if (unit_page < unit_page_count - 1)
            {
                unit_page++;

                selected_unit =
                    unit_page * units_per_page;
            }
        }
    }


    // -------------------------------------------------
    // KEYBOARD BACK TO CLASS SELECTION
    // -------------------------------------------------

    if (keyboard_check_pressed(vk_backspace))
    {
        menu_stage = 0;

        hovered_unit = -1;
    }


    // -------------------------------------------------
    // START GAME
    // -------------------------------------------------

    if (keyboard_check_pressed(vk_space))
    {
        global.selected_jeopardy_class =
            class_names[selected_class];

        global.selected_jeopardy_unit =
            unit_names[selected_unit];

        global.team_count =
            team_count;

        global.question_timer =
            question_timer;

        room_goto(room_game);
    }
}


// =====================================================
// TEAM COUNT
// =====================================================

hovered_team = -1;

for (var t = 1; t <= 6; t++)
{
    var team_x =
        room_width / 2 - 150 + ((t - 1) * 60);

    var team_y =
        team_count_y + 10;


    if (point_in_rectangle(
        mouse_x,
        mouse_y,
        team_x - 25,
        team_y - 25,
        team_x + 25,
        team_y + 25
    ))
    {
        hovered_team = t;
        break;
    }
}


if (mouse_check_button_pressed(mb_left))
{
    if (hovered_team != -1)
    {
        team_count = hovered_team;
    }
}


// =====================================================
// QUESTION TIMER
// =====================================================

if (mouse_check_button_pressed(mb_left))
{
    // -------------------------------------------------
    // MINUS
    // -------------------------------------------------

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
        question_timer =
            max(
                question_timer - 1,
                question_timer_min
            );
    }


    // -------------------------------------------------
    // PLUS
    // -------------------------------------------------

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
        question_timer =
            min(
                question_timer + 1,
                question_timer_max
            );
    }
}


// =====================================================
// START GAME BUTTON
// =====================================================

if (menu_stage == 1 &&
    mouse_check_button_pressed(mb_left))
{
    if (mouse_x >= start_button_x - start_button_width / 2 &&
        mouse_x <= start_button_x + start_button_width / 2 &&
        mouse_y >= start_button_y - start_button_height / 2 &&
        mouse_y <= start_button_y + start_button_height / 2)
    {
        global.selected_jeopardy_class =
            class_names[selected_class];

        global.selected_jeopardy_unit =
            unit_names[selected_unit];

        global.team_count =
            team_count;

        global.question_timer =
            question_timer;

        room_goto(room_game);
    }
}