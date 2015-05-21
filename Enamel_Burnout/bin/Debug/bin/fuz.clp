(clear)
(open "wyniki.txt" file "w")

;;import wymaganych bibliotek i plikow
(import nrc.fuzzy.*)
(import nrc.fuzzy.jess.*)
(load-package FuzzyFunctions)

(batch fakty.clp)

;;deklaracja zmiennych rozmytych
(defglobal ?*TempFvar* = (new FuzzyVariable "Temp" 780.0 860.0 "Deg C"))
(defglobal ?*CzasFvar* = (new FuzzyVariable "Czas" 20.0 40.0 "Deg C"))
(defglobal ?*TasmociagFvar* = (new FuzzyVariable "Tasmociag" 1.0 10.0 "ustawienie"))

(defglobal ?*tempus* = 0)

(defrule init 

 (declare (salience 100))
=>
 (import nrc.fuzzy.*)
 (load-package nrc.fuzzy.jess.FuzzyFunctions)

(bind ?rlf (new RightLinearFunction)) (bind ?llf (new LeftLinearFunction))
    
(?*TempFvar* addTerm "zdobienie" (new TrapezoidFuzzySet 780.0 780.0 800.0 820.0))
(?*TempFvar* addTerm "kryjaca" (new TrapezoidFuzzySet 800.0 810.0 830.0 840.0))
(?*TempFvar* addTerm "gruntowa" (new TrapezoidFuzzySet 820.0 840.0 850.0 860.0))


(?*CzasFvar* addTerm "krotki" (new TrapezoidFuzzySet 20.0 20.0 25.0 30.0))
(?*CzasFvar* addTerm "sredni" (new TrapezoidFuzzySet 25.0 27.0 29.0 35.0))
(?*CzasFvar* addTerm "dlugi" (new TrapezoidFuzzySet 29.0 31.0 36.0 40.0))
    
	
(?*TasmociagFvar* addTerm "wolno" (new TriangleFuzzySet 1.0 2.0 3.0))
(?*TasmociagFvar* addTerm "srednio" (new TriangleFuzzySet 3.0 4.0 5.0))
(?*TasmociagFvar* addTerm "szybko" (new TriangleFuzzySet 5.0 6.0 7.0))
(?*TasmociagFvar* addTerm "bszybko" (new TriangleFuzzySet 6.0 8.0 10.0))





 


(assert (crispTemp ?*zmTemperatura*))
(assert (Temp (new FuzzyValue ?*TempFvar* (new TrapezoidFuzzySet ?*zmTemperatura* ?*zmTemperatura* ?*zmTemperatura* ?*zmTemperatura*))))


(assert (crispCzas ?*zmCzas*))
(assert (Czas (new FuzzyValue ?*CzasFvar* (new TrapezoidFuzzySet ?*zmCzas* ?*zmCzas* ?*zmCzas* ?*zmCzas*))))


)

(defrule regula1
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))
    

(defrule regula2
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula3
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula4
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))
    
(defrule regula5
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula6
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula7
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "wolno"))))

(defrule regula8
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "wolno"))))

(defrule regula9
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))



(defrule control
(declare (salience -100))

?tem <- (crispTemp ?tm)
?czs <- (crispCzas ?cz)


?tasmociag <- (Tasmociag ?fuzzyTasmociag)


=>
   
    (bind ?crispTasmociag (?fuzzyTasmociag momentDefuzzify))
    
    

    

    
        
  
    
    (bind ?zmienna1 (* ?crispTasmociag 1))
    
    
       
 
   (bind ?aaa (round  (* ?zmienna1 10)))
    
   (bind ?aaaa (/ ?aaa 10))
   
    

    

    (printout t "" ?aaaa crlf) 
    
    (printout file "" ?aaaa crlf)  
    
    )


	
	

(reset)
(run)

(close file)

