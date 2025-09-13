
  │ <result>  
  │ <url>https://developers.cloudflare.com/autorag/concepts/how-autorag-works</url>  
  │ <text>  
  │ # AutoRAG > Concepts > How AutoRAG works  
  │   
  │ Here is how the querying pipeline works:  
  │   
  │ 1. **Receive query from AutoRAG API:** The query workflow begins when you send a request to either the AutoRAG’s [AI Search](/autorag/usage/rest-api/#ai-search) or [Search](/autorag/usage/rest-api/#search) endpoints.  
  │ 2. **Query rewriting (optional):** AutoRAG provides the option to [rewrite the input query](/autorag/configuration/query-rewriting/) using one of Workers AI’s LLMs to improve retrieval quality by transforming the original query into a more effective search query.  
  │ 3. **Embedding the query:** The rewritten (or original) query is transformed into a vector via the same embedding model used to embed your data so that it can be compared against your vectorized data to find the most relevant matches.  
  │ 4. **Querying Vectorize index:** The query vector is [queried](/vectorize/best-practices/query-vectors/) against stored vectors in the associated Vectorize database for your AutoRAG.  
  │ 5. **Content retrieval:** Vectorize returns the metadata of the most relevant chunks, and the original content is retrieved from the R2 bucket. If you are using the Search endpoint, the content is returned at this point.  
  │ 6. **Response generation:** If you are using the AI Search endpoint, then a text-generation model from Workers AI is used to generate a response using the retrieved content and the original user’s query, combined via a [system prompt](/autorag/configuration/system-prompt/). The context-aware response from the model is returned.  
  │   
  │ ![Querying](~/assets/images/autorag/querying.png)  
  │ </text>  
  │ </result>  
  │ <result>  
  │ <url>https://developers.cloudflare.com/autorag/concepts/how-autorag-works</url>  
  │ <text>  
  │ # AutoRAG > Concepts > How AutoRAG works  
  │   
  │ AutoRAG sets up and manages your RAG pipeline for you. It connects the tools needed for indexing, retrieval, and generation, and keeps everything up to date by syncing with your data with the index regularly. Once set up, AutoRAG indexes your content in the background and responds to queries in real time.  
  │   
  │ AutoRAG consists of two core processes:  
  │   
  │ - **Indexing:** An asynchronous background process that monitors your data source for changes and converts your data into vectors for search.  
  │ - **Querying:** A synchronous process triggered by user queries. It retrieves the most relevant content and generates context-aware responses.  
  │   
  │ ## How indexing works  
  │   
  │ Indexing begins automatically when you create an AutoRAG instance and connect a data source.  
  │   
  │ Here is what happens during indexing:  
  │   
  │ 1. **Data ingestion:** AutoRAG reads from your connected data source.  
  │ 2. **Markdown conversion:** AutoRAG uses [Workers AI’s Markdown Conversion](/workers-ai/features/markdown-conversion/) to convert [supported data types](/autorag/configuration/data-source/) into structured Markdown. This ensures consistency across diverse file types. For images, Workers AI is used to perform object detection followed by vision-to-language transformation to convert images into Markdown text.  
  │ 3. **Chunking:** The extracted text is [chunked](/autorag/configuration/chunking/) into smaller pieces to improve retrieval granularity.  
  │ 4. **Embedding:** Each chunk is embedded using Workers AI’s embedding model to transform the content into vectors.  
  │ 5. **Vector storage:** The resulting vectors, along with metadata like file name, are stored in a the [Vectorize](/vectorize/) database created on your Cloudflare account.  
  │   
  │ After the initial data set is indexed, AutoRAG will regularly check for updates in your data source (e.g. additions, updates, or deletes) and index changes to ensure your vector database is up to date.  
  │   
  │ ![Indexing](~/assets/images/autorag/indexing.png)  
  │   
  │ ## How querying works  
  │   
  │ Once indexing is complete, AutoRAG is ready to respond to end-user queries in real time.  
  │   
  │ </text>  
  │ </result>  
  │ <result>  
  │ <url>https://developers.cloudflare.com/autorag/configuration/indexing</url>  
  │ <text>  
  │ # AutoRAG > Configuration > Indexing  
  │   
  │ AutoRAG automatically indexes your data into vector embeddings optimized for semantic search. Once a data source is connected, indexing runs continuously in the background to keep your knowledge base fresh and queryable.  
  │   
  │ ## Jobs  
  │   
  │ AutoRAG automatically monitors your data source for updates and reindexes your content **every 4 hours**. During each cycle, only new or modified files are reprocessed to keep your Vectorize index up to date.  
  │   
  │ ## Controls  
  │   
  │ You can control indexing behavior through the following actions on the dashboard:  
  │   
  │ - **Sync Index**: Force AutoRAG to scan your data source for new or modified files and initiate an indexing job to update the associated Vectorize index. A new indexing job can be initiated every 5 minutes.  
  │ - **Pause Indexing**: Temporarily stop all scheduled indexing checks and reprocessing. Useful for debugging or freezing your knowledge base.  
  │   
  │ ## Performance  
  │   
  │ AutoRAG processes files in parallel for efficient indexing. The total time to index depends on the number and type of files in your data source.  
  │   
  │ Factors that affect performance include:  
  │   
  │ - Total number of files and their sizes  
  │ - File formats (for example, images take longer than plain text)  
  │ - Latency of Workers AI models used for embedding and image processing  
  │   
  │ ## Best practices  
  │   
  │ To ensure smooth and reliable indexing:  
  │   
  │ - Make sure your files are within the [**size limit**](/autorag/platform/limits-pricing/#limits) and in a supported format to avoid being skipped.  
  │ - Keep your Service API token valid to prevent indexing failures.  
  │ - Regularly clean up outdated or unnecessary content in your knowledge base to avoid hitting [Vectorize index limits](/vectorize/platform/limits/).  
  │ </text>  
  │ </result>  
  │ <result>  
  │ <url>https://developers.cloudflare.com/autorag/get-started</url>  
  │ <text>  
  │ # AutoRAG > Getting started  
  │   
  │ AutoRAG allows developers to create fully managed retrieval-augmented generation (RAG) pipelines to power AI applications with accurate and up-to-date information without needing to manage infrastructure.  
  │   
  │ ## 1. Upload data or use existing data in R2  
  │   
  │ AutoRAG integrates with R2 for data import. Create an R2 bucket if you do not have one and upload your data.  
  │   
  │ :::note  
  │ Before you create your first bucket, you must purchase R2 from the Cloudflare dashboard.  
  │ :::  
  │   
  │ To create and upload objects to your bucket from the Cloudflare dashboard:  
  │   
  │ 1. Log in to the [Cloudflare dashboard](https://dash.cloudflare.com/?to=/:account/r2) and select **R2**.  
  │ 2. Select Create bucket, name the bucket, and select **Create bucket**.  
  │ 3. Choose to either drag and drop your file into the upload area or **select from computer**. Review the [file limits](/autorag/configuration/data-source/) when creating your knowledge base.  
  │   
  │ _If you need inspiration for what document to use to make your first AutoRAG, try downloading and uploading the [RSS](/changelog/rss/index.xml) of the [Cloudflare Changelog](/changelog/)._  
  │   
  │ ## 2. Create an AutoRAG  
  │   
  │ To create a new AutoRAG:  
  │   
  │ 1. Log in to the [Cloudflare dashboard](https://dash.cloudflare.com/?to=/:account/ai/autorag) and select **AI** > **AutoRAG**.  
  │ 2. Select **Create AutoRAG**, configure the AutoRAG, and complete the setup process.  
  │ 3. Select **Create**.  
  │   
  │ ## 3. Monitor indexing  
  │   
  │ Once created, AutoRAG will create a Vectorize index in your account and begin indexing the data.  
  │   
  │ To monitor the indexing progress:  
  │   
  │ 1. From the **AutoRAG** page in the dashboard, locate and select your AutoRAG.  
  │ 2. Navigate to the **Overview** page to view the current indexing status.  
  │   
  │ ## 4. Try it out  
  │   
  │ Once indexing is complete, you can run your first query:  
  │   
  │ </text>  
  │ </result>  
  │ <result>  
  │ <url>https://developers.cloudflare.com/autorag/usage/rest-api</url>  
  │ <text>  
  │ # AutoRAG > Usage > REST API  
  │   
  │ This guide will instruct you through how to use the AutoRAG REST API to make a query to your AutoRAG.  
  │   
  │ ## Prerequisite: Get AutoRAG API token  
  │   
  │ You need an API token with the `AutoRAG - Read` and `AutoRAG Edit` permissions to use the REST API. To create a new token:  
  │   
  │ 1. Log in to the [Cloudflare dashboard](https://dash.cloudflare.com) and select your account.  
  │ 2. Go to **AI** > **AutoRAG** and select your AutoRAG.  
  │ 3. Select **Use AutoRAG** then select **API**.  
  │ 4. Select **Create an API Token**.  
  │ 5. Review the prefilled information then select **Create API Token**.  
  │ 6. Select **Copy API Token** and save that value for future use.  
  │   
  │ ## AI Search  
  │   
  │ This REST API searches for relevant results from your data source and generates a response using the model and the retrieved relevant context:  
  │   
  │ ```bash  
  │   
  │ curl https://api.cloudflare.com/client/v4/accounts/{ACCOUNT_ID}/autorag/rags/{AUTORAG_NAME}/ai-search \  
  │ -H 'Content-Type: application/json' \  
  │ -H "Authorization: Bearer {API_TOKEN}" \  
  │ -d '{  
  │ 	"query": "How do I train a llama to deliver coffee?",  
  │ 	"model": @cf/meta/llama-3.3-70b-instruct-sd,  
  │ 	"rewrite_query": false,  
  │ 	"max_num_results": 10,  
  │ 	"ranking_options": {  
  │ 		"score_threshold": 0.3  
  │ 	},  
  │ 	"stream": true,  
  │ }'  
  │   
  │ ```  
  │   
  │ :::note  
  │   
  │ You can get your `ACCOUNT_ID` by navigating to [Workers & Pages on the dashboard](/fundamentals/setup/find-account-and-zone-ids/#find-account-id-workers-and-pages).  
  │   
  │ :::  
  │   
  │ ### Parameters  
  │   
  │ `query` <Type text="string" /> <MetaInfo text="required" />  
  │   
  │ The input query.  
  │   
  │ `model` <Type text="string" /> <MetaInfo text="optional" />  
  │   
  │ </text>  
  │ </result>  
  │ <result>  
  │ <url>https://developers.cloudflare.com/autorag/configuration/chunking</url>  
  │ <text>  
  │ # AutoRAG > Configuration > Chunking  
  │   
  │ Chunking is the process of splitting large data into smaller segments before embedding them for search. AutoRAG uses **recursive chunking**, which breaks your content at natural boundaries (like paragraphs or sentences), and then further splits it if the chunks are too large.  
  │   
  │ ## What is recursive chunking  
  │   
  │ Recursive chunking tries to keep chunks meaningful by:  
  │   
  │ - **Splitting at natural boundaries:** like paragraphs, then sentences.  
  │ - **Checking the size:** if a chunk is too long (based on token count), it’s split again into smaller parts.  
  │   
  │ This way, chunks are easy to embed and retrieve, without cutting off thoughts mid-sentence.  
  │   
  │ ## Chunking controls  
  │   
  │ AutoRAG exposes two parameters to help you control chunking behavior:  
  │   
  │ - **Chunk size**: The number of tokens per chunk.  
  │   - Minimum: `64`  
  │   - Maximum: `512`  
  │ - **Chunk overlap**: The percentage of overlapping tokens between adjacent chunks.  
  │   - Minimum: `0%`  
  │   - Maximum: `30%`  
  │   
  │ These settings apply during the indexing step, before your data is embedded and stored in Vectorize.  
  │   
  │ ## Choosing chunk size and overlap  
  │   
  │ Chunking affects both how your content is retrieved and how much context is passed into the generation model. Try out this external [chunk visualizer tool](https://huggingface.co/spaces/m-ric/chunk_visualizer) to help understand how different chunk settings could look.  
  │   
  │ For chunk size, consider how:  
  │   
  │ - **Smaller chunks** create more precise vector matches, but may split relevant ideas across multiple chunks.  
  │ - **Larger chunks** retain more context, but may dilute relevance and reduce retrieval precision.  
  │   
  │ For chunk overlap, consider how:  
  │   
  │ - **More overlap** helps preserve continuity across boundaries, especially in flowing or narrative content.  
  │ - **Less overlap** reduces indexing time and cost, but can miss context if key terms are split between chunks.  
  │   
  │ ### Additional considerations:  
  │   
  │ - **Vector index size:** Smaller chunk sizes produce more chunks and more total vectors. Refer to the [Vectorize limits](/vectorize/platform/limits/) to ensure your configuration stays within the maximum allowed vectors per index.  
  │ </text>  
  │ </result>  
  │ <result>  
  │ <url>https://developers.cloudflare.com/autorag/</url>  
  │ <text>  
  │ # AutoRAG > Overview  
  │   
  │ <Description>  
  │ 	Create fully-managed RAG pipelines to power your AI applications with accurate  
  │ 	and up-to-date information.  
  │ </Description>  
  │   
  │ Available on all plans  
  │   
  │ AutoRAG lets you create fully-managed, retrieval-augmented generation (RAG) pipelines that continuously updates and scales on Cloudflare. With AutoRAG, you can integrate context-aware AI into your applications without managing infrastructure.  
  │   
  │ You can use AutoRAG to build:  
  │   
  │ - **Product Chatbot:** Answer customer questions using your own product content.  
  │ - **Docs Search:** Make documentation easy to search and use.  
  │   
  │ <div>  
  │ 	<LinkButton href="/autorag/get-started">Get started</LinkButton>  
  │ 	<LinkButton  
  │ 		target="_blank"  
  │ 		variant="secondary"  
  │ 		icon="external"  
  │ 		href="https://www.youtube.com/watch?v=JUFdbkiDN2U"  
  │ 	>  
  │ 		Watch AutoRAG demo  
  │ 	</LinkButton>  
  │ </div>  
  │   
  │ ---  
  │   
  │ ## Features  
  │   
  │ <Feature header="Automated indexing" href="/autorag/configuration/indexing/" cta="View indexing">  
  │   
  │ Automatically and continuously index your data source, keeping your content fresh without manual reprocessing.  
  │   
  │ </Feature>  
  │   
  │ <Feature header="Multitenancy support" href="/autorag/how-to/multitenancy/" cta="Add filters">  
  │   
  │ Create multitenancy by scoping search to each tenant’s data using folder-based metadata filters.  
  │   
  │ </Feature>  
  │   
  │ <Feature header="Workers Binding" href="/autorag/usage/workers-binding/" cta="Add to Worker">  
  │   
  │ Call your AutoRAG instance for search or AI Search directly from a Cloudflare Worker using the native binding integration.  
  │   
  │ </Feature>  
  │   
  │ <Feature header="Similarity caching" href="/autorag/configuration/cache/" cta="Use caching">  
  │   
  │ Cache repeated queries and results to improve latency and reduce compute on repeated requests.  
  │   
  │ </Feature>  
  │   
  │ ---  
  │   
  │ ## Related products  
  │   
  │ <RelatedProduct header="Workers AI" href="/workers-ai/" product="workers-ai">  
  │   
  │ Run machine learning models, powered by serverless GPUs, on Cloudflare’s global network.  
  │   
  │ </text>  
  │ </result>  
  │ <result>  
  │ <url>https://developers.cloudflare.com/autorag/get-started</url>  
  │ <text>  
  │ # AutoRAG > Getting started  
  │   
  │ 1. From the **AutoRAG** page in the dashboard, locate and select your AutoRAG.  
  │ 2. Navigate to the **Playground** page.  
  │ 3. Select **Search with AI** or **Search**.  
  │ 4. Enter a **query** to test out its response.  
  │   
  │ ## 5. Add to your application  
  │   
  │ There are multiple ways you can add AutoRAG to your applications:  
  │   
  │ - [Workers Binding](/autorag/usage/workers-binding/)  
  │ - [REST API](/autorag/usage/rest-api/)  
  │ </text>  
  │ </result>  
  │ <result>  
  │ <url>https://developers.cloudflare.com/autorag/configuration/retrieval-configuration</url>  
  │ <text>  
  │ # AutoRAG > Configuration > Retrieval configuration  
  │   
  │ AutoRAG allows you to configure how content is retrieved from your vector index and used to generate a final response. Two options control this behavior:  
  │   
  │ - **Match threshold**: Minimum similarity score required for a vector match to be considered relevant.  
  │ - **Maximum number of results**: Maximum number of top-matching results to return (`top_k`).  
  │   
  │ AutoRAG uses the [`query()`](/vectorize/best-practices/query-vectors/) method from [Vectorize](/vectorize/) to perform semantic search. This function compares the embedded query vector against the stored vectors in your index and returns the most similar results.  
  │   
  │ ## Match threshold  
  │   
  │ The `match_threshold` sets the minimum similarity score (for example, cosine similarity) that a document chunk must meet to be included in the results. Threshold values range from `0` to `1`.  
  │   
  │ - A higher threshold means stricter filtering, returning only highly similar matches.  
  │ - A lower threshold allows broader matches, increasing recall but possibly reducing precision.  
  │   
  │ ## Maximum number of results  
  │   
  │ This setting controls the number of top-matching chunks returned by Vectorize after filtering by similarity score. It corresponds to the `topK` parameter in `query()`. The maximum allowed value is 50.  
  │   
  │ - Use a higher value if you want to synthesize across multiple documents. However, providing more input to the model can increase latency and cost.  
  │ - Use a lower value if you prefer concise answers with minimal context.  
  │   
  │ ## How they work together  
  │   
  │ AutoRAG's retrieval step follows this sequence:  
  │   
  │ 1. Your query is embedded using the configured Workers AI model.  
  │ 2. `query()` is called to search the Vectorize index, with `topK` set to the `maximum_number_of_results`.  
  │ 3. Results are filtered using the `match_threshold`.  
  │ 4. The filtered results are passed into the generation step as context.  
  │   
  │ If no results meet the threshold, AutoRAG will not generate a response.  
  │   
  │ ## Configuration  
  │   
  │ These values can be configured at the AutoRAG instance level or overridden on a per-request basis using the [REST API](/autorag/usage/rest-api/) or the [Workers Binding](/autorag/usage/workers-binding/).  
  │   
  │ </text>  
  │ </result>  
  │ <result>  
  │ <url>https://developers.cloudflare.com/autorag/configuration/query-rewriting</url>  
  │ <text>  
  │ # AutoRAG > Configuration > Query rewriting  
  │   
  │ Query rewriting is an optional step in the AutoRAG pipeline that improves retrieval quality by transforming the original user query into a more effective search query.  
  │   
  │ Instead of embedding the raw user input directly, AutoRAG can use a large language model (LLM) to rewrite the query based on a system prompt. The rewritten query is then used to perform the vector search.  
  │   
  │ ## Why use query rewriting?  
  │   
  │ The wording of a user’s question may not match how your documents are written. Query rewriting helps bridge this gap by:  
  │   
  │ - Rephrasing informal or vague queries into precise, information-dense terms  
  │ - Adding synonyms or related keywords  
  │ - Removing filler words or irrelevant details  
  │ - Incorporating domain-specific terminology  
  │   
  │ This leads to more relevant vector matches which improves the accuracy of the final generated response.  
  │   
  │ ## Example  
  │   
  │ **Original query:** `how do i make this work when my api call keeps failing?`  
  │   
  │ **Rewritten query:** `API call failure troubleshooting authentication headers rate limiting network timeout 500 error`  
  │   
  │ In this example, the original query is conversational and vague. The rewritten version extracts the core problem (API call failure) and expands it with relevant technical terms and likely causes. These terms are much more likely to appear in documentation or logs, improving semantic matching during vector search.  
  │   
  │ ## How it works  
  │   
  │ If query rewriting is enabled, AutoRAG performs the following:  
  │   
  │ 1. Sends the **original user query** and the **query rewrite system prompt** to the configured LLM  
  │ 2. Receives the **rewritten query** from the model  
  │ 3. Embeds the rewritten query using the selected embedding model  
  │ 4. Performs vector search in your AutoRAG’s Vectorize index  
  │   
  │ For details on how to guide model behavior during this step, see the [system prompt](/autorag/configuration/system-prompt/) documentation.  
  │ </text>  
  │ </result>  

