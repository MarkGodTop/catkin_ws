;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::AngleRateThrottle)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'AngleRateThrottle (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::ANGLERATETHROTTLE")
  (make-package "UAV_MSGS::ANGLERATETHROTTLE"))

(in-package "ROS")
;;//! \htmlinclude AngleRateThrottle.msg.html


(defclass uav_msgs::AngleRateThrottle
  :super ros::object
  :slots (_rollRate _pitchRate _yawRate _throttle ))

(defmethod uav_msgs::AngleRateThrottle
  (:init
   (&key
    ((:rollRate __rollRate) 0.0)
    ((:pitchRate __pitchRate) 0.0)
    ((:yawRate __yawRate) 0.0)
    ((:throttle __throttle) 0.0)
    )
   (send-super :init)
   (setq _rollRate (float __rollRate))
   (setq _pitchRate (float __pitchRate))
   (setq _yawRate (float __yawRate))
   (setq _throttle (float __throttle))
   self)
  (:rollRate
   (&optional __rollRate)
   (if __rollRate (setq _rollRate __rollRate)) _rollRate)
  (:pitchRate
   (&optional __pitchRate)
   (if __pitchRate (setq _pitchRate __pitchRate)) _pitchRate)
  (:yawRate
   (&optional __yawRate)
   (if __yawRate (setq _yawRate __yawRate)) _yawRate)
  (:throttle
   (&optional __throttle)
   (if __throttle (setq _throttle __throttle)) _throttle)
  (:serialization-length
   ()
   (+
    ;; float64 _rollRate
    8
    ;; float64 _pitchRate
    8
    ;; float64 _yawRate
    8
    ;; float64 _throttle
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _rollRate
       (sys::poke _rollRate (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pitchRate
       (sys::poke _pitchRate (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yawRate
       (sys::poke _yawRate (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _throttle
       (sys::poke _throttle (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _rollRate
     (setq _rollRate (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pitchRate
     (setq _pitchRate (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yawRate
     (setq _yawRate (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _throttle
     (setq _throttle (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get uav_msgs::AngleRateThrottle :md5sum-) "93bb283398a326cfc4d5e3c6a992ff87")
(setf (get uav_msgs::AngleRateThrottle :datatype-) "uav_msgs/AngleRateThrottle")
(setf (get uav_msgs::AngleRateThrottle :definition-)
      "float64 rollRate
float64 pitchRate
float64 yawRate
float64 throttle

")



(provide :uav_msgs/AngleRateThrottle "93bb283398a326cfc4d5e3c6a992ff87")

