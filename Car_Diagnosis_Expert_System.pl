% ------------------------------------------
% Expert System: Car Diagnosis

% ------------------------------------------

% Declare symptom/1 as dynamic so we can add/remove symptoms during runtime
:- dynamic symptom/1.

% -------------------------------------------------
% Mapping from symptoms to human-friendly questions
% -------------------------------------------------

symptom_question(ignition_on, "Is the ignition turning on when you try to start the car?").
symptom_question(engine_fails_to_crank, "Does the engine fail to crank (turn over)?").
symptom_question(fuel_level_enough, "Is there enough fuel in the tank?").
symptom_question(bad_slow_running_jet_block, "Do you suspect the slow running jet block might be clogged or faulty?").
symptom_question(lack_of_fuel_supply, "Is there a lack of fuel reaching the engine?").
symptom_question(engine_cranking_slow, "Does the engine crank slowly when trying to start?").
symptom_question(no_spark, "Is there no spark from the spark plugs?").
symptom_question(battery_weak, "Is the battery weak or low on charge?").
symptom_question(starter_working_properly, "Is the starter motor working properly?").
symptom_question(vehicle_jerking_gradual_motion, "Does the vehicle jerk while driving or accelerating gradually?").
symptom_question(unusual_temperature_increase, "Does the temperature gauge show an unusual increase?").
symptom_question(engine_overheating, "Is the engine overheating?").
symptom_question(radiator_water_level_ok, "Is the radiator water level normal?").
symptom_question(radiator_fan_working, "Is the radiator fan working correctly?").
symptom_question(no_radiator_leakage, "Is there no leakage from the radiator?").
symptom_question(engine_still_overheating, "Is the engine still overheating despite the above conditions?").
symptom_question(radiator_leaking, "Is the radiator leaking coolant?").
symptom_question(radiator_fan_not_functioning, "Is the radiator fan not functioning at all?").
symptom_question(oil_loss_over_time, "Has there been a noticeable loss of oil over time?").
symptom_question(blue_smoke_or_burning_oil_smell, "Is there blue smoke or a burning oil smell from the exhaust?").
symptom_question(engine_fluid_stains, "Are there fluid stains under the engine area?").
symptom_question(unusual_exhaust_smoke_emission, "Is there unusual smoke coming from the exhaust?").
symptom_question(smoke_color_black_or_gray, "Is the exhaust smoke black or gray?").
symptom_question(smoke_color_blue, "Is the exhaust smoke blue?").
symptom_question(smoke_color_white, "Is the exhaust smoke white?").
 symptom_question(problem_persists, "Does the problem still persist ?").

% --------------------------------------------------
% Logical rules to infer diagnoses based on symptoms
% Each rule represents a diagnostic decision or expert recommendation
% -------------------------------------------------------------------

% Rule 1
diagnosis(clean_and_tighten_battery_terminals) :- symptom(ignition_on),symptom(engine_fails_to_crank).

% Rule 2
diagnosis(check_fuel_level) :- diagnosis(clean_and_tighten_battery_terminals),symptom(engine_fails_to_crank).

% Rule 3
diagnosis(check_switching_operation) :- diagnosis(clean_and_tighten_battery_terminals),symptom(fuel_level_enough),symptom(engine_fails_to_crank).

% Rule 4
diagnosis(major_electrical_issue_contact_expert) :- diagnosis(clean_and_tighten_battery_terminals),diagnosis(check_fuel_level),
    diagnosis(check_switching_operation),symptom(engine_fails_to_crank).

% Rule 5
diagnosis(change_fuel_pump) :- symptom(bad_slow_running_jet_block),symptom(lack_of_fuel_supply).

% Rule 6
diagnosis(check_change_fuel_pump_fuse) :- diagnosis(change_fuel_pump),symptom(problem_persists).

% Rule 7
diagnosis(replace_slow_running_jet_with_expert_help) :- diagnosis(check_change_fuel_pump_fuse),symptom(problem_persists).

