
[1mFrom:[0m /home/brendan_oneill/oo-student-scraper-online-web-sp-000/lib/scraper.rb @ line 32 Scraper.scrape_profile_page:

    [1;34m24[0m: [32mdef[0m [1;36mself[0m.[1;34mscrape_profile_page[0m(profile_url)
    [1;34m25[0m:     doc = [1;34;4mNokogiri[0m::HTML(open(profile_url))
    [1;34m26[0m:     social = doc.css([31m[1;31m"[0m[31ma[1;31m"[0m[31m[0m)
    [1;34m27[0m:     number = social.count
    [1;34m28[0m:     count = [1;34m1[0m
    [1;34m29[0m:     hash = {}
    [1;34m30[0m: 
    [1;34m31[0m:   [32mwhile[0m count <= number [32mdo[0m
 => [1;34m32[0m:     binding.pry
    [1;34m33[0m:     github = social[count][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m] [32munless[0m social[count][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].include?([31m[1;31m"[0m[31mgithub[1;31m"[0m[31m[0m) == [1;36mfalse[0m
    [1;34m34[0m:     linkedin = social[count][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m] [32munless[0m social[count][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].include?([31m[1;31m"[0m[31mlinkedin[1;31m"[0m[31m[0m) == [1;36mfalse[0m 
    [1;34m35[0m:     twitter = social[count][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m] [32munless[0m social[count][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].include?([31m[1;31m"[0m[31mtwitter[1;31m"[0m[31m[0m) == [1;36mfalse[0m 
    [1;34m36[0m:     blog = social[count][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m] [32munless[0m social[count][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].include?([31m[1;31m"[0m[31mtwitter[1;31m"[0m[31m[0m) == [1;36mfalse[0m && social[count][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].include?([31m[1;31m"[0m[31mgithub[1;31m"[0m[31m[0m) == [1;36mfalse[0m && social[count][[31m[1;31m"[0m[31mhref[1;31m"[0m[31m[0m].include?([31m[1;31m"[0m[31mlinkedin[1;31m"[0m[31m[0m) == [1;36mfalse[0m
    [1;34m37[0m:     count += [1;34m1[0m
    [1;34m38[0m:   [32mend[0m
    [1;34m39[0m:   
    [1;34m40[0m:   
    [1;34m41[0m:   
    [1;34m42[0m:   
    [1;34m43[0m:   
    [1;34m44[0m:   
    [1;34m45[0m:   
    [1;34m46[0m: [32mend[0m

