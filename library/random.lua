---@meta
-- Like 4 ways to make random things?
-- Wow
-- `math.random`, PcgRandom, PseudoRandom, (ValueNoise, ValueNoiseMap (not included here) )
-- What will be their next invention
-- OH there is securerandom too???? who the hell uses that???
--
--- Unofficial note: PseudoRandom but better
---@class PcgRandom
PcgRandom = {}

---@param seed integer
---@param seq integer[]?
---@return PcgRandom
function PcgRandom(seed, seq) end

-- * `next()`: return next integer random number [`-2147483648`...`2147483647`]
---@return integer
function PcgRandom:next() end

-- * `next(min, max)`: return next integer random number [`min`...`max`]
---@param min integer
---@param max integer
---@return integer
function PcgRandom:next(min, max) end

-- * `rand_normal_dist(min, max, num_trials=6)`: return normally distributed
--   random number [`min`...`max`].
--     * This is only a rough approximation of a normal distribution with:
--     * `mean = (max - min) / 2`, and
--     * `variance = (((max - min + 1) ^ 2) - 1) / (12 * num_trials)`
--     * Increasing `num_trials` improves accuracy of the approximation
---@param min integer
---@param max integer
---@param num_trials integer?
---@return integer
function PcgRandom:rand_normal_dist(min, max, num_trials) end

-- * `get_state()`: return generator state encoded in string
---@return string
function PcgRandom:get_state() end

-- * `set_state(state_string)`: restore generator state from encoded string
---@param state string
function PcgRandom:set_state(state) end

-- `PseudoRandom`
-- --------------
--
-- A 16-bit pseudorandom number generator.
-- Uses a well-known LCG algorithm introduced by K&R.
--
-- **Note**:
-- `PseudoRandom` is slower and has worse random distribution than `PcgRandom`.
-- Use `PseudoRandom` only if you need output to match the well-known LCG algorithm introduced by K&R.
-- Otherwise, use `PcgRandom`.
--
-- * constructor `PseudoRandom(seed)`
--   * `seed`: 32-bit signed number
---@class PseudoRandom
PseudoRandom = {}

---@param seed integer
function PseudoRandom(seed) end

-- * `next()`: return next integer random number [`0`...`32767`]
---@return integer
function PseudoRandom:next() end
-- * `next(min, max)`: return next integer random number [`min`...`max`]
--     * Either `max - min == 32767` or `max - min <= 6553` must be true
--       due to the simple implementation making a bad distribution otherwise.
---@param min integer
---@param max integer
---@return integer
function PseudoRandom:next(min, max) end

-- * `get_state()`: return state of pseudorandom generator as number
--     * use returned number as seed in PseudoRandom constructor to restore
---@return integer
function PseudoRandom:get_state() end

-- `SecureRandom`
-- --------------
--
-- Interface for the operating system's crypto-secure PRNG.
--
-- It can be created via `SecureRandom()`.  The constructor throws an error if a
-- secure random device cannot be found on the system.
--
-- ### Methods
--
-- * `next_bytes([count])`: return next `count` (default 1, capped at 2048) many
--   random bytes, as a string.
---@class SecureRandom
SecureRandom = {}

---@return SecureRandom
function SecureRandom() end

-- * `next_bytes([count])`: return next `count` (default 1, capped at 2048) many
--   random bytes, as a string.
---@return string
---@param count integer
function SecureRandom:next_bytes(count) end
