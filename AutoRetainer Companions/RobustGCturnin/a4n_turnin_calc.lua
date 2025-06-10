--a4n turnincalculator
--pointless calc and output

function formatNumberWithCommas(number)
    -- Validate input to ensure it is a number
    if type(number) ~= "number" then
        error("Invalid input: number expected, got " .. type(number))
    end

    -- Check if the number is an integer
    local is_integer = (number % 1 == 0)

    -- Convert to string based on whether it is an integer
    local formatted = is_integer and string.format("%d", number) or tostring(number)

    local k
    -- Loop to insert commas every three digits before the decimal
    while true do
        formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

--a4n_head  = nyet
a4n_hand  = math.floor(GetItemCount(12676) / 2)
a4n_body  = math.floor(GetItemCount(12675) / 4)
a4n_leg   = math.floor(GetItemCount(12677) / 4)
a4n_feet  = math.floor(GetItemCount(12678) / 2)
a4n_j     = math.floor(GetItemCount(12680))
iLevel    = 190
beegnumber = a4n_hand + a4n_body + a4n_leg + a4n_feet + a4n_j
beegernumber = beegnumber * iLevel * 1.5
gcbeegnumber = math.floor((beegnumber * 1093) / 600) * 360
gcbeegnumber10 = math.floor((beegnumber * 1203) / 600) * 360
gcbeegnumber15 = math.floor((beegnumber * 1257) / 600) * 360

yield("Total a4n_hand -> "..formatNumberWithCommas(a4n_hand))
yield("Total a4n_body -> "..formatNumberWithCommas(a4n_body))
yield("Total a4n_leg -> "..formatNumberWithCommas(a4n_leg))
yield("Total a4n_feet -> "..formatNumberWithCommas(a4n_feet))
yield("Total a4n_jewellery -> "..formatNumberWithCommas(a4n_j))
yield("Item level -> "..iLevel)
yield("Total Turnins ->"..formatNumberWithCommas(beegnumber))
yield("Total FC Points ->"..formatNumberWithCommas(beegernumber))
yield("Total Gil oilcloth  0% buff Value ->"..formatNumberWithCommas(gcbeegnumber).." from "..formatNumberWithCommas(gcbeegnumber * (5/3)).." GC Seals")
yield("Total Gil oilcloth 10% buff Value ->"..formatNumberWithCommas(gcbeegnumber10).." from "..formatNumberWithCommas(gcbeegnumber10 * (5/3)).." GC Seals")
yield("Total Gil oilcloth 15% buff Value ->"..formatNumberWithCommas(gcbeegnumber15).." from "..formatNumberWithCommas(gcbeegnumber15 * (5/3)).." GC Seals")

a4n_hand_gil = 587
a4n_body_gil = 978
a4n_leg_gil = 587
a4n_feet_gil = 587
a4n_j_gil = 445

total_vendor_gil = (a4n_hand * a4n_hand_gil) + (a4n_body * a4n_body_gil) + (a4n_leg * a4n_leg_gil) + (a4n_feet * a4n_feet_gil) + (a4n_j * a4n_j_gil)

yield("Total Vendorsell (no GC/FC Ranking) Gil ->"..formatNumberWithCommas(total_vendor_gil))