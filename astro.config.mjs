// https://astro.build/config
import { defineConfig } from 'astro/config';
import image from "@astrojs/image";
import mdx from "@astrojs/mdx";
import tailwind from "@astrojs/tailwind";

// https://astro.build/config
export default defineConfig({
  output: 'static',
  site: "https://www.seriesphotos.app/",
  build: {
    format: 'file'
  },
  integrations: [
    image({
      serviceEntryPoint: '@astrojs/image/sharp'
    }), 
    tailwind(),
    mdx()
]
});
