define ['Zuark'], (Zuark)->

    string =
        isInt:(str, flag = '')->
            switch flag
                when '+' then return /^\+?\d+$/.test str
                when '-' then return /^-\d+$/.test str
                else return /^[+-]?\d+$/.test str
        isNumber: (str, flag = '')->
            switch flag
                when '+' then return /^\+?\d+(\.\d+)?$/.test str
                when '-' then return /^-\d+(\.\d+)?$/.test str
                else return /^[+-]?\d+(\.\d+)?$/.test str



    Zuark.string = string
    return Zuark