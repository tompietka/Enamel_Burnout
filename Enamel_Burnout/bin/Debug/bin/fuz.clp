(clear)
(open "wyniki.txt" file "w")

;;import wymaganych bibliotek i plikow
(import nrc.fuzzy.*)
(import nrc.fuzzy.jess.*)
(load-package FuzzyFunctions)

(batch fakty.clp)

;;deklaracja zmiennych rozmytych
(defglobal ?*TempFvar* = (new FuzzyVariable "Temp" 780.0 860.0 "Stop C"))
(defglobal ?*CzasFvar* = (new FuzzyVariable "Czas" 20.0 40.0 "minutes"))

(defglobal ?*TacaFvar* = (new FuzzyVariable "Taca" 1.0 3.0 "liczba"))
(defglobal ?*WspFvar* = (new FuzzyVariable "Wsp" 10.0 20.0 "alfa"))


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
(?*TempFvar* addTerm "gruntowa" (new TrapezoidFuzzySet 820.0 840.0 860.0 860.0))


(?*CzasFvar* addTerm "krotki" (new TrapezoidFuzzySet 20.0 20.0 25.0 30.0))
(?*CzasFvar* addTerm "sredni" (new TrapezoidFuzzySet 25.0 27.0 29.0 35.0))
(?*CzasFvar* addTerm "dlugi" (new TrapezoidFuzzySet 29.0 31.0 40.0 40.0))


(?*TacaFvar* addTerm "pierwsza" (new TrapezoidFuzzySet 1.0 1.0 2.0 2.0))
(?*TacaFvar* addTerm "druga" (new TrapezoidFuzzySet 1.5 1.5 2.5 2.5))
(?*TacaFvar* addTerm "trzecia" (new TrapezoidFuzzySet 2.0 2.0 3.0 3.0))


(?*WspFvar* addTerm "niski" (new TrapezoidFuzzySet 10.0 14.0 15.0 16.0))
(?*WspFvar* addTerm "sredni" (new TrapezoidFuzzySet 15.0 15.0 16.0 17.0))
(?*WspFvar* addTerm "wysoki" (new TrapezoidFuzzySet 16.0 17.0 18.0 20.0))
    
	
(?*TasmociagFvar* addTerm "wolno" (new TriangleFuzzySet 1.0 2.0 4.0))
(?*TasmociagFvar* addTerm "srednio" (new TriangleFuzzySet 3.0 4.0 6.0))
(?*TasmociagFvar* addTerm "szybko" (new TriangleFuzzySet 5.0 6.0 7.0))
(?*TasmociagFvar* addTerm "bszybko" (new TriangleFuzzySet 6.0 8.0 10.0))


(assert (crispTemp ?*zmTemperatura*))
(assert (Temp (new FuzzyValue ?*TempFvar* (new TrapezoidFuzzySet ?*zmTemperatura* ?*zmTemperatura* ?*zmTemperatura* ?*zmTemperatura*))))


(assert (crispCzas ?*zmCzas*))
(assert (Czas (new FuzzyValue ?*CzasFvar* (new TrapezoidFuzzySet ?*zmCzas* ?*zmCzas* ?*zmCzas* ?*zmCzas*))))

(assert (crispTaca ?*zmTaca*))
(assert (Taca (new FuzzyValue ?*TacaFvar* (new TrapezoidFuzzySet ?*zmTaca* ?*zmTaca* ?*zmTaca* ?*zmTaca*))))

(assert (crispWsp ?*zmWsp*))
(assert (Wsp (new FuzzyValue ?*WspFvar* (new TrapezoidFuzzySet ?*zmWsp* ?*zmWsp* ?*zmWsp* ?*zmWsp*))))

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

(defrule regula10
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Taca ?tc&:(fuzzy-match ?tc "pierwsza"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "wolno"))))

(defrule regula11
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Taca ?tc&:(fuzzy-match ?tc "druga"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))

(defrule regula12
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Taca ?tc&:(fuzzy-match ?tc "trzecia"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))


(defrule regula13
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Taca ?tc&:(fuzzy-match ?tc "pierwsza"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))

