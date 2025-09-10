import sqlite3
from datetime import datetime

def generate_ai_summary(content):
    """
    为文章内容生成AI摘要的简单实现
    在实际应用中，这里会调用真实的AI模型API
    """
    # 简单的摘要生成逻辑：取前3句话作为摘要
    sentences = content.split('.')
    summary = '. '.join(sentences[:3]) + '.'
    return summary

def update_articles_with_ai_summary():
    # 连接到数据库
    conn = sqlite3.connect('pagejoy.db')
    conn.text_factory = str
    cursor = conn.cursor()
    
    # 获取所有文章
    cursor.execute('SELECT id, content FROM article')
    articles = cursor.fetchall()
    
    # 为每篇文章生成AI摘要并更新数据库
    for article_id, content in articles:
        # 生成AI摘要
        ai_summary = generate_ai_summary(content)
        
        # 更新文章记录
        cursor.execute(
            'UPDATE article SET ai_summary = ? WHERE id = ?',
            (ai_summary, article_id)
        )
        
        print(f"Updated article {article_id} with AI summary: {ai_summary[:50]}...")
    
    # 提交更改并关闭连接
    conn.commit()
    conn.close()
    
    print(f"Successfully updated {len(articles)} articles with AI summaries.")

if __name__ == "__main__":
    update_articles_with_ai_summary()