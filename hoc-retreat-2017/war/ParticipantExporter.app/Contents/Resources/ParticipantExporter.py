from google.appengine.ext import db 
from google.appengine.tools import bulkloader 
import models 

class ParticipantExporter(bulkloader.Exporter): 
  def __init__(self): 
    bulkloader.Exporter.__init__(self, 'Participant', 
                                 [
		('family_id', str, None), 
		('hoc_family', str, None), 
		('cname', str, None), 
		('ename', str, None), 
		('email', str, None), 
		('gender', str, None), 
		('cell', str, None), 
		('program', str, None), 
		('topic', str, None), 
		('bed', str, None), 
		('bus', str, None)
                                 ]) 


exporters = [ParticipantExporter] 

