parameters
    p_broadcastValue(KTBL_mechanisation)
    p_broadcastRemValue(KTBL_mechanisation)
    p_broadcastAnnualCapac(KTBL_mechanisation)
    p_broadcastAreaCapac(KTBL_mechanisation)
    p_lifetimeBroadcast
;


p_broadcastValue("45") 
*also for grassland operations
    = 15000
;
p_broadcastValue("67") 
    = 22700
;
p_broadcastValue("83") 
    = 30300
;
p_broadcastValue("102") 
    = 36600
;
p_broadcastValue("120") 
    = 51100
;
p_broadcastValue("200") 
    = 58100
;
p_broadcastValue("230") 
    = 71100
;


p_broadcastRemValue("45")
    = 3000
;
p_broadcastRemValue("67")
    = 4540
;
p_broadcastRemValue("83")
    = 6060
;
p_broadcastRemValue("102")
    = 7320
;
p_broadcastRemValue("120")
    = 10220
;
p_broadcastRemValue("200")
    = 11620
;
p_broadcastRemValue("230")
    = 14220
;


p_broadcastAnnualCapac("45")
    = 480
;
p_broadcastAnnualCapac("67")
    = 600
;
p_broadcastAnnualCapac("83")
    = 720
;
p_broadcastAnnualCapac("102")
    = 960
;
p_broadcastAnnualCapac("120")
    = 960
;
p_broadcastAnnualCapac("200")
    = 960
;
p_broadcastAnnualCapac("230")
    = 1440
;

p_lifetimeBroadcast = 10;

p_broadcastAreaCapac(KTBL_mechanisation) = p_broadcastAnnualCapac(KTBL_mechanisation) * p_lifetimeBroadcast;






$ontext
p_broadcastValue(KTBL_crops,"45") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 15000
;
p_broadcastValue(KTBL_crops,"67") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 30300
;
p_broadcastValue(KTBL_crops,"83") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 30300
;
p_broadcastValue(KTBL_crops,"102") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 36600
;
p_broadcastValue(KTBL_crops,"120") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 54300
;
p_broadcastValue(KTBL_crops,"200") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 54300
;
p_broadcastValue(KTBL_crops,"230") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 71100
;
p_broadcastRemValue(KTBL_crops,"45") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 3000
;
p_broadcastRemValue(KTBL_crops,"67") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 6060
;
p_broadcastRemValue(KTBL_crops,"83") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 6060
;
p_broadcastRemValue(KTBL_crops,"102") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 7320
;
p_broadcastRemValue(KTBL_crops,"120") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 10860
;
p_broadcastRemValue(KTBL_crops,"200") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 10860
;
p_broadcastRemValue(KTBL_crops,"230") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 14220
;
p_broadcastAnnualCapac(KTBL_crops,"45") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 480
;
p_broadcastAnnualCapac(KTBL_crops,"67") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 720
;
p_broadcastAnnualCapac(KTBL_crops,"83") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 720
;
p_broadcastAnnualCapac(KTBL_crops,"102") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 960
;
p_broadcastAnnualCapac(KTBL_crops,"120") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 1080
;
p_broadcastAnnualCapac(KTBL_crops,"200") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 1080
;
p_broadcastAnnualCapac(KTBL_crops,"230") 
    $ ((sameas(KTBL_crops,'Speisekartoffeln')) AND (sameas(KTBL_crops,'Staerkekartoffeln')))
    = 1440
;
$offtext