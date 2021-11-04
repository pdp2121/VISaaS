from app import *

def before_feature(context, feature):
    context.client = app.test_client()
    
def after_feature(context, feature):
    context.client = None