(defrule regula14
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Taca ?tc&:(fuzzy-match ?tc "druga"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula15
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Taca ?tc&:(fuzzy-match ?tc "trzecia"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula16
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Taca ?tc&:(fuzzy-match ?tc "pierwsza"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula17
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Taca ?tc&:(fuzzy-match ?tc "druga"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula18
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Taca ?tc&:(fuzzy-match ?tc "trzecia"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula19
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Taca ?tc&:(fuzzy-match ?tc "pierwsza"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))

(defrule regula20
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Taca ?tc&:(fuzzy-match ?tc "druga"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula21
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Taca ?tc&:(fuzzy-match ?tc "trzecia"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))


(defrule regula22
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Taca ?tc&:(fuzzy-match ?tc "pierwsza"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula23
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Taca ?tc&:(fuzzy-match ?tc "druga"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula24
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Taca ?tc&:(fuzzy-match ?tc "trzecia"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula25
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Taca ?tc&:(fuzzy-match ?tc "pierwsza"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula26
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Taca ?tc&:(fuzzy-match ?tc "druga"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula27
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Taca ?tc&:(fuzzy-match ?tc "trzecia"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula28
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Taca ?tc&:(fuzzy-match ?tc "pierwsza"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "wolno"))))

(defrule regula29
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Taca ?tc&:(fuzzy-match ?tc "druga"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))

(defrule regula30
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Taca ?tc&:(fuzzy-match ?tc "trzecia"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))


(defrule regula31
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Taca ?tc&:(fuzzy-match ?tc "pierwsza"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))

(defrule regula32
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Taca ?tc&:(fuzzy-match ?tc "druga"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula33
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Taca ?tc&:(fuzzy-match ?tc "trzecia"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula34
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Taca ?tc&:(fuzzy-match ?tc "pierwsza"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula35
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Taca ?tc&:(fuzzy-match ?tc "druga"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula36
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Taca ?tc&:(fuzzy-match ?tc "trzecia"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))


(defrule regula37
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Wsp ?wp&:(fuzzy-match ?wp "niski"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "wolno"))))

(defrule regula38
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Wsp ?wp&:(fuzzy-match ?wp "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))

(defrule regula39
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Wsp ?wp&:(fuzzy-match ?wp "wysoki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))


(defrule regula40
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Wsp ?wp&:(fuzzy-match ?wp "niski"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))

(defrule regula41
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Wsp ?wp&:(fuzzy-match ?wp "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula42
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Wsp ?wp&:(fuzzy-match ?wp "wysoki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula43
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Wsp ?wp&:(fuzzy-match ?wp "niski"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula44
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Wsp ?wp&:(fuzzy-match ?wp "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula45
(Temp ?tm&:(fuzzy-match ?tm "zdobienie"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Wsp ?wp&:(fuzzy-match ?wp "wysoki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula46
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Wsp ?wp&:(fuzzy-match ?wp "niski"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))

(defrule regula47
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Wsp ?wp&:(fuzzy-match ?wp "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula48
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Wsp ?wp&:(fuzzy-match ?wp "wysoki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))


(defrule regula49
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Wsp ?wp&:(fuzzy-match ?wp "niski"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula50
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Wsp ?wp&:(fuzzy-match ?wp "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula51
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Wsp ?wp&:(fuzzy-match ?wp "wysoki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula52
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Wsp ?wp&:(fuzzy-match ?wp "niski"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula53
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Wsp ?wp&:(fuzzy-match ?wp "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula54
(Temp ?tm&:(fuzzy-match ?tm "kryjaca"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Wsp ?wp&:(fuzzy-match ?wp "wysoki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule regula55
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Wsp ?wp&:(fuzzy-match ?wp "niski"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "wolno"))))

(defrule regula56
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Wsp ?wp&:(fuzzy-match ?wp "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))

(defrule regula57
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "krotki"))
(Wsp ?wp&:(fuzzy-match ?wp "wysoki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))


(defrule regula58
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Wsp ?wp&:(fuzzy-match ?wp "niski"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "srednio"))))

(defrule regula59
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Wsp ?wp&:(fuzzy-match ?wp "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula60
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "sredni"))
(Wsp ?wp&:(fuzzy-match ?wp "wysoki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula61
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Wsp ?wp&:(fuzzy-match ?wp "niski"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula62
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Wsp ?wp&:(fuzzy-match ?wp "sredni"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "szybko"))))

(defrule regula63
(Temp ?tm&:(fuzzy-match ?tm "gruntowa"))
(Czas ?cz&:(fuzzy-match ?cz "dlugi"))
(Wsp ?wp&:(fuzzy-match ?wp "wysoki"))
=>
(bind ?*tempus* 1)
(assert (Tasmociag (new FuzzyValue ?*TasmociagFvar* "bszybko"))))

(defrule control
(declare (salience -100))

?tem <- (crispTemp ?tm)
?czs <- (crispCzas ?cz)
?tac <- (crispTaca ?tc)
?wsp <- (crispWsp ?wp)


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

