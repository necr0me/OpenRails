function validate()
{
    let list = document.querySelectorAll('.train-stops-ul > li')
    var isValid = true
    var lastValidInput
    console.log(list)
    list.forEach((li) =>
    {
        li.querySelector('i').style.color = "#0b5ed7"
        let id = li.id.substring('station-'.length)
        let arrInput = li.querySelector('#stop-arr-'+id)
        let depInput = li.querySelector('#stop-dep-'+id)
        if (arrInput.value!== "" && depInput.value !== "")
        {
            if( lastValidInput !== undefined && Date.parse(arrInput.value)<Date.parse(lastValidInput.value))
            {
                li.querySelector('i').style.color = "red"
                isValid=false
                return
            }
            if (validateInput(arrInput) && validateInput(depInput))
            {
                if (validateInputs(arrInput, depInput))
                {
                    lastValidInput = depInput
                    stops.push({station_id: li.id.substring('station-'.length),
                        arrival_time: arrInput.value,
                        departure_time: depInput.value})
                    paintDiv(li.querySelector('.stop-station-inputs'), "#0d6efd")
                }
                else
                {
                    paintDiv(li.querySelector('.stop-station-inputs'), "red")
                    isValid = false
                }
            }
            else
            {
                isValid = false
            }
        }
        else
        {
            paintBorder(arrInput, "red")
            paintBorder(depInput, "red")
            isValid = false
        }
        console.log(li)
        if (lastValidInput!== undefined)
            console.log(lastValidInput)
    })
    console.log(stops)
    console.log(isValid)
    if (!isValid)
        stops.length = 0
    else
        updateStops(stops)
}

function validateInput(input)
{
    if(Date.parse(input.value) < Date.now())
    {
        paintBorder(input, 'red')
        return false
    }
    clearBorder(input)
    return true
}

function validateInputs(inputArr, inputDep)
{
    return Date.parse(inputArr.value) <= Date.parse(inputDep.value);
}

function paintBorder(item, color)
{
    item.style.borderBottom = "1px solid "+ color;
}

function paintDiv(div, color)
{
    div.style.borderLeft = "3px solid " + color
}

function clearBorder(item)
{
    item.style.border = "none";
}