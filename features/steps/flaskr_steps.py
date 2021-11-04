from behave import given, when, then

@given(u'VISaaS is set up')
def flask_setup(context):
    assert context.client

@given(u'I choose {dataset} data')
@when(u'I choose {dataset} data')
def choose_data(context, dataset):
    context.page = context.client.get('/' + str(dataset), follow_redirects = True)
    assert context.page
    
@when(u'I enter the filter "{filter}" for {dataset} data')
def enter_filter(context, filter, dataset):
    context.page = context.client.post('/' + str(dataset), data=dict(
        filter=filter
    ), follow_redirects = True)
    assert context.page
    
@when(u'I enter the filter "{filter}" while visualizing {dataset} data')
def enter_filter_v(context, filter, dataset):
    context.page = context.client.post('/' + str(dataset) + "_visualization", data=dict(
        filter=filter
    ), follow_redirects = True)
    assert context.page
    
@when(u'I download the {dataset} data')
def download_data(context, dataset):
    context.page = context.client.get('/downloadfiles/' + str(dataset) + '.json', follow_redirects = True)
    assert context.page
    
@when(u'I return to the home page')
def return_home(context):
    context.page = context.client.get('/', follow_redirects = True)
    assert context.page
    
@given(u'I visualize {dataset} data')
@when(u'I visualize {dataset} data')
def visualize(context, dataset):
    context.page = context.client.get('/' + str(dataset) + '_visualization', follow_redirects = True)
    assert context.page
    
@then(u'I should see "{text}"')
def see_text(context, text):
    assert text.encode('utf-8') in context.page.data
    
@then(u'I should not see "{text}"')
def see_text(context, text):
    assert text.encode('utf-8') not in context.page.data

@given(u'i login with "{username}" and "{password}"')
@when(u'i login with "{username}" and "{password}"')
def login(context, username, password):
    context.page = context.client.post('/login', data=dict(
        username=username,
        password=password
    ), follow_redirects=True)
    assert context.page


@when(u'i logout')
def logout(context):
    context.page = context.client.get('/logout', follow_redirects=True)
    assert context.page


# @then(u'i should see the alert "{message}"')
# def logged_in(context, message):
#     assert message in context.page.data
