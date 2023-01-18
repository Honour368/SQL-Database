import urllib
import numpy as np
import mysql.connector
import cv2
import pyttsx3
import pickle
from datetime import datetime
import sys
from tkinter import *
import tkinter as tk
from tkinter import messagebox
from PIL import Image, ImageTk
import webbrowser
import smtplib

# 1 Create database connection
myconn = mysql.connector.connect(host="localhost", user="root", passwd="Honour@002", database="attendance system new")
date = datetime.utcnow()
now = datetime.now()
current_time = now.strftime("%H:%M:%S")
current_date = now.strftime("%m/%d/%Y")
cursor = myconn.cursor()

class Student:
    name = ''
    UID = ''
    Year = ''
    Email = ''
    Department = ''

class Course:
    code = ''
    name = ''
    start_time = ''
    end_time = ''
    classAddress = ''
    teacher_name = ''
    teacher_welcome_message = ''
    zoom_link = ''
    lecture_note = ''
    tutorial_note = ''
    courseinfo = ''

s1 = Student()
c1 = Course()

#Link codes
def open_link(url):
    webbrowser.open_new(url)

def send_email(email_address, course):
    server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
    server.login("honour368123@gmail.com", "Password@123")
    text = "Course code - " + course.code + '\n' + "Course name - " + course.name + '\n' + "Start time - " +  course.start_time + '\n' + "End time - " +  course.end_time + '\n'"Class Address - " + course.classAddress + '\n' + "Teacher's name - " + course.teacher_name + '\n'
    server.sendmail("honour368123@gmail.com", email_address, text)
    server.quit()
    print("Email sent")

#Database codes
def get_student_details(username):
    # Find the student's personal details in the database.
    select = "SELECT s.student_name, s.faculty, s.student_id, s.email, s.year "\
            "FROM student s "\
            "WHERE s.username = \'" + username + "\' "
    name = cursor.execute(select)
    return cursor.fetchall()

def get_course_details(username):
    # Find the student's course information in the database.
    select = "SELECT DISTINCT c.course_id, c.course_title, c.start_time, c.links_of_zoom, c.course_materials, t.tutorial_materials, it.instructor_name, cl.classroom_address, c.courseinfo, c.end_time "\
            "FROM participate p, Course c, located l, tutorial t, instruct i, instructor it, classroom cl "\
            "WHERE p.course_id = c.course_id "\
            "AND i.course_id = p.course_id "\
            "AND p.username = \'" + username + "\' "\
            "AND c.day_of_week = WEEKDAY(CURDATE()) "\
            "AND it.instructor_id = i.instructor_id "\
            "AND t.course_id = c.course_id "\
            "AND cl.classroom_id = l.classroom_id "\
            "AND l.course_id = c.course_id "\
            "AND ((c.start_time >= CURRENT_TIME "\
            "AND c.start_time <= ADDTIME(CURRENT_TIME, \"1:00:00\")) "\
            "OR (CURRENT_TIME >= c.start_time AND CURRENT_TIME <= c.end_time))"
    # select = "SELECT student_id, name, DAY(login_date), MONTH(login_date), YEAR(login_date) FROM Student WHERE name='%s'" % (name)
    name = cursor.execute(select)
    return cursor.fetchall()

def get_timetable(username):
    #Find student's timetable information in database.
    select = "SELECT c.course_id, c.start_time, c.end_time, c.day_of_week "\
            "FROM course c, participate p "\
            "WHERE p.username = \'" + username + "\' "\
            "AND c.course_id = p.course_id"
    timetable = cursor.execute(select)
    return cursor.fetchall()

def logout(username):
    update =  "UPDATE Student SET logout_time=CURTIME() WHERE username=\"" + username + "\""
 
    cursor.execute(update)
    myconn.commit()
    loginduration = "UPDATE Student SET login_duration=TIMEDIFF(logout_time, login_time) WHERE username=\"" + username + "\""
    cursor.execute(loginduration)
    myconn.commit()
    print("You have successfully Logged out!")
    exit()