% Rule 8
diagnosis(check_battery_due_to_slow_cranking) :- symptom(engine_cranking_slow),symptom(no_spark).

% Rule 9
diagnosis(charge_battery) :- diagnosis(check_battery_due_to_slow_cranking),symptom(battery_weak).

% Rule 10
diagnosis(check_or_test_starter) :- diagnosis(check_battery_due_to_slow_cranking),diagnosis(charge_battery),symptom(engine_cranking_slow),
    symptom(no_spark).

% Rule 11
diagnosis(replace_battery) :- diagnosis(check_or_test_starter),symptom(starter_working_properly).

% Rule 12
diagnosis(replace_battery_and_starter_contact_expert) :- diagnosis(check_battery_due_to_slow_cranking),diagnosis(charge_battery),
    diagnosis(check_or_test_starter),symptom(engine_cranking_slow),symptom(no_spark).

% Rule 13
diagnosis(check_spark_plug_and_contact_set) :- symptom(vehicle_jerking_gradual_motion).

% Rule 14
diagnosis(possible_major_fault_contact_expert) :- diagnosis(check_spark_plug_and_contact_set),symptom(vehicle_jerking_gradual_motion).

% Rule 15
diagnosis(check_radiator_water_and_fan) :- symptom(unusual_temperature_increase),symptom(engine_overheating).

% Rule 16
diagnosis(stop_and_cool_engine) :- diagnosis(check_radiator_water_and_fan),symptom(radiator_water_level_ok),
    symptom(radiator_fan_working),symptom(no_radiator_leakage),symptom(engine_still_overheating).

% Rule 17
diagnosis(major_cooling_fault_contact_expert) :- diagnosis(check_radiator_water_and_fan),diagnosis(stop_and_cool_engine),
    symptom(engine_still_overheating).

% Rule 18
diagnosis(radiator_fault_contact_expert) :- symptom(radiator_leaking);symptom(radiator_fan_not_functioning).

% Rule 19
diagnosis(check_oil_leak_with_expert_help) :- symptom(oil_loss_over_time),symptom(blue_smoke_or_burning_oil_smell),
    symptom(engine_fluid_stains).

% Rule 20
diagnosis(observe_exhaust_smoke_color) :- symptom(unusual_exhaust_smoke_emission).

% Rule 21
diagnosis(black_or_gray_smoke_issue_contact_expert) :- diagnosis(observe_exhaust_smoke_color),symptom(smoke_color_black_or_gray).

% Rule 22
diagnosis(blue_smoke_oil_leak_issue_contact_expert) :- diagnosis(observe_exhaust_smoke_color),symptom(smoke_color_blue).

% Rule 23
diagnosis(white_smoke_coolant_leak_issue_contact_expert) :- diagnosis(observe_exhaust_smoke_color),symptom(smoke_color_white).

% ------------------------------
% Explanation for each diagnosis
% These are shown after identifying possible issues
% -------------------------------------------------

