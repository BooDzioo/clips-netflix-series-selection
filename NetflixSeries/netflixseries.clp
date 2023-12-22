
;;;======================================================
;;;   Automotive Expert System
;;;
;;;     This expert system diagnoses some simple
;;;     problems with a car.
;;;
;;;     CLIPS Version 6.3 Example
;;;
;;;     For use with the Auto Demo Example
;;;======================================================

;;; ***************************
;;; * DEFTEMPLATES & DEFFACTS *
;;; ***************************

(deftemplate UI-state
   (slot id (default-dynamic (gensym*)))
   (slot display)
   (slot relation-asserted (default none))
   (slot response (default none))
   (multislot valid-answers)
   (slot state (default middle)))
   
(deftemplate state-list
   (slot current)
   (multislot sequence))
  
(deffacts startup
   (state-list))
   
;;;****************
;;;* STARTUP RULE *
;;;****************

(defrule system-banner ""

  =>
  
  (assert (UI-state (display WelcomeMessage)
                    (relation-asserted start)
                    (state initial)
                    (valid-answers))))

;;;***************
;;;* QUERY RULES *
;;;***************

(defrule determine-duration ""

   (logical (start))

   =>

   (assert (UI-state (display TimeQuestion)
                     (relation-asserted series-duration)
                     (response Thirty)
                     (valid-answers Thirty Sixty))))
   
