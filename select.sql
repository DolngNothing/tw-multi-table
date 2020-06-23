# 1.Query the existence of 1 course

select * from course where `id`=1;

# 2.Query the presence of both 1 and 2 courses

select * from course where `id`=1 or `id`=2;

# 3.Query the student number and student name and average score of students whose average score is 60 or higher.

select count(*) as `nums`,avg(score) ,GROUP_CONCAT(DISTINCT(student.`name`))as student_name
from student_course left join student on studentId=student.id
where student_course.score>=60;

select studentId,student.`name`,(select avg(score) from student_course where score>=60) as avgscore
from student_course left join student on studentId=student.id
where student_course.score>=60;

# 4.Query the SQL statement of student information that does not have grades in the student_course table

select * from student where student.id NOT IN(select distinct(studentId) from student_course);

# 5.Query all SQL with grades

select distinct(score) from student_course;

# 6.Inquire about the information of classmates who have numbered 1 and also studied the course numbered 2

select student.*
from student_course left join student on studentId=student.id
where courseId=1
AND studentId IN (SELECT studentId from student_course WHERE courseId=2);

# 7.Retrieve 1 student score with less than 60 scores in descending order

select student.*,student_course.score
from student_course left join student on studentId=student.id
where score<60
order by score desc

# 8.Query the average grade of each course. The results are ranked in descending order of average grade. When the average grades are the same, they are sorted in ascending order by course number.

select avg(score) as avgscore,course.`name`,courseId
from student_course left join course on courseId=course.id
GROUP BY course.`name`,courseId
ORDER BY avgscore DESC,courseId;

# 9.Query the name and score of a student whose course name is "Math" and whose score is less than 60

select score,student.`name`
from student_course left join course on courseId=course.id left join student on studentId=student.id
WHERE course.`name`='Math' and student_course.score<60;


