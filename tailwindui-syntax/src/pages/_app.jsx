import Head from 'next/head'

import { Layout } from '@/components/Layout'

import 'focus-visible'
import '@/styles/tailwind.css'

export default function App({ Component, pageProps }) {
  let title = pageProps.markdoc?.frontmatter.title
  let description = pageProps.markdoc?.frontmatter.description

  let pageTitle =
    pageProps.markdoc?.frontmatter.pageTitle || pageProps.markdoc?.frontmatter.title

  return (
    <>
      <Head>
        <title>{pageTitle}</title>
        {description && <meta name="description" content={description} />}
      </Head>
      <Layout title={title}>
        <Component {...pageProps} />
      </Layout>
    </>
  )
}
