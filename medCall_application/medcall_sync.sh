#!/bin/bash

# models
rsync -Cravzp --progress -e "ssh -p 2222" ~/Projects/medcall/app/Models/ medca403@medcallconsultas.com.br:~/applications/medcall/app/Models/

# controllers
rsync -Cravzp --progress -e "ssh -p 2222" ~/Projects/medcall/app/Http/Controllers/ medca403@medcallconsultas.com.br:~/applications/medcall/app/Http/Controllers/

# repositories
rsync -Cravzp --progress -e "ssh -p 2222" ~/Projects/medcall/app/Http/Repositories/ medca403@medcallconsultas.com.br:~/applications/medcall/app/Http/Repositories/

# routes
rsync -Cravzp --progress -e "ssh -p 2222" ~/Projects/medcall/routes/ medca403@medcallconsultas.com.br:~/applications/medcall/routes/

# views
rsync -Cravzp --progress -e "ssh -p 2222" ~/Projects/medcall/resources/views/ medca403@medcallconsultas.com.br:~/applications/medcall/resources/views/

# public/css
rsync -Cravzp --progress -e "ssh -p 2222" ~/Projects/medcall/public/css/ medca403@medcallconsultas.com.br:~/public_html/medcall/css/

# public/js
rsync -Cravzp --progress -e "ssh -p 2222" ~/Projects/medcall/public/js/ medca403@medcallconsultas.com.br:~/public_html/medcall/js/

