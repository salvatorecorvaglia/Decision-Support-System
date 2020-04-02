;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; 4 Op-blocks world
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (domain BLOCKS)
  (:requirements :strips :typing)
  (:types block)
  (:predicates (on ?x - block ?y - block)
	       (ontable ?x - block)
	       (onbeltconveyor ?x - block)
	       (clear ?x - block)
	       (handempty)
	       (holdblock ?x - block)
	       )

  (:action pick-up
	     :parameters (?x - block)
	     :precondition (and (clear ?x) (ontable ?x) (handempty))
	     :effect
	     (and (not (ontable ?x))
		   (not (clear ?x))
		   (not (handempty))
		   (holdblock ?x)))

  (:action put-down
	     :parameters (?x - block)
	     :precondition (holdblock ?x)
	     :effect
	     (and (not (holdblock ?x))
		   (clear ?x)
		   (handempty)
		   (ontable ?x)))

  (:action put-down-beltconveyor
	     :parameters (?x - block)
	     :precondition (holdblock ?x)
	     :effect
	     (and (not (holdblock ?x))
		   (clear ?x)
		   (handempty)
		   (onbeltconveyor ?x)))

  (:action stack
	     :parameters (?x - block ?y - block)
	     :precondition (and (holdblock ?x) (clear ?y))
	     :effect
	     (and (not (holdblock ?x))
		   (not (clear ?y))
		   (clear ?x)
		   (handempty)
		   (on ?x ?y)))
  (:action unstack
	     :parameters (?x - block ?y - block)
	     :precondition (and (on ?x ?y) (clear ?x) (handempty))
	     :effect
	     (and (holdblock ?x)
		   (clear ?y)
		   (not (clear ?x))
		   (not (handempty))
		   (not (on ?x ?y)))))
