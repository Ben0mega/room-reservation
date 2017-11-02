// Update the capacity dropdown list based on the selection made in room type dropdown list.
function update_capacity() {
    // TODO
    var type = document.getElementById("type_drop").value;
    var capacity_select = document.getElementById("capacity_drop");
    switch(type) {
        case "Classroom":
            // capacity_select.empty();
            // var option = document.createElement("option");
            // option.text = "20 - 39";
            // option.value = 1;
            // console.log("classroom")
            break;
        case "Lecture Hall":
            // console.log("lecture")
            break;
        case "Auditorium":
            // console.log("auditorium")
            break;
        case "Seminar Room":
            // console.log("seminar")
            break;
        default:
            // console.log("any")
            break;
    }
}