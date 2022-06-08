# CONSTANTS
# pressure in pa
press_s <- 1e5
# volume in m3 0.001 = 1L
vol <- 0.001
# ideal gas const J⋅K−1⋅mol−1.
R <- 8.31446261815324
# percentage of oxygen in air
oxygenPercent <- 0.21
# using STP temp K
temp <- 300

# molecular weights - oxygen
mkg_O <- 0.016
mkg_C <- 0.012
mkg_H <- 0.001
mkg_Air <- 0.02897

# moles
mAir_s <- (press_s * vol) / (R * temp)
mO2_s <- mAir_s * oxygenPercent
mNotO2 <- mAir_s * (1 - oxygenPercent) 

# C25H52 + 38O2 -> 25Co2 + 26H2O
mWax <- mO2_s/38
mCO2 <- mWax * 25

# now we have all the basic data calculate the change in pressure from the change in moles
press_e_moles <- (press_s / mAir_s) * (mNotO2 + mCO2)

# now calculate the change in pressure from the change in temp
# heat capacity of air J/kg/deg K
hcAir <- 700

# some measured properties of candle flames taken from here - https://tsapps.nist.gov/publication/get_pdf.cfm?pub_id=101159
# burn rate - I've used the average this will probably not be super accurate kg/sec
brWax <- 0.1/1000/60 #0.1gram/min
# energy output in J/s
energyOutput <- 75

# burnt wax mass in kg
waxBurnt <- mWax * (25 * mkg_C + mkg_H)

burnSeconds <- waxBurnt/brWax
energyReleased <- burnSeconds * energyOutput
temp_change <- energyReleased * ((mNotO2 + mCO2) * mkg_Air) / hcAir

press_e_temp <- (press_e_moles / temp) * (temp + temp_change)
