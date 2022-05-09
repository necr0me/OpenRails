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
    }
    else
    {
        if(station.dataset.chosen === 'true')
        {
            paintListItem(station, '#eee', 'black', 'false')
            arrival_station_id = "";
        }
        else
        {
            const prevStation = document.getElementById('station-' + arrival_station_id);
            paintListItem(prevStation, '#eee', 'black', 'false')
            paintListItem(station, 'cornflowerBlue', 'white', 'true')
            arrival_station_id = value;
        }
    }
    console.log(arrival_station_id)
}

function paintListItem(item, bgColor, color, choose)
{
    item.style.backgroundColor = bgColor;
    item.style.color = color;
    item.dataset.chosen = choose;
}