#GUI codes
def first_frame():
    #First frame
    top_frame = tk.Frame(window)
    top_frame.grid(row=0, column=1)
    welcome_display = tk.Text(top_frame, height=7, width=31, font = "Helvetica 13")
    welcome_display.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(5, 5))
    welcome_display.insert(tk.END, "Welcome " + s1.name + '\n' )
    welcome_display.insert(tk.END, "UID: " + str(s1.UID) + '\n')
    welcome_display.insert(tk.END, "Year " + str(s1.Year) + " " + s1.Major +" Student" + '\n')
    welcome_display.insert(tk.END, "Thank you for using our interface!" + '\n')
    welcome_display.insert(tk.END, "Your login time: " + current_time)
    welcome_display.config(background="pale turquoise", highlightbackground="grey")

    # create a canvas to show image on
    top_left = tk.Frame(window)
    top_left.grid(row=0, column=0)
    top_right = tk.Frame(window)
    top_right.grid(row=0, column=2)
    canvas_for_image1 = Canvas(top_left, bg='gray', height=100, width=100, borderwidth=0, highlightthickness=0)
    canvas_for_image2 = Canvas(top_right, bg='gray', height=100, width=100, borderwidth=0, highlightthickness=0)
    canvas_for_image1.grid(row=0, column=0, sticky='nesw', padx=0, pady=0)
    canvas_for_image2.grid(row=0, column=2, sticky='nesw', padx=0, pady=0)

    # create image from image location resize it to 200X200 and put in on canvas
    image = Image.open('hku_logo.jpg')
    canvas_for_image1.image = ImageTk.PhotoImage(image.resize((100, 100), Image.ANTIALIAS))
    canvas_for_image1.create_image(0, 0, image=canvas_for_image1.image, anchor='nw')
    canvas_for_image2.image = ImageTk.PhotoImage(image.resize((100, 100), Image.ANTIALIAS))
    canvas_for_image2.create_image(0, 0, image=canvas_for_image2.image, anchor='nw')

    # top_left.pack(side=tk.LEFT)
    # top_frame.pack(side=tk.TOP)

def second_frame():
    #Second frame
    middle_frame = tk.Frame(window)
    course_display = tk.Text(middle_frame, height=14, width=61, font = "Helvetica 13")
    course_display.pack(side=tk.TOP, fill=tk.Y, padx=(5, 5), pady=(0, 5))
    course_display.insert(tk.END, "-> Course code: " + c1.code + '\n' )
    course_display.insert(tk.END, "-> Course name: " + c1.name + '\n')
    course_display.insert(tk.END, "-> Start time: " + c1.start_time + '\n')
    course_display.insert(tk.END, "-> End time: " + c1.end_time + '\n')
    course_display.insert(tk.END, "-> Class Address: " + c1.classAddress + '\n')
    course_display.insert(tk.END, "-> Teacher's name: " + c1.teacher_name +  '\n')
    # course_display.insert(tk.END, "-> Welcome Message: " + c1.teacher_welcome_message + '\n')
    course_display.config(background="DarkOliveGreen1", highlightbackground="grey")

    middle_frame.grid(row=1, columnspan=3)
    # middle_frame.pack(side=tk.BOTTOM)

    #Frame for link buttons
    button_frame = tk.Frame(window)
    #Course information button
    courseinfo_link = Label(button_frame, text="Course info", fg="blue", cursor="hand2")
    courseinfo_link.pack(side=tk.LEFT, fill=tk.Y, padx=(10, 10), pady=(0, 5))
    courseinfo_link.bind("<Button-1>", lambda e: open_link(c1.courseinfo))
    #Zoom link
    zoom_link = Label(button_frame, text="Zoom Link", fg="blue", cursor="hand2")
    zoom_link.pack(side=tk.LEFT, fill=tk.Y, padx=(10, 10), pady=(0, 5))
    zoom_link.bind("<Button-1>", lambda e: open_link(c1.zoom_link))
    #Lecture note link
    note_link = Label(button_frame, text="Lecture Note", fg="blue", cursor="hand2")
    note_link.pack(side=tk.LEFT, fill=tk.Y, padx=(10, 10), pady=(0, 5))
    note_link.bind("<Button-1>", lambda e: open_link(c1.lecture_note))
    #Tutorial note link
    tutorial_link = Label(button_frame, text="Tutorial Material", fg="blue", cursor="hand2")
    tutorial_link.pack(side=tk.LEFT, fill=tk.Y, padx=(10, 10), pady=(0, 5))
    tutorial_link.bind("<Button-1>", lambda e: open_link(c1.tutorial_note))
    #Send details to email
    email_link = Label(button_frame, text="Send to my Email", fg="blue", cursor="hand2")
    email_link.pack(side=tk.LEFT, fill=tk.Y, padx=(10, 10), pady=(0, 5))
    email_link.bind("<Button-1>", lambda e: send_email(s1.Email, c1))
    #Log out Button
    button_link = Label(button_frame, text="Log Out", fg="blue", cursor="hand2")
    button_link.pack(side=tk.LEFT, fill=tk.Y, padx=(10, 10), pady=(0, 5))
    button_link.bind("<Button-1>", lambda e: logout(username))

    button_frame.grid(row=2, columnspan=3)

