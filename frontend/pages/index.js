import Head from 'next/head'
import Image from 'next/image'
import styles from '../styles/Home.module.css'


export default function Home() {
  return (
    <section class="text-gray-600 body-font">
  <div class="px-2 py-1 sm:w-full lg:w-1/4">
  
    <div class="rounded-lg overflow-hidden shadow border-1 border-gray-300 bg-white">
      <div class="container py-2">
        <div class="">
          <h3 class="flex pr-16 pl-5 sm:pr-16 text-2xl font-medium title-font text-gray-900">
          Pivoting Lab
          </h3>
        </div>
        <div class="w-full flex justify-between flex-row flex-end items-center lg:mx-auto mb-3">
          <h3 class="flex pr-16 pl-5 text-2xl font-medium title-font text-gray-500">
          1:00:00
          </h3>
          <button class="flex-shrink-0 text-white bg-green-500 border-0 py-2 px-8 focus:outline-none hover:bg-indigo-600 rounded text-lg mr-5 ml:mt-10">Start Lab</button>
        </div>
      </div>
    </div>
  </div>
</section>
  )
}
