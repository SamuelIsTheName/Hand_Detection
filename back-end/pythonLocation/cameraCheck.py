import cv2

cap = cv2.VideoCapture(0)

# List the supported frame sizes
for i in range(20):
    width = cap.get(3)
    height = cap.get(4)
    print(f"Frame Size {i + 1}: Width = {width}, Height = {height}")
    success, _ = cap.read()
    if not success:
        break

# Release the VideoCapture
cap.release()
cv2.destroyAllWindows()