def third_frame():
    #if student doesn't have class within the hour
    #Monday
    monday_frame = tk.Frame(window)
    mondayD = tk.Text(monday_frame, height=2, width=10, font = "Helvetica 13")
    mondayD.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(0, 0))
    mondayD.insert(tk.END, "Monday")
    mondayD.config(background="DarkOliveGreen1", highlightbackground="grey")
    monday_frame.grid(row=1, column=0)

    #display courses for monday
    mondayclass_frame = tk.Frame(window)
    mondayclass = tk.Text(mondayclass_frame, height=2, width=42, font = "Helvetica 13")
    mondayclass.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(0, 0))
    for y in monday:
        mondayclass.insert(tk.END, y[0] + " " + str(y[1]) + " - " + str(y[2]) + '\n')
    mondayclass.config(background="Yellow", highlightbackground="grey")
    mondayclass_frame.grid(row=1, column=1, columnspan = 2)

    #Tuesday
    tuesday_frame = tk.Frame(window)
    tuesdayD = tk.Text(tuesday_frame, height=2, width=10, font = "Helvetica 13")
    tuesdayD.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(0, 0))
    tuesdayD.insert(tk.END, "Tuesday")
    tuesdayD.config(background="DarkOliveGreen1", highlightbackground="grey")
    tuesday_frame.grid(row=2, column=0)

    #display courses for tuesday
    tuesdayclass_frame = tk.Frame(window)
    tuesdayclass = tk.Text(tuesdayclass_frame, height=2, width=42, font = "Helvetica 13")
    tuesdayclass.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(0, 0))
    for y in tuesday:
        tuesdayclass.insert(tk.END, y[0] + " " + str(y[1]) + " - " + str(y[2]) + '\n')
    tuesdayclass.config(background="Yellow", highlightbackground="grey")
    tuesdayclass_frame.grid(row=2, column=1, columnspan = 2)

    #Wednesday
    wednesday_frame = tk.Frame(window)
    wednesdayD = tk.Text(wednesday_frame, height=2, width=10, font = "Helvetica 13")
    wednesdayD.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(0, 0))
    wednesdayD.insert(tk.END, "Wednesday")
    wednesdayD.config(background="DarkOliveGreen1", highlightbackground="grey")
    wednesday_frame.grid(row=3, column=0)

    #display courses for wednesday
    wednesdayclass_frame = tk.Frame(window)
    wednesdayclass = tk.Text(wednesdayclass_frame, height=2, width=42, font = "Helvetica 13")
    wednesdayclass.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(0, 0))
    for y in wednesday:
        wednesdayclass.insert(tk.END, y[0] + " " + str(y[1]) + " - " + str(y[2]) + '\n')
    wednesdayclass.config(background="Yellow", highlightbackground="grey")
    wednesdayclass_frame.grid(row=3, column=1, columnspan = 2)

    #Thursday
    thursday_frame = tk.Frame(window)
    thursdayD = tk.Text(thursday_frame, height=2, width=10, font = "Helvetica 13")
    thursdayD.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(0, 0))
    thursdayD.insert(tk.END, "Thursday")
    thursdayD.config(background="DarkOliveGreen1", highlightbackground="grey")
    thursday_frame.grid(row=4, column=0)

    #display courses for thursday
    thursdayclass_frame = tk.Frame(window)
    thursdayclass = tk.Text(thursdayclass_frame, height=2, width=42, font = "Helvetica 13")
    thursdayclass.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(0, 0))
    for y in thursday:
        thursdayclass.insert(tk.END, y[0] + " " + str(y[1]) + " - " + str(y[2]) + '\n')
    thursdayclass.config(background="Yellow", highlightbackground="grey")
    thursdayclass_frame.grid(row=4, column=1, columnspan = 2)

    #Friday
    friday_frame = tk.Frame(window)
    fridayD = tk.Text(friday_frame, height=2, width=10, font = "Helvetica 13")
    fridayD.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(0, 0))
    fridayD.insert(tk.END, "Friday")
    fridayD.config(background="DarkOliveGreen1", highlightbackground="grey")
    friday_frame.grid(row=5, column=0)

    #display courses for friday
    fridayclass_frame = tk.Frame(window)
    fridayclass = tk.Text(fridayclass_frame, height=2, width=42, font = "Helvetica 13")
    fridayclass.pack(side=tk.TOP, fill=tk.Y, padx=(0, 0), pady=(0, 0))
    for y in friday:
        fridayclass.insert(tk.END, y[0] + " " + str(y[1]) + " - " + str(y[2]) + '\n')
    fridayclass.config(background="Yellow", highlightbackground="grey")
    fridayclass_frame.grid(row=5, column=1, columnspan = 2)

    #Frame for link buttons
    button_frame = tk.Frame(window)
    #Log out Button
    button_link = Label(button_frame, text="Log Out", fg="blue", cursor="hand2")
    button_link.pack(side=tk.LEFT, fill=tk.Y, padx=(10, 10), pady=(5, 5))
    button_link.bind("<Button-1>", lambda e: logout(username))
    button_frame.grid(row=6, columnspan=3)

