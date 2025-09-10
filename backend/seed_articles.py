import os
import sys
from sqlalchemy.orm import sessionmaker
from sqlalchemy import create_engine
from models.models import Base, Article, ArticleStatus
from database import SQLALCHEMY_DATABASE_URL

def seed_articles():
    # Create engine and session with UTF-8 encoding
    engine = create_engine(
        SQLALCHEMY_DATABASE_URL, 
        connect_args={"check_same_thread": False},
        encoding='utf-8'
    )
    SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
    db = SessionLocal()
    
    # Sample article data with English titles and content
    sample_articles = [
        {
            "title": "The Future of Artificial Intelligence in Healthcare",
            "content": """Artificial intelligence is revolutionizing the healthcare industry in unprecedented ways. From diagnostic imaging to drug discovery, AI technologies are transforming how medical professionals approach patient care. Machine learning algorithms can now analyze medical images with greater accuracy than human radiologists in some cases, leading to earlier detection of diseases like cancer.

The integration of AI in healthcare extends beyond diagnostics. Predictive analytics are being used to forecast patient outcomes, optimize treatment plans, and reduce hospital readmission rates. Natural language processing technologies help extract valuable insights from unstructured clinical notes, enabling better decision-making.

Robotic surgery, powered by AI, allows for more precise and minimally invasive procedures. These systems can filter out hand tremors and provide enhanced visualization, leading to better patient outcomes and faster recovery times.

However, the adoption of AI in healthcare also raises important ethical considerations. Issues around data privacy, algorithmic bias, and the potential for job displacement need careful consideration. As we move forward, it's crucial to ensure that AI technologies enhance rather than replace the human touch in healthcare.

The future of AI in healthcare looks promising, with continued advancements expected in personalized medicine, mental health support, and remote patient monitoring. As these technologies mature, they have the potential to make healthcare more accessible, efficient, and effective for patients worldwide.""",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "Sustainable Energy: Powering the Future with Renewable Resources",
            "content": """The transition to sustainable energy sources has become a critical global priority as we face the escalating challenges of climate change. Renewable energy technologies, including solar, wind, hydroelectric, and geothermal power, are rapidly transforming the global energy landscape.

Solar energy has experienced remarkable growth over the past decade, with costs dropping by more than 80% since 2010. Photovoltaic technology continues to improve, with new materials and designs increasing efficiency while reducing manufacturing costs. Large-scale solar farms are now generating electricity at prices competitive with fossil fuels in many regions.

Wind energy, both onshore and offshore, is another rapidly growing sector. Modern wind turbines are becoming more efficient and capable of generating power in a wider range of wind conditions. Offshore wind farms, in particular, offer vast potential due to the stronger and more consistent winds available at sea.

Energy storage technologies are crucial for addressing the intermittent nature of renewable sources. Battery technology, particularly lithium-ion batteries, has advanced significantly, making it possible to store excess energy generated during peak production times for use when production is low.

The transition to renewable energy also involves upgrading electrical grids to handle distributed generation and bidirectional power flows. Smart grid technologies enable better integration of renewable sources and improve overall grid reliability and efficiency.

Government policies and incentives play a vital role in accelerating the adoption of renewable energy. Many countries have set ambitious targets for renewable energy deployment, backed by investments in research, development, and infrastructure.

The economic benefits of renewable energy extend beyond environmental protection. The sector is creating millions of jobs worldwide, from manufacturing and installation to maintenance and research. As technology continues to advance, renewable energy is positioned to become the dominant source of global electricity generation in the coming decades.""",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": True,
            "price": 9.99
        },
        {
            "title": "Blockchain Innovation: Beyond Cryptocurrency",
            "content": "Blockchain technology has evolved far beyond its origins in cryptocurrency to offer innovative solutions across various industries. At its core, blockchain provides a decentralized, immutable ledger that can securely record transactions and track assets in a business network.",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "Mental Health in the Digital Age",
            "content": """The digital age has brought unprecedented connectivity and convenience, but it has also introduced new challenges to mental health. Social media platforms, while connecting people across the globe, can contribute to feelings of inadequacy, anxiety, and depression, especially among younger users.

The constant availability of digital devices and the pressure to be always connected can lead to digital fatigue and burnout. The blue light emitted by screens can disrupt sleep patterns, further impacting mental well-being.

However, technology also offers innovative solutions for mental health support. Mental health apps provide accessible resources for stress management, meditation, and cognitive behavioral therapy. Teletherapy platforms make professional help more accessible to those in remote areas or with mobility constraints.

Digital detox practices are becoming increasingly important for maintaining mental balance. Setting boundaries around device usage, creating tech-free zones in homes, and scheduling regular breaks from digital devices can help reduce stress and improve overall well-being.

Employers are also recognizing the importance of mental health in the digital workplace. Many companies are implementing wellness programs, flexible work arrangements, and mental health resources to support their employees.

As we navigate the digital age, finding a healthy balance between leveraging technology's benefits and protecting our mental health is crucial for long-term well-being.""",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "Smart Cities: The Urban Future",
            "content": """The concept of smart cities represents a transformative approach to urban development that leverages technology to improve the quality of life for residents while enhancing sustainability and efficiency. These cities integrate information and communication technologies (ICT) with the Internet of Things (IoT) to manage city assets and resources efficiently.

Key components of smart cities include intelligent transportation systems that reduce traffic congestion and improve public transit, smart grids that optimize energy distribution, and advanced water management systems that ensure efficient use of this precious resource.

Data analytics play a crucial role in smart city initiatives, enabling city planners and administrators to make informed decisions based on real-time information. Sensors deployed throughout the city collect data on everything from air quality to pedestrian traffic, providing insights that drive improvements in urban planning and resource allocation.

Smart buildings equipped with automated systems for lighting, heating, and cooling contribute to energy efficiency and reduced environmental impact. These buildings can also enhance occupant comfort and productivity through personalized environmental controls.

Citizen engagement is another important aspect of smart cities. Digital platforms enable residents to participate in local governance, report issues, and access city services more conveniently. This increased transparency and accessibility foster a stronger sense of community and civic participation.

The development of smart cities also presents challenges, including concerns about data privacy, the digital divide, and the need for substantial investment in infrastructure. Addressing these challenges requires careful planning, collaboration between public and private sectors, and a commitment to inclusive development that benefits all residents.

As urban populations continue to grow, smart city initiatives offer promising solutions for creating more livable, sustainable, and efficient urban environments for future generations.""",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": True,
            "price": 12.99
        },
        {
            "title": "Biotechnology Breakthroughs",
            "content": "Recent advances in biotechnology are revolutionizing medicine and healthcare. Gene editing technologies like CRISPR-Cas9 allow scientists to make precise changes to DNA, opening new possibilities for treating genetic disorders.",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "Digital Art Revolution",
            "content": "The emergence of digital art forms, including NFTs and algorithmic art, is transforming the art world. These new mediums offer artists unprecedented creative possibilities and new ways to connect with audiences.",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "Space Exploration: Journey to the Stars",
            "content": """Humanity's quest to explore space has entered a new era with the rise of private space companies and ambitious plans for interplanetary travel. The successful landing of rovers on Mars and the ongoing operations of the International Space Station demonstrate our growing capabilities in space exploration.

Private companies like SpaceX, Blue Origin, and Virgin Galactic are revolutionizing the space industry with reusable rockets and ambitious plans for commercial space travel. These developments are significantly reducing the cost of accessing space and opening new possibilities for both scientific research and commercial ventures.

Mars colonization remains one of the most ambitious goals in space exploration. NASA's Artemis program aims to return humans to the Moon as a stepping stone to Mars, while SpaceX's Starship is being developed specifically for interplanetary travel. These missions face numerous technical and logistical challenges, including radiation exposure, life support systems, and the psychological effects of long-duration space travel.

The search for extraterrestrial life continues through missions to explore the moons of Jupiter and Saturn, where subsurface oceans may harbor conditions suitable for life. Advanced telescopes are also scanning distant exoplanets for signs of habitability.

Space-based manufacturing and resource extraction offer potential solutions to resource scarcity on Earth. Asteroid mining could provide access to rare metals and minerals, while microgravity environments enable the production of materials impossible to create on Earth.

International cooperation remains essential for the future of space exploration. Collaborative efforts like the International Space Station demonstrate the benefits of shared resources and expertise in advancing our understanding of space and developing new technologies.

As we look to the future, space exploration promises to expand human horizons, drive technological innovation, and potentially secure the long-term survival of our species beyond Earth.""",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": True,
            "price": 14.99
        },
        {
            "title": "EdTech: Transforming Learning",
            "content": "Educational technology is reshaping how we learn and teach. From virtual reality classrooms to AI-powered personalized learning platforms, EdTech innovations are making education more accessible and effective.",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        },
        {
            "title": "Climate Change and Environmental Protection",
            "content": """Climate change represents one of the most pressing challenges of our time, with far-reaching impacts on ecosystems, economies, and human societies worldwide. The scientific consensus is clear: human activities, particularly the burning of fossil fuels, are the primary driver of recent climate change.

Rising global temperatures are causing polar ice caps to melt, leading to sea level rise that threatens coastal communities. Changes in precipitation patterns are affecting agriculture and water supplies, while more frequent and intense extreme weather events are causing billions of dollars in damages.

Ocean acidification, caused by increased absorption of carbon dioxide, is disrupting marine ecosystems and threatening coral reefs. These changes have cascading effects throughout the food chain, impacting fish populations and the livelihoods of communities that depend on them.

Deforestation contributes significantly to climate change by reducing the number of trees available to absorb carbon dioxide. At the same time, forests play a crucial role in maintaining biodiversity and regulating water cycles.

Renewable energy sources offer a path toward reducing greenhouse gas emissions. Solar, wind, and hydroelectric power are becoming increasingly cost-competitive with fossil fuels, making the transition to clean energy more economically viable.

Individual actions, while important, are not sufficient to address the scale of the challenge. Systemic changes in how we produce energy, transport goods and people, and manage land use are necessary to achieve the emissions reductions required to limit global warming to safe levels.

International cooperation through agreements like the Paris Climate Accord is essential for coordinating global efforts to combat climate change. However, current commitments by countries are still insufficient to meet the accord's goals, highlighting the need for more ambitious action.

The transition to a sustainable future requires investment in clean technologies, changes in consumption patterns, and policies that internalize the environmental costs of economic activities. While the challenge is significant, the potential benefits of avoiding the worst impacts of climate change make this transition not just necessary but economically advantageous in the long term.""",
            "status": ArticleStatus.PUBLISHED,
            "is_premium": False
        }
    ]
    
    # Add articles to database
    for article_data in sample_articles:
        article = Article(**article_data)
        db.add(article)
    
    # Commit changes
    db.commit()
    db.close()
    print(f"Successfully added {len(sample_articles)} sample articles to the database.")

if __name__ == "__main__":
    seed_articles()