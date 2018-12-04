(defun intfactorial (x)
	(if (zero? x)
		1
		(* x (intfactorial (- x 1)))))
		
(defun floatfactorial (x)
	(if (zero? x)
		1.0
		(* x (floatfactorial (- x 1.0)))))
		
(time (intfactorial 500))
(time (floatfactorial 500))
(print (read-char c))