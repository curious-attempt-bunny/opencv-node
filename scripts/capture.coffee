#Shows how to capture an image from the camera
cv = require './opencv'
VideoCapture = cv.VideoCapture
Mat = cv.Mat

testCapture = ->
	cap = new VideoCapture 0

	if not cap.isOpened()
		console.log 'Could not open video device'
		return

	edges = new Mat

	cv.namedWindow "camera", 1
	cv.namedWindow "output", 1

	running = true
	#note that in a real script you would want to use process.nextTick() to do the capture,
	#otherwise the script engine will be forever busy running this while
	#See effects.coffee
	while running

		frame = new Mat

		cap.read frame

		cv.imshow "camera", frame

		cv.cvtColor frame, edges, cv.CV_BGR2GRAY
		#cv.GaussianBlur edges, edges, {width: 7, height: 7}, 1.5, 1.5
		#cv.Canny edges, edges, 0, 30, 3

		cv.imshow "output", edges

		if cv.waitKey(27) >=0 
			running = false


testCapture()