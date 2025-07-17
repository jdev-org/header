const AUTH_API_URL = '/whoami'
const CONSOLE_PLATFORM_API_URL = '/console/private/platform/infos'

interface WhoAmIResponse {
  GeorchestraUser: {
    roles: string[]
    username: string
    firstName: string
    lastName: string
    ldapWarn: boolean
    ldapRemainingDays: string
  }
}

export interface User {
  username: string
  firstname?: string
  lastname?: string
  anonymous: boolean
  warned: boolean
  remainingDays: string
  roles: string[]
}

export async function getUserDetails(): Promise<User> {
  try {
    const response = await fetch(AUTH_API_URL)

    if (!response.ok) {
      throw new Error(`HTTP error ${response.status}`)
    }

    const json: WhoAmIResponse = await response.json()
    const user = json.GeorchestraUser

    if (!user) {
      throw new Error('Missing GeorchestraUser')
    }

    return {
      username: user.username,
      firstname: user.firstName,
      lastname: user.lastName,
      warned: user.ldapWarn,
      remainingDays: user.ldapRemainingDays,
      anonymous: user.roles.includes('ROLE_ANONYMOUS'),
      roles: user.roles,
    }
  } catch (error) {
    console.warn('[getUserDetails] Fail get user, fallback anonymous :', error)

    return {
      username: 'anonymousUser',
      warned: false,
      remainingDays: '0',
      anonymous: true,
      roles: ['ROLE_ANONYMOUS'],
    }
  }
}

export interface PlatformInfos {
  analyticsEnabled: boolean
  extractorappEnabled: boolean
  saslEnabled: boolean
}

export async function getPlatformInfos(): Promise<PlatformInfos> {
  return fetch(CONSOLE_PLATFORM_API_URL)
    .then(response => response.json())
    .then((json: PlatformInfos) => {
      return {
        analyticsEnabled: json.analyticsEnabled,
        extractorappEnabled: json.extractorappEnabled,
        saslEnabled: json.saslEnabled,
      }
    })
}
