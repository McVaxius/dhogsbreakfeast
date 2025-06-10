--o3n turnincalculator
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

o3n_head  = math.floor(GetItemCount(19111) / 2) --lense
o3n_hand  = math.floor(GetItemCount(19113) / 2) --crank
o3n_body  = math.floor(GetItemCount(19112) / 4) --shaft
o3n_leg   = math.floor(GetItemCount(19114) / 4) --spring
o3n_feet  = math.floor(GetItemCount(19115) / 2) --pedal
o3n_j     = math.floor(GetItemCount(19117))     --bold
iLevel    = 320
beegnumber = o3n_head + o3n_hand + o3n_body + o3n_leg + o3n_feet + o3n_j
beegernumber = beegnumber * iLevel * 1.5
gcbeegnumber = math.floor((beegnumber * 1390) / 600) * 360
gcbeegnumber10 = math.floor((beegnumber * 1529) / 600) * 360
gcbeegnumber15 = math.floor((beegnumber * 1598) / 600) * 360

yield("Total o3n_head -> "..formatNumberWithCommas(o3n_head))
yield("Total o3n_hand -> "..formatNumberWithCommas(o3n_hand))
yield("Total o3n_body -> "..formatNumberWithCommas(o3n_body))
yield("Total o3n_leg -> "..formatNumberWithCommas(o3n_leg))
yield("Total o3n_feet -> "..formatNumberWithCommas(o3n_feet))
yield("Total o3n_jewellery -> "..formatNumberWithCommas(o3n_j))
yield("Item level -> "..iLevel)
yield("Total Turnins ->"..formatNumberWithCommas(beegnumber))
yield("Total FC Points ->"..formatNumberWithCommas(beegernumber))
yield("Total Gil oilcloth  0% buff Value ->"..formatNumberWithCommas(gcbeegnumber).." from "..formatNumberWithCommas(gcbeegnumber * (5/3)).." GC Seals")
yield("Total Gil oilcloth 10% buff Value ->"..formatNumberWithCommas(gcbeegnumber10).." from "..formatNumberWithCommas(gcbeegnumber10 * (5/3)).." GC Seals")
yield("Total Gil oilcloth 15% buff Value ->"..formatNumberWithCommas(gcbeegnumber15).." from "..formatNumberWithCommas(gcbeegnumber15 * (5/3)).." GC Seals")

o3n_head_gil = 896
o3n_hand_gil = 896
o3n_body_gil = 1493
o3n_leg_gil = 1493
o3n_feet_gil = 896
o3n_j_gil = 679

total_orch_scroll = GetItemCount(24297) * 150
yield("/echo Total orch scrolls -> "..GetItemCount(24297).. ", Total gil -> "..total_orch_scroll)

total_vendor_gil = (o3n_head * o3n_head_gil) + (o3n_hand * o3n_hand_gil) + (o3n_body * o3n_body_gil) + (o3n_leg * o3n_leg_gil) + (o3n_feet * o3n_feet_gil) + (o3n_j * o3n_j_gil)

yield("Total Vendorsell (no GC/FC Ranking) Gil ->"..formatNumberWithCommas(total_vendor_gil))