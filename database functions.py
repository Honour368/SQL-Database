#Database functions
import mysql.connector

# 1 Create database connection
myconn = mysql.connector.connect(host="localhost", user="root", passwd="Honour@002", database="attendance system new")
date = datetime.utcnow()
now = datetime.now()
current_time = now.strftime("%H:%M:%S")
cursor = myconn.cursor()

# Find the student's information in the database.
username = 'olatunjih'
select = "SELECT DISTINCT c.course_id, c.course_title, c.start_time, c.links_of_zoom, c.course_materials, t.tutorial_materials"\
        "FROM participate p, Course c, located l, tutorial t"\
        "WHERE p.course_id = c.course_id"\
        "AND p.username = %s"\
        "AND c.day_of_week = 'Monday'"\
        "AND t.course_id = c.course_id"\
        "AND c.start_time >= time('9:30:00') + time('1:00:00')"