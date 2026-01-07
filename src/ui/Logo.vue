<script setup lang="ts">
import { state } from '@/shared'
import GeorchestraLogo from '@/ui/GeorchestraLogo.vue'

const props = defineProps<{
  logoUrl?: string
}>()
</script>

<template>
  <img
    v-if="props.logoUrl || state.config.logoUrl"
    :src="props.logoUrl || state.config.logoUrl"
    alt="geOrchestra logo"
    class="w-24 lg:w-32"
    :class="{ 'md:hidden lg:block sm:block': state.config.squareLogoUrl }"
  />
  <GeorchestraLogo v-else></GeorchestraLogo>
  <img
    v-if="state.config?.squareLogoUrl"
    :src="state.config?.squareLogoUrl"
    alt="geOrchestra logo"
    class="max-h-12"
    :class="{ 'lg:hidden md:block hidden': state.config.squareLogoUrl }"
  />
</template>

<style scoped></style>
