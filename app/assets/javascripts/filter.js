function details_filter() {
    var paramsString = getParamsString();
    window.location.href = window.location.href.split('?')[0] + paramsString, true;
}

function reset_filters() {
    var roomType = document.getElementById('roomtype_column');
    var inputs = roomType.getElementsByTagName('input');
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].checked = true;
    }
    
    var features = document.getElementById('facilities_column');
    inputs = features.getElementsByTagName('input');
    for (var i = 0; i < inputs.length; i++) {
        inputs[i].checked = false;
    }
    
    document.getElementById('capacityLower').value = 0;
    document.getElementById('capacityUpper').value = 1000;
    
    document.getElementById('filters-submit').click();
}

/*  Limit the value of capacity field to be greater than or equal to 0,
 *  and lower bound <= upper bound.
 */
function limit() {
    var capacityLower = document.getElementById("capacityLower");
    var capacityUpper = document.getElementById("capacityUpper");
    capacityLower.value = Math.max(0, capacityLower.value);
	capacityUpper.value = Math.max(capacityLower.value, capacityUpper.value);
}

// Update tags based on checkboxes.
function update_tags() {
    var classroom = document.getElementById("Classroom").checked;
    var lectureHall = document.getElementById("LectureHall").checked;
    var auditorium = document.getElementById("Auditorium").checked;
    var seminarRoom = document.getElementById("SeminarRoom").checked;
    var otherRooms = document.getElementById("OtherRooms").checked;
    var studentAccessible = document.getElementById("StudentAccessible").checked;
    var board = document.getElementById("Board").checked;
    var AV = document.getElementById("AV").checked;
    classroom ? $('#Classroom_tag').show() : $('#Classroom_tag').hide();
    lectureHall ? $('#LectureHall_tag').show() : $('#LectureHall_tag').hide();
    auditorium ? $('#Auditorium_tag').show() : $('#Auditorium_tag').hide();
    seminarRoom ? $('#SeminarRoom_tag').show() : $('#SeminarRoom_tag').hide();
    otherRooms ? $('#OtherRooms_tag').show() : $('#OtherRooms_tag').hide();
    studentAccessible ? $('#StudentAccessible_tag').show() : $('#StudentAccessible_tag').hide();
    board ? $('#Board_tag').show() : $('#Board_tag').hide();
    AV ? $('#AV_tag').show() : $('#AV_tag').hide();
}

// When click 'show', update tags and the update the map.
function filter_update(e) {
    update_tags();
    $('.collapse').collapse("hide")
    filterMarkers(e);
}

function remove_tag(tag_name) {
    checkbox = document.getElementById(tag_name);
    checkbox.checked = false;
    updateMarkers();
    tag = document.getElementById(tag_name + "_tag");
    $(tag).hide();
}

function details_remove_tag(tag_name) {
    remove_tag(tag_name);
    details_filter();
    updateMarkers()
}

window.onload = function () {
    var url = window.location.href;
    if(url.indexOf('?') == -1) {
        document.getElementById("Classroom").checked = true;
        document.getElementById("LectureHall").checked = true;
        document.getElementById("Auditorium").checked = true;
        document.getElementById("SeminarRoom").checked = true;
        document.getElementById("OtherRooms").checked = true;
        updateMarkers()
    }
    update_tags();
}

$(document).on('turbolinks:load', function() {
    update_tags();
});