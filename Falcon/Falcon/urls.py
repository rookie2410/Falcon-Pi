from django.urls import path
from falconpi import  views 

urlpatterns = [
    
    path('test/',  views.index, name='crud_ajax'),
    path('',  views.input, name='input'),
    path('savedata',  views.savedata, name='savedata'),
    path('down',  views.down, name='down'),
    path('shell',  views.shell, name='shell'),

]