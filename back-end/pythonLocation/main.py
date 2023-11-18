from flask import Flask, jsonify, request
from flask_cors import CORS
from threading import Thread
import cv2
from cvzone.HandTrackingModule import HandDetector
from flask_socketio import SocketIO, emit


app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins=["http://localhost:3000"])

CORS(app, resources={r"/api/*": {"origins": "http://localhost:3000"},
                     r"/socket.io/*": {"origins": "http://localhost:3000"}})

bbox1_data = None


@app.route('/api/get_bbox1', methods=['GET'])
def get_bbox1():
    global bbox1_data
    return jsonify(bbox1_data)


@socketio.on('connect', namespace='/hand_tracking')
def handle_connection():
    print('Client connected to /hand_tracking namespace')


def hand_detection():
    global bbox1_data
    cap = cv2.VideoCapture(0)
    # cap.set(3, 1280)
    # cap.set(4, 720)
    detector = HandDetector(detectionCon=0.8, maxHands=1)

    while True:
        success, img = cap.read()
        hands, img = detector.findHands(img)
        # cv2.imshow("Image", img)
        # cv2.waitKey(1)

        if hands:
            hand1 = hands[0]
            bbox1 = hand1["bbox"]

            flipped_bbox1 = (cap.get(3) - bbox1[0], bbox1[1], bbox1[2], bbox1[3])
            bbox1_data = flipped_bbox1
            print(bbox1_data)
            socketio.emit("data-update", bbox1_data, namespace="/hand_tracking")


if __name__ == '__main__':
    hand_thread = Thread(target=hand_detection)
    hand_thread.start()
    socketio.run(app, host="0.0.0.0", port=5000)