#2 Load recognize and read label from model
recognizer = cv2.face.LBPHFaceRecognizer_create()
recognizer.read("train.yml")

labels = {"person_name": 1}
with open("labels.pickle", "rb") as f:
    labels = pickle.load(f)
    labels = {v: k for k, v in labels.items()}

# create text to speech
engine = pyttsx3.init()
rate = engine.getProperty("rate")
engine.setProperty("rate", 175)

# Define camera and detect face
face_cascade = cv2.CascadeClassifier('haarcascade/haarcascade_frontalface_default.xml')
cap = cv2.VideoCapture(0, cv2.CAP_DSHOW)

# 3 Open the camera and start face recognition
while True:
    ret, frame = cap.read()
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.5, minNeighbors=5)

    for (x, y, w, h) in faces:
        print(x, w, y, h)
        roi_gray = gray[y:y + h, x:x + w]
        roi_color = frame[y:y + h, x:x + w]
        # predict the id and confidence for faces
        id_, conf = recognizer.predict(roi_gray)

        # If the face is recognized
        if conf >= 60:
            # print(id_)
            # print(labels[id_])
            font = cv2.QT_FONT_NORMAL
            id = 0
            id += 1
            name = labels[id_]
            username = name
            color = (255, 0, 0)
            stroke = 2
            cv2.putText(frame, name, (x, y), font, 1, color, stroke, cv2.LINE_AA)
            cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), (2))

            # Find the student's information in the database.
            result = get_student_details(username)
            data = "error"

            for x in result:
                data = x

            if data == "error":
                print("The student", username, "is NOT FOUND in the database.")

            else:
                window = tk.Tk()
                window.title("Attendance System GUI")
                s1.name = x[0]
                s1.Major = x[1]
                s1.UID = x[2]
                s1.Email = x[3]
                s1.Year = x[4]
                first_frame()

                result = get_course_details(username)
                data = "error"

                for x in result:
                    data = x
                
                if data == "error":
                    result = get_timetable(username)
                    data = "error"
                    timetablearray = []
                    for x in result:
                        data = x
                        timetablearray.append(data)

                    monday = []
                    tuesday = []
                    wednesday = []
                    thursday = []
                    friday = []
                    for x in timetablearray:
                        if x[3] == 0:
                            monday.append(x)
                        elif x[3] == 1:
                            tuesday.append(x)
                        elif x[3] == 2:
                            wednesday.append(x)
                        elif x[3] == 3:
                            thursday.append(x)
                        elif x[3] == 4:
                            friday.append(x)
                    third_frame()
                else:
                    c1.code = x[0]
                    c1.name = x[1]
                    c1.start_time = str(x[2])
                    c1.zoom_link = x[3]
                    c1.lecture_note = x[4]
                    c1.tutorial_note = x[5]
                    c1.teacher_name = x[6]
                    c1.classAddress = x[7]
                    c1.courseinfo = x[8]
                    c1.end_time = str(x[9])
                    second_frame()
                update =  "UPDATE Student SET login_date=CURDATE() WHERE username=\"" + username + "\"" 
                cursor.execute(update)
                update = "UPDATE Student SET login_time=CURTIME() WHERE username=\"" + username + "\""
                cursor.execute(update)
                myconn.commit()
                hello = "Hello " +username + " You did attendance today"
                print(hello)
                engine.say(hello)
                cap.release()
                cv2.destroyAllWindows()
                window.mainloop()
                # engine.runAndWait()


            # select = "SELECT student_id, name, DAY(login_date), MONTH(login_date), YEAR(login_date) FROM Student WHERE name='%s'" % (name)
            # name = cursor.execute(select)
            # result = cursor.fetchall()
            # # print(result)
            # data = "error"

            # for x in result:
            #     data = x

            # # If the student's information is not found in the database
            # if data == "error":
            #     print("The student", current_name, "is NOT FOUND in the database.")

            # # If the student's information is found in the database
            # else:
            #     """
            #     Implement useful functions here.
            #     Check the course and classroom for the student.
            #         If the student has class room within one hour, the corresponding course materials
            #             will be presented in the GUI.
            #         if the student does not have class at the moment, the GUI presents a personal class 
            #             timetable for the student.

            #     """
                # Update the data in database

        # If the face is unrecognized
        else: 
            color = (255, 0, 0)
            stroke = 2
            font = cv2.QT_FONT_NORMAL
            cv2.putText(frame, "UNKNOWN", (x, y), font, 1, color, stroke, cv2.LINE_AA)
            cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), (2))
            hello = ("Your face is not recognized")
            print(hello)
            engine.say(hello)
            # engine.runAndWait()

    cv2.imshow('Attendance System Face Recognition', frame)
    k = cv2.waitKey(20) & 0xff
    if k == ord('q'):
        break
        
cap.release()
cv2.destroyAllWindows()
