#!/usr/bin/python
import cgi,os
import getpass
form = cgi.FieldStorage()
print"Content-Type: text/html"
print""
print"<html>"
print"<h2>System Date</h2>"
print"<p>"
print"The user entered data:<br>"
print"<b>mon:</b> "+ form["mon"].value +"<br>"
print"<b>day:</b> "+ form["day"].value +"<br>"
mon = int(form["mon"].value )
day = int(form["day"].value)
hour = int(form["hour"].value)
minute = int(form["minute"].value)
if (1<= mon <=12) and (1<= day <=31) and (0<= hour <=23) and (0<= minute <=59):
    output =  os.popen(r'sudo date -s "2016-%d-%d %d:%d"' % (mon,day,hour,minute))
    print output.read()
else:
    print "error time input"
print"</p>"
print"</html>"