diagnosis_explanation(clean_and_tighten_battery_terminals, "The battery terminals may be dirty or loose, which prevents proper starting.").
diagnosis_explanation(check_fuel_level, "Ensure the vehicle has enough fuel to start.").
diagnosis_explanation(check_switching_operation, "The ignition or fuel system switch may not be working properly.").
diagnosis_explanation(major_electrical_issue_contact_expert, "There may be a significant electrical problem. Contact an expert.").
diagnosis_explanation(change_fuel_pump, "The fuel pump might be faulty and needs replacement.").
diagnosis_explanation(check_change_fuel_pump_fuse, "The fuel pump fuse may be faulty. Consider checking or replacing it.").
diagnosis_explanation(replace_slow_running_jet_with_expert_help, "The slow running jet might be blocked. Expert help is recommended.").
diagnosis_explanation(check_battery_due_to_slow_cranking, "The battery may be weak and unable to crank the engine effectively.").
diagnosis_explanation(charge_battery, "The battery is weak and needs charging.").
diagnosis_explanation(check_or_test_starter, "The starter motor might need testing or repair.").
diagnosis_explanation(replace_battery, "The battery is not holding charge and needs replacement.").
diagnosis_explanation(replace_battery_and_starter_contact_expert, "Both battery and starter may be faulty. Expert inspection recommended.").
diagnosis_explanation(check_spark_plug_and_contact_set, "Spark plug or contact set might be causing misfiring.").
diagnosis_explanation(possible_major_fault_contact_expert, "Vehicle behavior suggests a major issue. Contact an expert.").
diagnosis_explanation(check_radiator_water_and_fan, "Cooling system should be checked for water level and fan operation.").
diagnosis_explanation(stop_and_cool_engine, "Stop the vehicle and allow the engine to cool down.").
diagnosis_explanation(major_cooling_fault_contact_expert, "The engine cooling system may have a major fault. Contact a mechanic.").
diagnosis_explanation(radiator_fault_contact_expert, "The radiator has a visible issue (leak/fan failure). Seek help.").
diagnosis_explanation(check_oil_leak_with_expert_help, "Oil leaks can lead to engine damage. Seek professional inspection.").
diagnosis_explanation(observe_exhaust_smoke_color, "Check the exhaust smoke color—it can indicate engine issues.").
diagnosis_explanation(black_or_gray_smoke_issue_contact_expert, "Black or gray smoke suggests combustion issues. See a technician.").
diagnosis_explanation(blue_smoke_oil_leak_issue_contact_expert, "Blue smoke indicates oil leakage into the engine.").
diagnosis_explanation(white_smoke_coolant_leak_issue_contact_expert, "White smoke may mean coolant is leaking into the engine.").

% -------------------------------------------------------------
% Group diagnoses into categories to organize results (general,
% electrical, cooling, fuel, ignition, engine oil, exhaust)
% -------------------------------------------------------------

diagnosis_category(clean_and_tighten_battery_terminals, electrical).
diagnosis_category(check_fuel_level, fuel).
diagnosis_category(check_switching_operation, electrical).
diagnosis_category(major_electrical_issue_contact_expert, electrical).
diagnosis_category(change_fuel_pump, fuel).
diagnosis_category(check_change_fuel_pump_fuse, fuel).
diagnosis_category(replace_slow_running_jet_with_expert_help, fuel).
diagnosis_category(check_battery_due_to_slow_cranking, electrical).
diagnosis_category(charge_battery, electrical).
diagnosis_category(check_or_test_starter, electrical).
diagnosis_category(replace_battery, electrical).
diagnosis_category(replace_battery_and_starter_contact_expert, electrical).
diagnosis_category(check_spark_plug_and_contact_set, ignition).
diagnosis_category(possible_major_fault_contact_expert, general).
diagnosis_category(check_radiator_water_and_fan, cooling).
diagnosis_category(stop_and_cool_engine, cooling).
diagnosis_category(major_cooling_fault_contact_expert, cooling).
diagnosis_category(radiator_fault_contact_expert, cooling).
diagnosis_category(check_oil_leak_with_expert_help, engine_oil).
diagnosis_category(observe_exhaust_smoke_color, exhaust).
diagnosis_category(black_or_gray_smoke_issue_contact_expert, exhaust).
diagnosis_category(blue_smoke_oil_leak_issue_contact_expert, exhaust).
diagnosis_category(white_smoke_coolant_leak_issue_contact_expert, exhaust).

% --------------------------------------
% Asks the user about a specific symptom
% --------------------------------------

ask_symptom(Symptom) :-
    symptom_question(Symptom, Question),
    repeat,
    format('~w (yes/no): ', [Question]),
    read(Response),
    normalize_response(Response, Normalized),
    (Normalized == invalid ->
        writeln('Please answer with yes, y, no, or n.'),
        fail
    ; (Normalized == yes -> assertz(symptom(Symptom)) ; true),
      !
    ).

