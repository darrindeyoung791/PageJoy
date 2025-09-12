from main import app
import uvicorn

def check_app():
    print('Checking app...')
    print(f'App title: {app.title}')
    
    # Find the articles route
    articles_routes = [route for route in app.routes if route.path == "/articles/"]
    print(f'Articles routes: {articles_routes}')
    
    print('App checked successfully')

if __name__ == "__main__":
    check_app()
    # Run the app
    uvicorn.run(app, host='127.0.0.1', port=8000)