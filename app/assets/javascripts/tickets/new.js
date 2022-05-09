function goBack()
{
    document.querySelector('#carriage-pick-h2').style.display = ""
    document.querySelector('#carriage-h2-div').remove()
    document.querySelector('.carriage').remove()
    document.querySelector('#carriage-order-buttons').remove()
    document.querySelector('#train-carriages-list').style.display = ""
}

function pickSeat(item)
{
    if (chosen === '-')
    {
        chosenButton = item
        chosenButton.style.color = "red"
        chosen = item.value
        document.querySelector('#seat-span').innerHTML = item.textContent
        document.querySelector('#confirm-order-button').disabled = false
    }
    else
    {
        if (chosenButton.value === item.value)
        {
            chosen = '-'
            chosenButton.style.color = "white"
            chosenButton = ""
            document.querySelector('#seat-span').innerHTML = chosen
            document.querySelector('#confirm-order-button').disabled = true
        }
        else
        {
            chosenButton.style.color = "white"
            chosenButton = item
            chosenButton.style.color = "red"
            chosen = item.value
            document.querySelector('#seat-span').innerHTML = item.textContent
            document.querySelector('#confirm-order-button').disabled = false
        }
    }
}