normalize_response(yes, yes).
normalize_response(y, yes).
normalize_response(no, no).
normalize_response(n, no).
normalize_response(_, invalid).

% ----------------------------------------
% Asks questions based on previous answers
% Skips irrelevant questions using logical flow
% ---------------------------------------------

collect_symptoms :-
    ask_symptom(ignition_on),
    ask_symptom(engine_fails_to_crank),
    (
        symptom(engine_fails_to_crank) ->
            ask_symptom(fuel_level_enough),
            ask_symptom(engine_cranking_slow),
            (
                symptom(engine_cranking_slow) ->
                    ask_symptom(no_spark),
                    ask_symptom(battery_weak),
                    (
                        \+ symptom(battery_weak) ->
                            ask_symptom(starter_working_properly)
                        ; true
                    )
                ; true
            )
        ;
            true
    ),

    ask_symptom(vehicle_jerking_gradual_motion),

    ask_symptom(unusual_temperature_increase),
    (
        symptom(unusual_temperature_increase) ->
            ask_symptom(engine_overheating),
            ask_symptom(radiator_water_level_ok),
            ask_symptom(radiator_fan_working),
            ask_symptom(no_radiator_leakage),
            ask_symptom(engine_still_overheating)
        ; true
    ),
    ask_symptom(radiator_leaking),
    ask_symptom(radiator_fan_not_functioning),

    ask_symptom(oil_loss_over_time),
    (
        symptom(oil_loss_over_time) ->
            ask_symptom(blue_smoke_or_burning_oil_smell),
            ask_symptom(engine_fluid_stains)
        ; true
    ),

    ask_symptom(unusual_exhaust_smoke_emission),
    (
        symptom(unusual_exhaust_smoke_emission) ->
            ask_symptom(smoke_color_black_or_gray),
            ask_symptom(smoke_color_blue),
            ask_symptom(smoke_color_white)
        ; true
    ),

    ask_symptom(bad_slow_running_jet_block),
    ask_symptom(lack_of_fuel_supply),
    ask_symptom(problem_persists).


% Clears any previously stored symptoms before starting a new diagnosis
clear_symptoms :- retractall(symptom(_)).

% --------------------------------------------------------
% Entry point: collects symptoms, finds matching diagnoses,
% and prints grouped results
% --------------------------------------------------------

run_diagnosis :-
    clear_symptoms,
    collect_symptoms,
    nl, write('--- Grouped Diagnoses ---'), nl,
    findall(Category-Diagnosis,
        (diagnosis(Diagnosis), diagnosis_category(Diagnosis, Category)),
        Results),
    group_diagnoses_by_category(Results).

% ----------------------------------------------------------------------
% Groups diagnoses by category and formats them for user-friendly display
% -----------------------------------------------------------------------

group_diagnoses_by_category([]).
group_diagnoses_by_category(Results) :-
    sort(Results, Sorted),  % Remove duplicates and sort
    group_pairs_by_key(Sorted, Grouped),  % From Category-Diagnosis to Category-[Diagnoses]
    print_grouped_diagnoses(Grouped).

print_grouped_diagnoses([]).
print_grouped_diagnoses([Category-DList | Rest]) :-
    nl, write('======================================='), nl,
    format(" ~w SYSTEM ISSUES~n", [Category]),
    write('---------------------------------------'), nl,
    print_each_diagnosis(DList),
    print_grouped_diagnoses(Rest).

print_each_diagnosis([]).
print_each_diagnosis([D | Rest]) :-
    format('• Diagnosis: ~w~n', [D]),
    (diagnosis_explanation(D, Explanation) ->
        format('  → "~w"~n', [Explanation])
    ;   write('  → No explanation available.~n')),
    nl,
    print_each_diagnosis(Rest).


