function inputKeyUp()
{
    var input, filter, ul, li, a, i, txtValue;
    input = document.getElementById('station-search-input');
    filter = input.value.toUpperCase();
    ul = document.getElementById("station-ul");
    li = ul.getElementsByTagName('li');

    // Loop through all list items, and hide those who don't match the search query
    for (i = 0; i < li.length; i++) {
        a = li[i].getElementsByTagName("a")[0];
        txtValue = a.textContent || a.innerText;
        if (txtValue.toUpperCase().indexOf(filter) > -1) {
            li[i].style.display = "";
        } else {
            li[i].style.display = "none";
        }
    }
}

function stationClick(id)
{
    const value = id.substring(offsetIndex)
    const station = document.getElementById(id)
    if (arrival_station_id === "")
    {
        paintListItem(station, 'cornflowerBlue', 'white', 'true')
        arrival_station_id = value;
        document.querySelector('#confirm-choice-btn').disabled = false
    }
    else
    {
        if(station.dataset.chosen === 'true')
        {
            paintListItem(station, '#eee', 'black', 'false')
            arrival_station_id = "";
            document.querySelector('#confirm-choice-btn').disabled = true
        }
        else
        {
            const prevStation = document.getElementById('station-' + arrival_station_id);
            paintListItem(prevStation, '#eee', 'black', 'false')
            paintListItem(station, 'cornflowerBlue', 'white', 'true')
            arrival_station_id = value;
            document.querySelector('#confirm-choice-btn').disabled = false
        }
    }
    document.querySelector('input[name="arrival_station_id"]').value = arrival_station_id;
    console.log(arrival_station_id)
}

function paintListItem(item, bgColor, color, choose)
{
    item.style.backgroundColor = bgColor;
    item.style.color = color;
    item.dataset.chosen = choose;
}

function validate(item)
{
    return item.value === ""
}

function swap(item_a, item_b)
{
    var temp = item_a.value
    item_a.value = item_b.value
    item_b.value = temp
}

function switchValues()
{
    swap(document.querySelector('#arrival-station'), document.querySelector('#departure-station'))
    keyUp(document.querySelector('#departure-station'))
}

function keyUp(input)
{
    document.querySelector('#find-trains').disabled = input.value === "";
}