(defmodule MONKEY-BANANAS
  (import MAIN))

;; Hechos
(deftemplate objeto
  (slot nombre (type SYMBOL))
  (slot posicion (type SYMBOL)))

(deffacts inicio
  (objeto (nombre mono) (posicion suelo))
  (objeto (nombre caja) (posicion suelo))
  (objeto (nombre platanos) (posicion arriba)))

;; Reglas
(defrule subir-caja
  (objeto (nombre mono) (posicion suelo))
  (objeto (nombre caja) (posicion suelo))
  =>
  (modify (objeto (nombre caja) (posicion arriba)))
  (printout t "El mono sube la caja." crlf))

(defrule agarrar-platanos
  (objeto (nombre mono) (posicion suelo))
  (objeto (nombre platanos) (posicion arriba))
  =>
  (modify (objeto (nombre platanos) (posicion en-manos)))
  (printout t "El mono agarra los plátanos." crlf))

(defrule bajar-caja
  (objeto (nombre mono) (posicion suelo))
  (objeto (nombre caja) (posicion arriba))
  =>
  (modify (objeto (nombre caja) (posicion suelo)))
  (printout t "El mono baja la caja." crlf))

(defrule comer-platanos
  (objeto (nombre mono) (posicion suelo))
  (objeto (nombre platanos) (posicion en-manos))
  =>
  (retract (objeto (nombre platanos) (posicion en-manos)))
  (printout t "El mono come los plátanos." crlf))

(defrule resolver-problema
  (not (objeto (nombre platanos) (posicion en-manos)))
  =>
  (assert (objeto (nombre mono) (posicion suelo)))
  (assert (objeto (nombre caja) (posicion suelo)))
  (assert (objeto (nombre platanos) (posicion arriba)))
  (subir-caja)
  (agarrar-platanos)
  (bajar-caja)
  (comer-platanos)
  (halt))