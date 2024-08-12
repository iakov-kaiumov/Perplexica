FROM node:slim

ARG SEARXNG_API_URL
ARG OPENAI_API_KEY

WORKDIR /home/perplexica

COPY src /home/perplexica/src
COPY tsconfig.json /home/perplexica/
COPY config.toml /home/perplexica/
COPY drizzle.config.ts /home/perplexica/
COPY package.json /home/perplexica/
COPY yarn.lock /home/perplexica/

RUN echo '[GENERAL]\n\
PORT = 3001\n\
SIMILARITY_MEASURE = "cosine"\n\
\n\
[API_KEYS]\n\
OPENAI = "'"$OPENAI_API_KEY"'"\n\
GROQ = ""\n\
ANTHROPIC = ""\n\
\n\
[API_ENDPOINTS]\n\
SEARXNG = "'"$SEARXNG_API_URL"'"\n\
OLLAMA = ""' > /home/perplexica/config.toml

RUN mkdir /home/perplexica/data

RUN yarn install 
RUN yarn build

CMD ["yarn", "start"]