(defrule determine-black-and-white ""

   (logical (series-duration Thirty))

   =>

   (assert (UI-state (display BlackWhiteQuestion)
                     (relation-asserted black-white)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-animated ""

   (logical (black-white No))

   =>

   (assert (UI-state (display AnimatedQuestion)
                     (relation-asserted animated)
                     (response No)
                     (valid-answers No Yes))))
                     
 (defrule determine-laughter ""

   (logical (animated No))

   =>

   (assert (UI-state (display LaughterQuestion)
                     (relation-asserted laughter)
                     (response No)
                     (valid-answers No Yes))))
                     
(defrule determine-paranormal ""

   (logical (laughter No))

   =>

   (assert (UI-state (display ParanormalQuestion)
                     (relation-asserted paranormal)
                     (response No)
                     (valid-answers No Yes))))     
                                     
(defrule determine-mystery-or-space ""

   (logical (paranormal No))

   =>

   (assert (UI-state (display MysteryQuestion)
                     (relation-asserted mystery-or-space)
                     (response Space)
                     (valid-answers Space Mystery))))                     
 
 (defrule determine-nostalgic ""

   (logical (mystery-or-space Space))

   =>

   (assert (UI-state (display NostalgicQuestion)
                     (relation-asserted nostalgic)
                     (response No)
                     (valid-answers No Yes))))
                     
(defrule determine-solution-process ""

   (logical (mystery-or-space Mystery))

   =>

   (assert (UI-state (display SolutionProcessQuestion)
                     (relation-asserted solution-process)
                     (response Solution)
                     (valid-answers Solution Process))))
                     
(defrule determine-little-thinking ""

   (logical (laughter Yes))

   =>

   (assert (UI-state (display LittleThinkingQuestion)
                     (relation-asserted little-thinking)
                     (response No)
                     (valid-answers No Yes))))                               

(defrule determine-british-humour ""

   (logical (little-thinking No))

   =>

   (assert (UI-state (display BritishHumourQuestion)
                     (relation-asserted british-humour)
                     (response No)
                     (valid-answers No Yes))))  
                     
(defrule determine-sophisticate ""

   (logical (british-humour No))

   =>

   (assert (UI-state (display SophisticateQuestion)
                     (relation-asserted sophisticate)
                     (response No)
                     (valid-answers No Yes))))       
                     
 (defrule determine-rewatchability ""

   (logical (sophisticate No))

   =>

   (assert (UI-state (display RewatchabilityQuestion)
                     (relation-asserted rewatchability)
                     (response No)
                     (valid-answers No Yes))))    
                     
 (defrule determine-akward ""

   (logical (rewatchability No))

   =>

   (assert (UI-state (display AkwardQuestion)
                     (relation-asserted akward)
                     (response No)
                     (valid-answers No Yes))))  
                     
  (defrule determine-skit ""

   (logical (little-thinking Yes))

   =>

   (assert (UI-state (display SkitQuestion)
                     (relation-asserted skit)
                     (response No)
                     (valid-answers No Yes))))
  
  (defrule determine-weed ""

   (logical (skit No))

   =>

   (assert (UI-state (display WeedQuestion)
                     (relation-asserted weed)
                     (response No)
                     (valid-answers No Yes))))
  
  (defrule determine-football ""

   (logical (weed No))

   =>

   (assert (UI-state (display FootballQuestion)
                     (relation-asserted football)
                     (response No)
                     (valid-answers No Yes))))  
                     
   (defrule determine-satire-insanity ""

   (logical (football No))

   =>

   (assert (UI-state (display SatireQuestion)
                     (relation-asserted satire-insanity)
                     (response Satire)
                     (valid-answers Satire Insanity))))
                     
   (defrule determine-shit ""

   (logical (weed Yes))

   =>

   (assert (UI-state (display ShitQuestion)
                     (relation-asserted shit)
                     (response No)
                     (valid-answers No Yes))))
                     
 (defrule determine-odd ""

   (logical (skit Yes))

   =>

   (assert (UI-state (display QuirkyQuestion)
                     (relation-asserted odd)
                     (response No)
                     (valid-answers No Yes))))
                     
  (defrule determine-dick ""

   (logical (animated Yes))

   =>

   (assert (UI-state (display DickQuestion)
                     (relation-asserted dick)
                     (response No)
                     (valid-answers No Yes))))
                     
   (defrule determine-gratuitous ""

   (logical (dick No))

   =>

   (assert (UI-state (display GratuitousQuestion)
                     (relation-asserted gratuitous)
                     (response No)
                     (valid-answers No Yes)))) 
                     
   (defrule determine-childish-mature ""

   (logical (gratuitous No))

   =>

   (assert (UI-state (display ChildishQuestion)
                     (relation-asserted childish-mature)
                     (response Childish)
                     (valid-answers Childish Mature))))
                     
   (defrule determine-commentary ""

   (logical (childish-mature Childish))

   =>

   (assert (UI-state (display CommentaryQuestion)
                     (relation-asserted commentary)
                     (response No)
                     (valid-answers No Yes))))
                     
   (defrule determine-fucked ""

   (logical (childish-mature Mature))

   =>

   (assert (UI-state (display FuckedQuestion)
                     (relation-asserted fucked)
                     (response No)
                     (valid-answers No Yes))))                                                        

;;;* 60 mins *

(defrule determine-age-story-line ""

   (logical (series-duration Sixty))

   =>

   (assert (UI-state (display AgeStoryQuestion)
                     (relation-asserted age-story-line)
                     (response No)
                     (valid-answers No Yes))))
                                                     
(defrule determine-crime-drama ""

   (logical (age-story-line No))

   =>

   (assert (UI-state (display CrimeDramaQuestion)
                     (relation-asserted crime-drama)
                     (response No)
                     (valid-answers No Yes))))
                      
                     
(defrule determine-cliffhanger ""

   (logical (crime-drama Yes))

   =>

   (assert (UI-state (display CliffhangerQuestion)
                     (relation-asserted mystery-or-cliffhanger)
                     (response Mystery)
                     (valid-answers Mystery Thriller))))
                                  
(defrule determine-intense ""

   (logical (mystery-or-cliffhanger Thriller))

   =>

   (assert (UI-state (display IntenseQuestion)
                     (relation-asserted intense)
                     (response No)
                     (valid-answers No Yes))))
                     
(defrule determine-good-or-bad-guys ""

   (logical (intense No))

   =>

   (assert (UI-state (display GoodBadQuestion)
                     (relation-asserted good-or-bad-guys)
                     (response Good)
                     (valid-answers Good Bad))))
                                                                
(defrule determine-sciFi ""

   (logical (crime-drama No))

   =>

   (assert (UI-state (display SciFiQuestion)
                     (relation-asserted sci-fi)
                     (response No)
                     (valid-answers No Yes))))           
                     
(defrule determine-outer-space ""

   (logical (sci-fi Yes))

   =>

   (assert (UI-state (display OuterSpaceQuestion)
                     (relation-asserted outer-space)
                     (response No)
                     (valid-answers No Yes))))
                     
                     
(defrule determine-explore-or-war ""

   (logical (outer-space Yes))

   =>

   (assert (UI-state (display ExploreOrWarQuestion)
                     (relation-asserted explore-or-war)
                     (response Explore)
                     (valid-answers Explore War))))           
                     
(defrule determine-less-science ""

   (logical (outer-space No))

   =>

   (assert (UI-state (display LessScienceQuestion)
                     (relation-asserted less-science)
                     (response No)
                     (valid-answers No Yes))))    
                     
(defrule determine-brains ""

   (logical (less-science Yes))

   =>

   (assert (UI-state (display BrainsQuestion)
                     (relation-asserted brains)
                     (response No)
                     (valid-answers No Yes))))  


(defrule determine-politics ""

   (logical (sci-fi No))

   =>

   (assert (UI-state (display PoliticsQuestion)
                     (relation-asserted politics)
                     (response No)
                     (valid-answers No Yes))))

(defrule determine-kevin ""

   (logical (politics Yes))

   =>

   (assert (UI-state (display KevinQuestion)
                     (relation-asserted kevin)
                     (response No)
                     (valid-answers No Yes))))
                    
(defrule determine-stepped ""

   (logical (politics No))

   =>

   (assert (UI-state (display SteepedQuestion)
                     (relation-asserted stepped)
                     (response No)
                     (valid-answers No Yes))))       
                     
(defrule determine-strange ""

   (logical (stepped No))

   =>

   (assert (UI-state (display StrangeThingsQuestion)
                     (relation-asserted strange)
                     (response No)
                     (valid-answers No Yes))))
                     
                                
;;;****************
;;;* CONCLUSION RULES *
;;;****************

(defrule nostalgic-conclusion-no ""

   (logical (nostalgic No))
   
   =>

   (assert (UI-state (display FireflyShow)
                     (state final))))
                     
 (defrule nostalgic-conclusion-yes ""

   (logical (nostalgic Yes))
   
   =>

   (assert (UI-state (display StarTrek2Show)
                     (state final))))
      
(defrule solution-conclusion ""

   (logical (solution-process Solution))
   
   =>

   (assert (UI-state (display RockfordShow)
                     (state final))))       
                     
(defrule process-conclusion ""

   (logical (solution-process Process))
   
   =>

   (assert (UI-state (display ColumboShow)
                     (state final))))                     

 (defrule paranormal-conclusion-yes ""

   (logical (paranormal Yes))
   
   =>

   (assert (UI-state (display XFilesShow)
                     (state final))))
                     
 (defrule akward-conclusion-no ""

   (logical (akward No))
   
   =>

   (assert (UI-state (display CheersShow)
                     (state final))))                     
                     
 (defrule akward-conclusion-yes ""

   (logical (akward Yes))
   
   =>

   (assert (UI-state (display LouiseShow)
                     (state final)))) 
                     
 (defrule rewatchability-conclusion-yes ""

   (logical (rewatchability Yes))
   
   =>

   (assert (UI-state (display ArrestedShow)
                     (state final))))      
                                    
  (defrule sophisticate-conclusion-yes ""

   (logical (sophisticate Yes))
   
   =>

   (assert (UI-state (display FrasierShow)
                     (state final))))
                     
                     
  (defrule british-homour-conclusion-yes ""

   (logical (british-homour Yes))
   
   =>

   (assert (UI-state (display FawltyShow)
                     (state final))))    
                     
   (defrule satire-conclusion ""

   (logical (satire-insanity Satire))
   
   =>

   (assert (UI-state (display RecreationShow)
                     (state final)))) 
                     
   (defrule insanity-conclusion ""

   (logical (satire-insanity Insanity))
   
   =>

   (assert (UI-state (display PhiladelphiaShow)
                     (state final))))         
                     
   (defrule football-conclusion-yes ""

   (logical (football Yes))
   
   =>

   (assert (UI-state (display LeagueShow)
                     (state final))))
                     
  (defrule shit-conclusion-no ""

   (logical (shit No))
   
   =>

   (assert (UI-state (display WorkaholicsShow)
                     (state final))))
                     
   (defrule shit-conclusion-yes ""

   (logical (shit Yes))
   
   =>

   (assert (UI-state (display TrailerShow)
                     (state final))))   
                     
 (defrule odd-conclusion-no ""

   (logical (odd No))
   
   =>

   (assert (UI-state (display ChappelleShow)
                     (state final))))
                     
   (defrule odd-conclusion-yes ""

   (logical (odd Yes))
   
   =>

   (assert (UI-state (display KidsShow)
                     (state final))))
                     
   (defrule commentary-conclusion-no ""

   (logical (commentary No))
   
   =>

   (assert (UI-state (display FuturamaShow)
                     (state final))))
                     
   (defrule commentary-conclusion-yes ""

   (logical (commentary Yes))
   
   =>

   (assert (UI-state (display SouthParkShow)
                     (state final))))
                     
    (defrule fucked-conclusion-no ""

   (logical (fucked No))
   
   =>

   (assert (UI-state (display ArcherShow)
                     (state final))))
                     
  (defrule fucked-conclusion-yes ""

   (logical (fucked Yes))
   
   =>

   (assert (UI-state (display RenShow)
                     (state final))))
                     
   (defrule gratuitous-conclusion-yes ""

   (logical (gratuitous Yes))
   
   =>

   (assert (UI-state (display DeadHighschoolShow)
                     (state final))))
                     
   (defrule dick-conclusion-yes ""

   (logical (dick Yes))
   
   =>

   (assert (UI-state (display FamilyGuyShow)
                     (state final))))
                     
(defrule black-white-conclusion-yes ""

   (logical (black-white Yes))
   
   =>

   (assert (UI-state (display TwilightShow)
                     (state final))))      
                     
(defrule age-story-line-conclusion-yes ""

   (logical (age-story-line Yes))
   
   =>

   (assert (UI-state (display FreaksShow)
                     (state final))))      
                     
                     
(defrule classic-mystery-conclusion ""

   (logical (mystery-or-cliffhanger Mystery))

   =>

   (assert (UI-state (display SherlockShow)
                     (state final))))  
                     
(defrule intense-show-conclusion ""

   (logical (intense Yes))

   =>

   (assert (UI-state (display BreakingBadShow)
                     (state final))))  


(defrule law-and-orders-conclusion ""

   (logical (good-or-bad-guys Good))

   =>

   (assert (UI-state (display LawAndOrdersShow)
                     (state final))))
                     
(defrule sons-of-anarchy-conclusion ""

   (logical (good-or-bad-guys Bad))

   =>

   (assert (UI-state (display SonsOfAnarchyShow)
                     (state final))))  
                     
(defrule star-trek-conclusion ""

   (logical (explore-or-war Explore))

   =>

   (assert (UI-state (display StartTrekShow)
                     (state final))))  
                     
(defrule battlestar-conclusion ""

   (logical (explore-or-war War))

   =>

   (assert (UI-state (display BattlestarShow)
                     (state final))))   
                     
(defrule sliders-conclusion-no ""

   (logical (less-science No))

   =>

   (assert (UI-state (display SliderShow)
                     (state final))))   
                  
(defrule brains-conclusion-yes ""

   (logical (brains Yes))

   =>

   (assert (UI-state (display TWDShow)
                     (state final)))) 


(defrule brains-conclusion-no ""

   (logical (brains No))

   =>

   (assert (UI-state (display LostShow)
                     (state final))))     
                     
                     
(defrule kevin-conclusion-no ""

   (logical (kevin No))

   =>

   (assert (UI-state (display HouseCardsShow)
                     (state final)))) 
                     
(defrule kevin-conclusion-yes ""

   (logical (kevin Yes))

   =>

   (assert (UI-state (display TWWShow)
                     (state final))))         


(defrule stepped-conclusion-yes ""

   (logical (stepped Yes))

   =>

   (assert (UI-state (display TudorsShow)
                     (state final))))       
                     
(defrule strange-conclusion-yes ""

   (logical (strange Yes))

   =>

   (assert (UI-state (display TwinPeaksShow)
                     (state final))))
                     
(defrule strange-conclusion-no ""

   (logical (strange No))

   =>

   (assert (UI-state (display MadMenShow)
                     (state final))))    
                                    
                                                                                                                                                                                                                                                                                                              
;;;*************************
;;;* GUI INTERACTION RULES *
;;;*************************

(defrule ask-question

   (declare (salience 5))
   
   (UI-state (id ?id))
   
   ?f <- (state-list (sequence $?s&:(not (member$ ?id ?s))))
             
   =>
   
   (modify ?f (current ?id)
              (sequence ?id ?s))
   
   (halt))

(defrule handle-next-no-change-none-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
                      
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-response-none-end-of-chain

   (declare (salience 10))
   
   ?f <- (next ?id)

   (state-list (sequence ?id $?))
   
   (UI-state (id ?id)
             (relation-asserted ?relation))
                   
   =>
      
   (retract ?f)

   (assert (add-response ?id)))   

(defrule handle-next-no-change-middle-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)

   ?f2 <- (state-list (current ?id) (sequence $? ?nid ?id $?))
     
   (UI-state (id ?id) (response ?response))
   
   =>
      
   (retract ?f1)
   
   (modify ?f2 (current ?nid))
   
   (halt))

(defrule handle-next-change-middle-of-chain

   (declare (salience 10))
   
   (next ?id ?response)

   ?f1 <- (state-list (current ?id) (sequence ?nid $?b ?id $?e))
     
   (UI-state (id ?id) (response ~?response))
   
   ?f2 <- (UI-state (id ?nid))
   
   =>
         
   (modify ?f1 (sequence ?b ?id ?e))
   
   (retract ?f2))
   
(defrule handle-next-response-end-of-chain

   (declare (salience 10))
   
   ?f1 <- (next ?id ?response)
   
   (state-list (sequence ?id $?))
   
   ?f2 <- (UI-state (id ?id)
                    (response ?expected)
                    (relation-asserted ?relation))
                
   =>
      
   (retract ?f1)

   (if (neq ?response ?expected)
      then
      (modify ?f2 (response ?response)))
      
   (assert (add-response ?id ?response)))   

(defrule handle-add-response

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id ?response)
                
   =>
      
   (str-assert (str-cat "(" ?relation " " ?response ")"))
   
   (retract ?f1))   

(defrule handle-add-response-none

   (declare (salience 10))
   
   (logical (UI-state (id ?id)
                      (relation-asserted ?relation)))
   
   ?f1 <- (add-response ?id)
                
   =>
      
   (str-assert (str-cat "(" ?relation ")"))
   
   (retract ?f1))   

(defrule handle-prev

   (declare (salience 10))
      
   ?f1 <- (prev ?id)
   
   ?f2 <- (state-list (sequence $?b ?id ?p $?e))
                
   =>
   
   (retract ?f1)
   
   (modify ?f2 (current ?p))
   
   (halt))
   
