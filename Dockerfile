# Utilizar la imagen oficial de Nginx como base
FROM nginx

# Copiar la configuración del proxy reverso a la ubicación en el contenedor
# COPY nginx.conf /etc/nginx/nginx.conf

# Eliminar el archivo de configuración predeterminado
# RUN rm /etc/nginx/conf.d/default.conf
# Eliminar todos los archivos de configuración existentes
RUN rm /etc/nginx/conf.d/*

# Copiar tu archivo de configuración del proxy reverso a la ubicación en el contenedor
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Exponer el puerto 80 para el tráfico entrante
EXPOSE 80

# Comando para iniciar Nginx cuando se inicie el contenedor
CMD ["nginx", "-g", "daemon off;"]